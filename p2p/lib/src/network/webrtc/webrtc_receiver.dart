import 'package:common/model/device.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:p2p/src/rust/api/model.dart';
import 'package:p2p/src/rust/api/webrtc.dart';
import 'package:refena_flutter/refena_flutter.dart';

part 'webrtc_receiver.mapper.dart';

@MappableClass()
class WebRTCReceiveState with WebRTCReceiveStateMappable {
  final RtcReceiveController? controller;
  final String? sessionId;
  final Device? device;
  final List<FileDto> files;
  final RTCStatus? status;

  const WebRTCReceiveState({
    this.controller,
    this.sessionId,
    this.device,
    this.files = const [],
    this.status,
  });
}

final webRTCReceiveProvider =
    ReduxProvider<WebRTCReceiveService, WebRTCReceiveState>((ref) {
  return WebRTCReceiveService();
});

class WebRTCReceiveService extends ReduxNotifier<WebRTCReceiveState> {
  @override
  WebRTCReceiveState init() {
    return const WebRTCReceiveState();
  }
}

class InitializeWebRtcAction
    extends ReduxAction<WebRTCReceiveService, WebRTCReceiveState> {
  final RtcReceiveController controller;
  final String sessionId;
  final Device device;

  InitializeWebRtcAction({
    required this.controller,
    required this.sessionId,
    required this.device,
  });

  @override
  WebRTCReceiveState reduce() {
    // Listen to streams
    // ignore: discarded_futures
    controller.listenFiles().then((files) {
      dispatch(_SetFilesAction(files));
    });

    controller.listenStatus().listen((status) {
      dispatch(_SetStatusAction(status));
    });

    return state.copyWith(
      controller: controller,
      sessionId: sessionId,
      device: device,
      files: [],
      status: const RTCStatus.connected(),
    );
  }
}

class CloseWebRtcAction
    extends ReduxAction<WebRTCReceiveService, WebRTCReceiveState> {
  @override
  WebRTCReceiveState reduce() {
    state.controller?.decline(); // Ensure it is closed
    return const WebRTCReceiveState();
  }
}

class _SetFilesAction
    extends ReduxAction<WebRTCReceiveService, WebRTCReceiveState> {
  final List<FileDto> files;

  _SetFilesAction(this.files);

  @override
  WebRTCReceiveState reduce() {
    return state.copyWith(files: files);
  }
}

class _SetStatusAction
    extends ReduxAction<WebRTCReceiveService, WebRTCReceiveState> {
  final RTCStatus status;

  _SetStatusAction(this.status);

  @override
  WebRTCReceiveState reduce() {
    return state.copyWith(status: status);
  }
}
