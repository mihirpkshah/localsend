// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'web_send_state.dart';

class WebSendStateMapper extends ClassMapperBase<WebSendState> {
  WebSendStateMapper._();

  static WebSendStateMapper? _instance;
  static WebSendStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebSendStateMapper._());
      WebSendSessionMapper.ensureInitialized();
      WebSendFileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebSendState';

  static Map<String, WebSendSession> _$sessions(WebSendState v) => v.sessions;
  static const Field<WebSendState, Map<String, WebSendSession>> _f$sessions =
      Field('sessions', _$sessions);
  static Map<String, WebSendFile> _$files(WebSendState v) => v.files;
  static const Field<WebSendState, Map<String, WebSendFile>> _f$files = Field(
    'files',
    _$files,
  );
  static String? _$pin(WebSendState v) => v.pin;
  static const Field<WebSendState, String> _f$pin = Field('pin', _$pin);
  static bool _$autoAccept(WebSendState v) => v.autoAccept;
  static const Field<WebSendState, bool> _f$autoAccept = Field(
    'autoAccept',
    _$autoAccept,
  );

  @override
  final MappableFields<WebSendState> fields = const {
    #sessions: _f$sessions,
    #files: _f$files,
    #pin: _f$pin,
    #autoAccept: _f$autoAccept,
  };

  static WebSendState _instantiate(DecodingData data) {
    return WebSendState(
      sessions: data.dec(_f$sessions),
      files: data.dec(_f$files),
      pin: data.dec(_f$pin),
      autoAccept: data.dec(_f$autoAccept),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebSendState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebSendState>(map);
  }

  static WebSendState fromJson(String json) {
    return ensureInitialized().decodeJson<WebSendState>(json);
  }
}

