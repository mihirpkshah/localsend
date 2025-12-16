import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:common/api_route_builder.dart';
import 'package:common/constants.dart';
import 'package:common/model/device.dart';
import 'package:common/model/dto/info_dto.dart';
import 'package:common/model/dto/info_register_dto.dart';
import 'package:common/model/dto/prepare_upload_request_dto.dart';
import 'package:common/model/dto/register_dto.dart';
import 'package:common/model/file_status.dart';
import 'package:common/model/session_status.dart';
import 'package:logging/logging.dart';
import 'package:p2p/src/model/state/send/send_session_state.dart';
import 'package:p2p/src/model/state/server/receive_session_state.dart';
import 'package:p2p/src/model/state/server/receiving_file.dart';
import 'package:p2p/src/network/nearby_devices_provider.dart';
import 'package:p2p/src/network/progress_provider.dart';
import 'package:p2p/src/network/send_provider.dart';
import 'package:p2p/src/network/server/server_provider.dart';
import 'package:p2p/src/network/server/server_utils.dart';
import 'package:p2p/src/util/simple_server.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final _logger = Logger('ReceiveController');

/// Handles all requests for receiving files.
class ReceiveController {
  final ServerUtils server;

  ReceiveController(this.server);

  /// Installs all routes for receiving files.
  void installRoutes({
    required SimpleServerRouteBuilder router,
    required String alias,
    required int port,
    required bool https,
    required String fingerprint,
  }) {
    router.get(ApiRoute.info.v1, (HttpRequest request) async {
      return await _infoHandler(
          request: request, alias: alias, fingerprint: fingerprint);
    });

    router.get(ApiRoute.info.v2, (HttpRequest request) async {
      return await _infoHandler(
          request: request, alias: alias, fingerprint: fingerprint);
    });

    router.post(ApiRoute.register.v1, (HttpRequest request) async {
      return await _registerHandler(
          request: request,
          alias: alias,
          port: port,
          https: https,
          fingerprint: fingerprint);
    });

    router.post(ApiRoute.register.v2, (HttpRequest request) async {
      return await _registerHandler(
          request: request,
          alias: alias,
          port: port,
          https: https,
          fingerprint: fingerprint);
    });

    router.post(ApiRoute.prepareUpload.v1, (HttpRequest request) async {
      return await _prepareUploadHandler(
          request: request, port: port, https: https, v2: false);
    });

    router.post(ApiRoute.prepareUpload.v2, (HttpRequest request) async {
      return await _prepareUploadHandler(
          request: request, port: port, https: https, v2: true);
    });

    router.post(ApiRoute.upload.v1, (HttpRequest request) async {
      return await _uploadHandler(request: request, v2: false);
    });

    router.post(ApiRoute.upload.v2, (HttpRequest request) async {
      return await _uploadHandler(request: request, v2: true);
    });

    router.post(ApiRoute.cancel.v1, (HttpRequest request) async {
      return await _cancelHandler(request: request, v2: false);
    });

    router.post(ApiRoute.cancel.v2, (HttpRequest request) async {
      return await _cancelHandler(request: request, v2: true);
    });
  }

  Future<void> _infoHandler({
    required HttpRequest request,
    required String alias,
    required String fingerprint,
  }) async {
    final senderFingerprint = request.uri.queryParameters['fingerprint'];
    if (senderFingerprint == fingerprint) {
      return await request.respondJson(412, message: 'Self-discovered');
    }

    final deviceInfo = server.ref.read(deviceFullInfoProvider);

    final dto = InfoDto(
      alias: alias,
      version: protocolVersion,
      deviceModel: deviceInfo.deviceModel,
      deviceType: deviceInfo.deviceType,
      fingerprint: fingerprint,
      download: server.getState().webSendState != null,
    );

    return await request.respondJson(200, body: dto.toJson());
  }

  Future<void> _registerHandler({
    required HttpRequest request,
    required String alias,
    required String fingerprint,
    required int port,
    required bool https,
  }) async {
    final payload = await request.readAsString();
    final RegisterDto requestDto;
    try {
      requestDto = RegisterDto.fromJson(jsonDecode(payload));
    } catch (e) {
      return await request.respondJson(400, message: 'Request body malformed');
    }

    if (requestDto.fingerprint == fingerprint) {
      return await request.respondJson(412, message: 'Self-discovered');
    }

    await server.ref.redux(nearbyDevicesProvider).dispatchAsync(
        RegisterDeviceAction(requestDto.toDevice(
            request.ip, port, https, HttpDiscovery(ip: request.ip))));

    // Logger commented out as discoveryLoggerProvider is not available in p2p
    // server.ref.notifier(discoveryLoggerProvider).addLog(...);

    final deviceInfo = server.ref.read(deviceFullInfoProvider);

    final responseDto = InfoDto(
      alias: alias,
      version: protocolVersion,
      deviceModel: deviceInfo.deviceModel,
      deviceType: deviceInfo.deviceType,
      fingerprint: fingerprint,
      download: server.getState().webSendState != null,
    );

    return await request.respondJson(200, body: responseDto.toJson());
  }

