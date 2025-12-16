// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'webrtc_receiver.dart';

class WebRTCReceiveStateMapper extends ClassMapperBase<WebRTCReceiveState> {
  WebRTCReceiveStateMapper._();

  static WebRTCReceiveStateMapper? _instance;
  static WebRTCReceiveStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WebRTCReceiveStateMapper._());
      DeviceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WebRTCReceiveState';

  static RtcReceiveController? _$controller(WebRTCReceiveState v) =>
      v.controller;
  static const Field<WebRTCReceiveState, RtcReceiveController> _f$controller =
      Field('controller', _$controller, opt: true);
  static String? _$sessionId(WebRTCReceiveState v) => v.sessionId;
  static const Field<WebRTCReceiveState, String> _f$sessionId = Field(
    'sessionId',
    _$sessionId,
    opt: true,
  );
  static Device? _$device(WebRTCReceiveState v) => v.device;
  static const Field<WebRTCReceiveState, Device> _f$device = Field(
    'device',
    _$device,
    opt: true,
  );
  static List<FileDto> _$files(WebRTCReceiveState v) => v.files;
  static const Field<WebRTCReceiveState, List<FileDto>> _f$files = Field(
    'files',
    _$files,
    opt: true,
    def: const [],
  );
  static RTCStatus? _$status(WebRTCReceiveState v) => v.status;
  static const Field<WebRTCReceiveState, RTCStatus> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );

  @override
  final MappableFields<WebRTCReceiveState> fields = const {
    #controller: _f$controller,
    #sessionId: _f$sessionId,
    #device: _f$device,
    #files: _f$files,
    #status: _f$status,
  };

  static WebRTCReceiveState _instantiate(DecodingData data) {
    return WebRTCReceiveState(
      controller: data.dec(_f$controller),
      sessionId: data.dec(_f$sessionId),
      device: data.dec(_f$device),
      files: data.dec(_f$files),
      status: data.dec(_f$status),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WebRTCReceiveState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WebRTCReceiveState>(map);
  }

  static WebRTCReceiveState fromJson(String json) {
    return ensureInitialized().decodeJson<WebRTCReceiveState>(json);
  }
}

mixin WebRTCReceiveStateMappable {
  String toJson() {
    return WebRTCReceiveStateMapper.ensureInitialized()
        .encodeJson<WebRTCReceiveState>(this as WebRTCReceiveState);
  }

  Map<String, dynamic> toMap() {
    return WebRTCReceiveStateMapper.ensureInitialized()
        .encodeMap<WebRTCReceiveState>(this as WebRTCReceiveState);
  }

  WebRTCReceiveStateCopyWith<
    WebRTCReceiveState,
    WebRTCReceiveState,
    WebRTCReceiveState
  >
  get copyWith =>
      _WebRTCReceiveStateCopyWithImpl<WebRTCReceiveState, WebRTCReceiveState>(
        this as WebRTCReceiveState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WebRTCReceiveStateMapper.ensureInitialized().stringifyValue(
      this as WebRTCReceiveState,
    );
  }

  @override
  bool operator ==(Object other) {
    return WebRTCReceiveStateMapper.ensureInitialized().equalsValue(
      this as WebRTCReceiveState,
      other,
    );
  }

  @override
  int get hashCode {
    return WebRTCReceiveStateMapper.ensureInitialized().hashValue(
      this as WebRTCReceiveState,
    );
  }
}

extension WebRTCReceiveStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WebRTCReceiveState, $Out> {
  WebRTCReceiveStateCopyWith<$R, WebRTCReceiveState, $Out>
  get $asWebRTCReceiveState => $base.as(
    (v, t, t2) => _WebRTCReceiveStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WebRTCReceiveStateCopyWith<
  $R,
  $In extends WebRTCReceiveState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  DeviceCopyWith<$R, Device, Device>? get device;
  ListCopyWith<$R, FileDto, ObjectCopyWith<$R, FileDto, FileDto>> get files;
  $R call({
    RtcReceiveController? controller,
    String? sessionId,
    Device? device,
    List<FileDto>? files,
    RTCStatus? status,
  });
  WebRTCReceiveStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WebRTCReceiveStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WebRTCReceiveState, $Out>
    implements WebRTCReceiveStateCopyWith<$R, WebRTCReceiveState, $Out> {
  _WebRTCReceiveStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WebRTCReceiveState> $mapper =
      WebRTCReceiveStateMapper.ensureInitialized();
  @override
  DeviceCopyWith<$R, Device, Device>? get device =>
      $value.device?.copyWith.$chain((v) => call(device: v));
  @override
  ListCopyWith<$R, FileDto, ObjectCopyWith<$R, FileDto, FileDto>> get files =>
      ListCopyWith(
        $value.files,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(files: v),
      );
  @override
  $R call({
    Object? controller = $none,
    Object? sessionId = $none,
    Object? device = $none,
    List<FileDto>? files,
    Object? status = $none,
  }) => $apply(
    FieldCopyWithData({
      if (controller != $none) #controller: controller,
      if (sessionId != $none) #sessionId: sessionId,
      if (device != $none) #device: device,
      if (files != null) #files: files,
      if (status != $none) #status: status,
    }),
  );
  @override
  WebRTCReceiveState $make(CopyWithData data) => WebRTCReceiveState(
    controller: data.get(#controller, or: $value.controller),
    sessionId: data.get(#sessionId, or: $value.sessionId),
    device: data.get(#device, or: $value.device),
    files: data.get(#files, or: $value.files),
    status: data.get(#status, or: $value.status),
  );

  @override
  WebRTCReceiveStateCopyWith<$R2, WebRTCReceiveState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WebRTCReceiveStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