mixin WebSendStateMappable {
  String toJson() {
    return WebSendStateMapper.ensureInitialized().encodeJson<WebSendState>(
      this as WebSendState,
    );
  }

  Map<String, dynamic> toMap() {
    return WebSendStateMapper.ensureInitialized().encodeMap<WebSendState>(
      this as WebSendState,
    );
  }

  WebSendStateCopyWith<WebSendState, WebSendState, WebSendState> get copyWith =>
      _WebSendStateCopyWithImpl<WebSendState, WebSendState>(
        this as WebSendState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebSendStateMapper.ensureInitialized().stringifyValue(
      this as WebSendState,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebSendStateMapper.ensureInitialized().equalsValue(
      this as WebSendState,
      other,
    );
  }

  @override
  int get hashCode {
    return WebSendStateMapper.ensureInitialized().hashValue(
      this as WebSendState,
    );
  }
}

extension WebSendStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebSendState, $Out> {
  WebSendStateCopyWith<$R, WebSendState, $Out> get $asWebSendState =>
      $base.as((v, t, t2) => _WebSendStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebSendStateCopyWith<$R, $In extends WebSendState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<
    $R,
    String,
    WebSendSession,
    WebSendSessionCopyWith<$R, WebSendSession, WebSendSession>
  >
  get sessions;
  MapCopyWith<
    $R,
    String,
    WebSendFile,
    WebSendFileCopyWith<$R, WebSendFile, WebSendFile>
  >
  get files;
  $R call({
    Map<String, WebSendSession>? sessions,
    Map<String, WebSendFile>? files,
    String? pin,
    bool? autoAccept,
  });
  WebSendStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebSendStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebSendState, $Out>
    implements WebSendStateCopyWith<$R, WebSendState, $Out> {
  _WebSendStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebSendState> $mapper =
      WebSendStateMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    String,
    WebSendSession,
    WebSendSessionCopyWith<$R, WebSendSession, WebSendSession>
  >
  get sessions => MapCopyWith(
    $value.sessions,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(sessions: v),
  );
  @override
  MapCopyWith<
    $R,
    String,
    WebSendFile,
    WebSendFileCopyWith<$R, WebSendFile, WebSendFile>
  >
  get files => MapCopyWith(
    $value.files,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(files: v),
  );
  @override
  $R call({
    Map<String, WebSendSession>? sessions,
    Map<String, WebSendFile>? files,
    Object? pin = $none,
    bool? autoAccept,
  }) => $apply(
    FieldCopyWithData({
      if (sessions != null) #sessions: sessions,
      if (files != null) #files: files,
      if (pin != $none) #pin: pin,
      if (autoAccept != null) #autoAccept: autoAccept,
    }),
  );
  @override
  WebSendState $make(CopyWithData data) => WebSendState(
    sessions: data.get(#sessions, or: $value.sessions),
    files: data.get(#files, or: $value.files),
    pin: data.get(#pin, or: $value.pin),
    autoAccept: data.get(#autoAccept, or: $value.autoAccept),
  );

  @override
  WebSendStateCopyWith<$R2, WebSendState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebSendStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebSendSessionMapper extends ClassMapperBase<WebSendSession> {
  WebSendSessionMapper._();

  static WebSendSessionMapper? _instance;
  static WebSendSessionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebSendSessionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebSendSession';

  static String _$sessionId(WebSendSession v) => v.sessionId;
  static const Field<WebSendSession, String> _f$sessionId = Field(
    'sessionId',
    _$sessionId,
  );
  static int _$startTime(WebSendSession v) => v.startTime;
  static const Field<WebSendSession, int> _f$startTime = Field(
    'startTime',
    _$startTime,
  );
  static String _$deviceInfo(WebSendSession v) => v.deviceInfo;
  static const Field<WebSendSession, String> _f$deviceInfo = Field(
    'deviceInfo',
    _$deviceInfo,
  );
  static String _$ip(WebSendSession v) => v.ip;
  static const Field<WebSendSession, String> _f$ip = Field('ip', _$ip);
  static String? _$responseHandler(WebSendSession v) => v.responseHandler;
  static const Field<WebSendSession, String> _f$responseHandler = Field(
    'responseHandler',
    _$responseHandler,
  );

  @override
  final MappableFields<WebSendSession> fields = const {
    #sessionId: _f$sessionId,
    #startTime: _f$startTime,
    #deviceInfo: _f$deviceInfo,
    #ip: _f$ip,
    #responseHandler: _f$responseHandler,
  };

  static WebSendSession _instantiate(DecodingData data) {
    return WebSendSession(
      sessionId: data.dec(_f$sessionId),
      startTime: data.dec(_f$startTime),
      deviceInfo: data.dec(_f$deviceInfo),
      ip: data.dec(_f$ip),
      responseHandler: data.dec(_f$responseHandler),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebSendSession fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebSendSession>(map);
  }

  static WebSendSession fromJson(String json) {
    return ensureInitialized().decodeJson<WebSendSession>(json);
  }
}

mixin WebSendSessionMappable {
  String toJson() {
    return WebSendSessionMapper.ensureInitialized().encodeJson<WebSendSession>(
      this as WebSendSession,
    );
  }

  Map<String, dynamic> toMap() {
    return WebSendSessionMapper.ensureInitialized().encodeMap<WebSendSession>(
      this as WebSendSession,
    );
  }

  WebSendSessionCopyWith<WebSendSession, WebSendSession, WebSendSession>
  get copyWith => _WebSendSessionCopyWithImpl<WebSendSession, WebSendSession>(
    this as WebSendSession,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return WebSendSessionMapper.ensureInitialized().stringifyValue(
      this as WebSendSession,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebSendSessionMapper.ensureInitialized().equalsValue(
      this as WebSendSession,
      other,
    );
  }

  @override
  int get hashCode {
    return WebSendSessionMapper.ensureInitialized().hashValue(
      this as WebSendSession,
    );
  }
}

extension WebSendSessionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebSendSession, $Out> {
  WebSendSessionCopyWith<$R, WebSendSession, $Out> get $asWebSendSession =>
      $base.as((v, t, t2) => _WebSendSessionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebSendSessionCopyWith<$R, $In extends WebSendSession, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? sessionId,
    int? startTime,
    String? deviceInfo,
    String? ip,
    String? responseHandler,
  });
  WebSendSessionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebSendSessionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebSendSession, $Out>
    implements WebSendSessionCopyWith<$R, WebSendSession, $Out> {
  _WebSendSessionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebSendSession> $mapper =
      WebSendSessionMapper.ensureInitialized();
  @override
  $R call({
    String? sessionId,
    int? startTime,
    String? deviceInfo,
    String? ip,
    Object? responseHandler = $none,
  }) => $apply(
    FieldCopyWithData({
      if (sessionId != null) #sessionId: sessionId,
      if (startTime != null) #startTime: startTime,
      if (deviceInfo != null) #deviceInfo: deviceInfo,
      if (ip != null) #ip: ip,
      if (responseHandler != $none) #responseHandler: responseHandler,
    }),
  );
  @override
  WebSendSession $make(CopyWithData data) => WebSendSession(
    sessionId: data.get(#sessionId, or: $value.sessionId),
    startTime: data.get(#startTime, or: $value.startTime),
    deviceInfo: data.get(#deviceInfo, or: $value.deviceInfo),
    ip: data.get(#ip, or: $value.ip),
    responseHandler: data.get(#responseHandler, or: $value.responseHandler),
  );

  @override
  WebSendSessionCopyWith<$R2, WebSendSession, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebSendSessionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WebSendFileMapper extends ClassMapperBase<WebSendFile> {
  WebSendFileMapper._();

  static WebSendFileMapper? _instance;
  static WebSendFileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebSendFileMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WebSendFile';

  static String _$fileId(WebSendFile v) => v.fileId;
  static const Field<WebSendFile, String> _f$fileId = Field('fileId', _$fileId);
  static String _$fileName(WebSendFile v) => v.fileName;
  static const Field<WebSendFile, String> _f$fileName = Field(
    'fileName',
    _$fileName,
  );
  static int _$size(WebSendFile v) => v.size;
  static const Field<WebSendFile, int> _f$size = Field('size', _$size);

  @override
  final MappableFields<WebSendFile> fields = const {
    #fileId: _f$fileId,
    #fileName: _f$fileName,
    #size: _f$size,
  };

  static WebSendFile _instantiate(DecodingData data) {
    return WebSendFile(
      fileId: data.dec(_f$fileId),
      fileName: data.dec(_f$fileName),
      size: data.dec(_f$size),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebSendFile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebSendFile>(map);
  }

  static WebSendFile fromJson(String json) {
    return ensureInitialized().decodeJson<WebSendFile>(json);
  }
}

mixin WebSendFileMappable {
  String toJson() {
    return WebSendFileMapper.ensureInitialized().encodeJson<WebSendFile>(
      this as WebSendFile,
    );
  }

  Map<String, dynamic> toMap() {
    return WebSendFileMapper.ensureInitialized().encodeMap<WebSendFile>(
      this as WebSendFile,
    );
  }

  WebSendFileCopyWith<WebSendFile, WebSendFile, WebSendFile> get copyWith =>
      _WebSendFileCopyWithImpl<WebSendFile, WebSendFile>(
        this as WebSendFile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebSendFileMapper.ensureInitialized().stringifyValue(
      this as WebSendFile,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebSendFileMapper.ensureInitialized().equalsValue(
      this as WebSendFile,
      other,
    );
  }

  @override
  int get hashCode {
    return WebSendFileMapper.ensureInitialized().hashValue(this as WebSendFile);
  }
}

extension WebSendFileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebSendFile, $Out> {
  WebSendFileCopyWith<$R, WebSendFile, $Out> get $asWebSendFile =>
      $base.as((v, t, t2) => _WebSendFileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WebSendFileCopyWith<$R, $In extends WebSendFile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? fileId, String? fileName, int? size});
  WebSendFileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WebSendFileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebSendFile, $Out>
    implements WebSendFileCopyWith<$R, WebSendFile, $Out> {
  _WebSendFileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebSendFile> $mapper =
      WebSendFileMapper.ensureInitialized();
  @override
  $R call({String? fileId, String? fileName, int? size}) => $apply(
    FieldCopyWithData({
      if (fileId != null) #fileId: fileId,
      if (fileName != null) #fileName: fileName,
      if (size != null) #size: size,
    }),
  );
  @override
  WebSendFile $make(CopyWithData data) => WebSendFile(
    fileId: data.get(#fileId, or: $value.fileId),
    fileName: data.get(#fileName, or: $value.fileName),
    size: data.get(#size, or: $value.size),
  );

  @override
  WebSendFileCopyWith<$R2, WebSendFile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebSendFileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