  Future<void> _prepareUploadHandler({
    required HttpRequest request,
    required int port,
    required bool https,
    required bool v2,
  }) async {
    if (server.getState().session != null) {
      return await request.respondJson(409,
          message: 'Blocked by another session');
    }

    // PIN check logic commented out for refactor
    /*
    final pinCorrect = await checkPin(...);
    if (!pinCorrect) {
      return;
    }
    */

    final PrepareUploadRequestDto dto;
    try {
      final payload = await request.readAsString();
      dto = PrepareUploadRequestDto.fromJson(jsonDecode(payload));
    } catch (e) {
      return await request.respondJson(400, message: 'Request body malformed');
    }

    if (dto.files.isEmpty) {
      return await request.respondJson(400,
          message: 'Request must contain at least one file');
    }

    // Default settings for p2p
    final destinationDir = ''; // TODO: Abstract destination directory
    final cacheDir = ''; // TODO: Abstract cache directory
    final sessionId = _uuid.v4();

    _logger.info('Session Id: $sessionId');

    final streamController = StreamController<Map<String, String>?>();
    server.setState(
      (oldState) => oldState?.copyWith(
        session: ReceiveSessionState(
          sessionId: sessionId,
          status: SessionStatus.waiting,
          sender: dto.info.toDevice(request.ip, port, https, null),
          senderAlias: dto.info.alias, // No favorites provider
          files: {
            for (final file in dto.files.values)
              file.id: ReceivingFile(
                file: file,
                status: FileStatus.queue,
                token: null,
                desiredName: null,
                path: null,
                savedToGallery: false,
                errorMessage: null,
              ),
          },
          startTime: null,
          endTime: null,
          destinationDirectory: destinationDir,
          cacheDirectory: cacheDir,
          saveToGallery: false, // No favorites provider
          createdDirectories: {},
          responseHandler: streamController,
        ),
      ),
    );

    final message = server.getState().session?.message;
    if (message != null) {
      // Handle message receipt
      // Notify listener
      server.ref.notifier(serverProvider).notifyMessageReceived(message);

      // Auto accept for message (finish session)
      closeSession();
      return await request.respondJson(204);
    }

    // For files, we default to reject in this simplified version if no listener decides.
    // TODO: Implement a session request listener in ServerProvider
    // For now, auto-reject files

    closeSession();
    return await request.respondJson(403,
        message: 'File request declined (p2p default)');
  }

  Future<void> _uploadHandler({
    required HttpRequest request,
    required bool v2,
  }) async {
    // Simplified upload handler - rejects everything for now as we don't handle file saving in this MVP
    return await request.respondJson(500,
        message: 'File upload not implemented in p2p simplified controller');
  }

  Future<void> _cancelHandler({
    required HttpRequest request,
    required bool v2,
  }) async {
    // ... Simplified cancel handler logic ...
    // Reuse existing logic but simplified
    final receiveSession = server.getState().session;
    if (receiveSession != null) {
      if (!v2 && receiveSession.sender.version != '1.0') {
        return await request.respondJson(403, message: 'No permission');
      }
      if (receiveSession.sender.ip != request.ip) {
        return await request.respondJson(403, message: 'No permission');
      }
      if (v2 && receiveSession.status != SessionStatus.waiting) {
        final sessionId = request.uri.queryParameters['sessionId'];
        if (sessionId != receiveSession.sessionId) {
          return await request.respondJson(403, message: 'No permission');
        }
      }
      _cancelBySender(server);
      return await request.respondJson(200);
    } else {
      final sessionId = request.uri.queryParameters['sessionId'];
      final sendSessions = server.ref.read(sendProvider);
      final SendSessionState? sendState;
      if (v2) {
        sendState = sendSessions.values
            .firstWhereOrNull((s) => s.remoteSessionId == sessionId);
        if (sendState == null) {
          return await request.respondJson(403, message: 'No permission');
        }
      } else {
        sendState = sendSessions.values.singleOrNull;
        if (sendState == null) {
          return await request.respondJson(403, message: 'No permission');
        }
      }

      if (sendState.target.ip != request.ip) {
        return await request.respondJson(403, message: 'No permission');
      }
      if (sendState.status != SessionStatus.sending) {
        return await request.respondJson(403, message: 'No permission');
      }

      server.ref
          .notifier(sendProvider)
          .cancelSessionByReceiver(sendState.sessionId);
      return await request.respondJson(200);
    }
  }

  void acceptFileRequest(Map<String, String> fileNameMap) {
    // ...
  }

  void declineFileRequest() {
    // ...
  }

  void setSessionDestinationDir(String destinationDirectory) {
    // ...
  }

  void setSessionSaveToGallery(bool saveToGallery) {
    // ...
  }

  void cancelSession() async {
    final session = server.getStateOrNull()?.session;
    if (session == null) return;
    _cancelBySender(server);
  }

  void closeSession() {
    server.setState((oldState) => oldState?.copyWith(session: null));
  }

  void _cancelBySender(ServerUtils server) {
    final session = server.getState().session;
    if (session == null) return;
    server.setState((oldState) => oldState?.copyWith(session: null));
    server.ref.notifier(progressProvider).removeSession(session.sessionId);
  }
}
