import 'dart:async';

import 'package:common/constants.dart';
import 'package:common/model/device.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:p2p/src/network/send_provider.dart';
import 'package:p2p/src/network/p2p_settings.dart';
import 'package:p2p/src/network/nearby_devices_provider.dart';
import 'package:p2p/src/network/security_provider.dart'; // contains PersistenceService
import 'package:p2p/src/rust/api/crypto.dart' as crypto;
import 'package:p2p/src/rust/api/model.dart' as rust;
import 'package:p2p/src/rust/api/webrtc.dart';
import 'package:p2p/src/network/webrtc/webrtc_receiver.dart';
import 'package:refena_flutter/refena_flutter.dart';

part 'signaling_provider.mapper.dart';

@MappableClass()
class SignalingState with SignalingStateMappable {
  final List<String> signalingServers;
  final List<String> stunServers;
  final Map<String, LsSignalingConnection> connections;

  SignalingState({
    required this.signalingServers,
    required this.stunServers,
    required this.connections,
  });
}

final signalingProvider =
    ReduxProvider<SignalingService, SignalingState>((ref) {
  return SignalingService(
    persistence: ref.read(persistenceProvider),
  );
});

class SignalingService extends ReduxNotifier<SignalingState> {
  final PersistenceService _persistence;

  SignalingService({
    required PersistenceService persistence,
  }) : _persistence = persistence;

  @override
  SignalingState init() {
    return SignalingState(
      signalingServers: _persistence.getSignalingServers() ??
          ['wss://public.localsend.org/v1/ws'],
      stunServers:
          _persistence.getStunServers() ?? ['stun:stun.localsend.org:5349'],
      connections: {},
    );
  }
}

class SetupSignalingConnection
    extends ReduxAction<SignalingService, SignalingState> with GlobalActions {
  @override
  SignalingState reduce() {
    for (final signalingServer in state.signalingServers) {
      // ignore: discarded_futures
      global.dispatchAsync(
          _SetupSignalingConnection(signalingServer: signalingServer));
    }
    return state;
  }
}

/// Starts an endless running action.
class _SetupSignalingConnection extends AsyncGlobalAction {
  final String signalingServer;

  _SetupSignalingConnection({required this.signalingServer});

  @override
  Future<void> reduce() async {
    final settings = ref.read(p2pSettingsProvider);
    final deviceInfo = ref.read(deviceFullInfoProvider);

    // TODO: Use persistent key
    final key = await crypto.generateKeyPair();
    print('private key: ${key.privateKey}');

    final stream = connect(
      uri: 'wss://public.localsend.org/v1/ws',
      info: ProposingClientInfo(
        alias: settings.alias,
        version: protocolVersion,
        deviceModel: deviceInfo.deviceModel,
        deviceType: deviceInfo.deviceType.toRustDeviceType(),
      ),
      privateKey: key.privateKey,
      onConnection: (c) {
        ref.redux(signalingProvider).dispatch(
              _SetConnectionAction(
                signalingServer: signalingServer,
                connection: c,
              ),
            );
      },
    );

    try {
      await for (final message in stream) {
        switch (message) {
          case WsServerMessage_Hello():
            for (final d in message.peers) {
              ref.redux(nearbyDevicesProvider).dispatch(
                    RegisterSignalingDeviceAction(
                      d.toDevice(signalingServer),
                    ),
                  );
            }
            break;
          case WsServerMessage_Join(peer: final peer):
          case WsServerMessage_Update(peer: final peer):
            ref.redux(nearbyDevicesProvider).dispatch(
                  RegisterSignalingDeviceAction(
                    peer.toDevice(signalingServer),
                  ),
                );
            break;
          case WsServerMessage_Left():
            ref.redux(nearbyDevicesProvider).dispatch(
                  UnregisterSignalingDeviceAction(
                    message.peerId.uuid,
                  ),
                );
            break;
          case WsServerMessage_Offer(:final field0):
            final c = ref.read(signalingProvider).connections[signalingServer];
            if (c == null) {
              print('Error: Connection not found for $signalingServer');
              return;
            }
            final controller = await c.acceptOffer(
              stunServers: ref.read(signalingProvider).stunServers,
              offer: field0,
              privateKey: key.privateKey,
            );
            // ignore: use_of_void_result
            ref.redux(webRTCReceiveProvider).dispatch(InitializeWebRtcAction(
                  controller: controller,
                  sessionId: field0.sessionId,
                  device: field0.peer.toDevice(signalingServer),
                ));
            break;
          case WsServerMessage_Answer():
          case WsServerMessage_Error():
        }
      }
    } finally {
      ref
          .redux(signalingProvider)
          .dispatch(_RemoveConnectionAction(signalingServer: signalingServer));
    }
  }
}

class _SetConnectionAction
    extends ReduxAction<SignalingService, SignalingState> {
  final String signalingServer;
  final LsSignalingConnection connection;

  _SetConnectionAction({
    required this.signalingServer,
    required this.connection,
  });

  @override
  SignalingState reduce() {
    return state.copyWith(
      connections: {
        ...state.connections,
        signalingServer: connection,
      },
    );
  }
}

class _RemoveConnectionAction
    extends ReduxAction<SignalingService, SignalingState> {
  final String signalingServer;

  _RemoveConnectionAction({required this.signalingServer});

  @override
  SignalingState reduce() {
    return state.copyWith(
      connections: {
        for (final entry in state.connections.entries)
          if (entry.key != signalingServer) entry.key: entry.value,
      },
    );
  }
}

extension ClientInfoExt on ClientInfo {
  Device toDevice(String signalingServer) {
    return Device(
      signalingId: id.uuid,
      ip: null,
      version: version,
      port: -1,
      https: false,
      fingerprint: token,
      alias: alias,
      deviceModel: deviceModel,
      deviceType: deviceType?.toDeviceType() ?? DeviceType.desktop,
      download: false,
      discoveryMethods: {
        SignalingDiscovery(
          signalingServer: signalingServer,
        ),
      },
    );
  }
}

extension on rust.DeviceType {
  DeviceType toDeviceType() {
    return switch (this) {
      rust.DeviceType.mobile => DeviceType.mobile,
      rust.DeviceType.desktop => DeviceType.desktop,
      rust.DeviceType.web => DeviceType.web,
      rust.DeviceType.headless => DeviceType.headless,
      rust.DeviceType.server => DeviceType.server,
    };
  }
}

extension on DeviceType {
  rust.DeviceType toRustDeviceType() {
    return switch (this) {
      DeviceType.mobile => rust.DeviceType.mobile,
      DeviceType.desktop => rust.DeviceType.desktop,
      DeviceType.web => rust.DeviceType.web,
      DeviceType.headless => rust.DeviceType.headless,
      DeviceType.server => rust.DeviceType.server,
    };
  }
}
