import 'package:dart_mappable/dart_mappable.dart';

part 'web_send_state.mapper.dart';

@MappableClass()
class WebSendState with WebSendStateMappable {
  final Map<String, WebSendSession> sessions;
  final Map<String, WebSendFile> files;

  final String? pin;
  final bool autoAccept;

  const WebSendState({
    required this.sessions,
    required this.files,
    required this.pin,
    required this.autoAccept,
  });
}

@MappableClass()
class WebSendSession with WebSendSessionMappable {
  final String sessionId;
  final int startTime;
  final String deviceInfo;
  final String ip;
  final String?
      responseHandler; // Stub for now, originally might be more complex

  const WebSendSession({
    required this.sessionId,
    required this.startTime,
    required this.deviceInfo,
    required this.ip,
    required this.responseHandler,
  });
}

@MappableClass()
class WebSendFile with WebSendFileMappable {
  final String fileId;
  final String fileName;
  final int size;

  const WebSendFile({
    required this.fileId,
    required this.fileName,
    required this.size,
  });
}
