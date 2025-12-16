import 'dart:io';

import 'package:p2p/src/model/cross_file.dart';
import 'package:p2p/src/model/state/server/web_send_state.dart';
import 'package:p2p/src/network/server/server_utils.dart';
import 'package:p2p/src/util/simple_server.dart';

const _assetsPath = 'packages/p2p/assets/web';

/// Handles all requests for sending files.
class SendController {
  final ServerUtils server;
  final Map<String, CrossFile> _files = {};

  SendController(this.server);

  /// Installs all routes for receiving files.
  void installRoutes({
    required SimpleServerRouteBuilder router,
    required String alias,
    required String fingerprint,
  }) {
    router.get('/', (HttpRequest request) async {
      final state = server.getStateOrNull();
      if (state?.webSendState == null) {
        await request.respondAsset(403, '$_assetsPath/error-403.html');
        return;
      }
      await request.respondAsset(200, '$_assetsPath/index.html');
    });

    router.get('/main.js', (HttpRequest request) async {
      await request.respondAsset(
          200, '$_assetsPath/main.js', 'text/javascript; charset=utf-8');
    });

    router.get('/style.css', (HttpRequest request) async {
      await request.respondAsset(
          200, '$_assetsPath/style.css', 'text/css; charset=utf-8');
    });

    router.get('/api/localsend/v2/info', (HttpRequest request) async {
      final state = server.getStateOrNull();
      if (state?.webSendState == null) {
        await request.respondJson(403, message: 'Web send not initialized.');
        return;
      }

      await request.respondJson(200, body: {
        'alias': alias,
        'fingerprint': fingerprint,
        'files': state!.webSendState!.files.values
            .map((f) => {
                  'id': f.fileId,
                  'fileName': f.fileName,
                  'size': f.size,
                  'fileType': f.fileName.split('.').last, // basic mime guess
                })
            .toList(),
      });
    });

    router.get('/api/localsend/v2/download', (HttpRequest request) async {
      final state = server.getStateOrNull();
      if (state?.webSendState == null) {
        await request.respondJson(403, message: 'Web send not initialized.');
        return;
      }

      final fileId = request.uri.queryParameters['fileId'];
      if (fileId == null) {
        await request.respondJson(400, message: 'Missing fileId.');
        return;
      }

      final file = _files[fileId];
      if (file == null) {
        await request.respondJson(404, message: 'File not found.');
        return;
      }

      final fileName = file.name;
      request.response.headers.set('Content-Type', 'application/octet-stream');
      request.response.headers
          .set('Content-Disposition', 'attachment; filename="$fileName"');
      request.response.headers.set('Content-Length', file.size);

      if (file.path != null) {
        await request.response.addStream(File(file.path!).openRead());
      } else if (file.bytes != null) {
        request.response.add(file.bytes!);
      } else {
        await request.respondJson(500, message: 'File content missing.');
        return;
      }

      await request.response.close();
    });
  }

  Future<void> initializeWebSend({required List<CrossFile> files}) async {
    _files.clear();
    final webSendFiles = <String, WebSendFile>{};

    for (final file in files) {
      final fileId = file.name; // Use name as ID for simplicity
      _files[fileId] = file;
      webSendFiles[fileId] = WebSendFile(
        fileId: fileId,
        fileName: file.name,
        size: file.size,
      );
    }

    server.setState((oldState) {
      return oldState?.copyWith(
        webSendState: WebSendState(
          sessions: {},
          files: webSendFiles,
          pin: null,
          autoAccept: true,
        ),
      );
    });
  }

  void acceptRequest(String sessionId) {
    // Stub
  }

  void declineRequest(String sessionId) {
    // Stub
  }
}
