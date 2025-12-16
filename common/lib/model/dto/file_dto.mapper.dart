// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'file_dto.dart';

class FileMetadataMapper extends ClassMapperBase<FileMetadata> {
  FileMetadataMapper._();

  static FileMetadataMapper? _instance;
  static FileMetadataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FileMetadataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FileMetadata';

  static DateTime? _$lastModified(FileMetadata v) => v.lastModified;
  static const Field<FileMetadata, DateTime> _f$lastModified = Field(
    'lastModified',
    _$lastModified,
    key: r'modified',
  );
  static DateTime? _$lastAccessed(FileMetadata v) => v.lastAccessed;
  static const Field<FileMetadata, DateTime> _f$lastAccessed = Field(
    'lastAccessed',
    _$lastAccessed,
    key: r'accessed',
  );

  @override
  final MappableFields<FileMetadata> fields = const {
    #lastModified: _f$lastModified,
    #lastAccessed: _f$lastAccessed,
  };
  @override
  final bool ignoreNull = true;

  static FileMetadata _instantiate(DecodingData data) {
    return FileMetadata(
      lastModified: data.dec(_f$lastModified),
      lastAccessed: data.dec(_f$lastAccessed),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FileMetadata fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FileMetadata>(map);
  }

  static FileMetadata deserialize(String json) {
    return ensureInitialized().decodeJson<FileMetadata>(json);
  }
}

mixin FileMetadataMappable {
  String serialize() {
    return FileMetadataMapper.ensureInitialized().encodeJson<FileMetadata>(
      this as FileMetadata,
    );
  }

  Map<String, dynamic> toJson() {
    return FileMetadataMapper.ensureInitialized().encodeMap<FileMetadata>(
      this as FileMetadata,
    );
  }

  FileMetadataCopyWith<FileMetadata, FileMetadata, FileMetadata> get copyWith =>
      _FileMetadataCopyWithImpl<FileMetadata, FileMetadata>(
        this as FileMetadata,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FileMetadataMapper.ensureInitialized().stringifyValue(
      this as FileMetadata,
    );
  }

  @override
  bool operator ==(Object other) {
    return FileMetadataMapper.ensureInitialized().equalsValue(
      this as FileMetadata,
      other,
    );
  }

  @override
  int get hashCode {
    return FileMetadataMapper.ensureInitialized().hashValue(
      this as FileMetadata,
    );
  }
}

extension FileMetadataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FileMetadata, $Out> {
  FileMetadataCopyWith<$R, FileMetadata, $Out> get $asFileMetadata =>
      $base.as((v, t, t2) => _FileMetadataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FileMetadataCopyWith<$R, $In extends FileMetadata, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DateTime? lastModified, DateTime? lastAccessed});
  FileMetadataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FileMetadataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FileMetadata, $Out>
    implements FileMetadataCopyWith<$R, FileMetadata, $Out> {
  _FileMetadataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FileMetadata> $mapper =
      FileMetadataMapper.ensureInitialized();
  @override
  $R call({Object? lastModified = $none, Object? lastAccessed = $none}) =>
      $apply(
        FieldCopyWithData({
          if (lastModified != $none) #lastModified: lastModified,
          if (lastAccessed != $none) #lastAccessed: lastAccessed,
        }),
      );
  @override
  FileMetadata $make(CopyWithData data) => FileMetadata(
    lastModified: data.get(#lastModified, or: $value.lastModified),
    lastAccessed: data.get(#lastAccessed, or: $value.lastAccessed),
  );

  @override
  FileMetadataCopyWith<$R2, FileMetadata, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FileMetadataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FileDtoMapper extends ClassMapperBase<FileDto> {
  FileDtoMapper._();

  static FileDtoMapper? _instance;
  static FileDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FileDtoMapper._());
      FileTypeMapper.ensureInitialized();
      FileMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FileDto';

  static String _$id(FileDto v) => v.id;
  static const Field<FileDto, String> _f$id = Field('id', _$id);
  static String _$fileName(FileDto v) => v.fileName;
  static const Field<FileDto, String> _f$fileName = Field(
    'fileName',
    _$fileName,
  );
  static int _$size(FileDto v) => v.size;
  static const Field<FileDto, int> _f$size = Field('size', _$size);
  static FileType _$fileType(FileDto v) => v.fileType;
  static const Field<FileDto, FileType> _f$fileType = Field(
    'fileType',
    _$fileType,
  );
  static String? _$hash(FileDto v) => v.hash;
  static const Field<FileDto, String> _f$hash = Field('hash', _$hash);
  static String? _$preview(FileDto v) => v.preview;
  static const Field<FileDto, String> _f$preview = Field('preview', _$preview);
  static bool _$legacy(FileDto v) => v.legacy;
  static const Field<FileDto, bool> _f$legacy = Field(
    'legacy',
    _$legacy,
    opt: true,
    def: false,
  );
  static FileMetadata? _$metadata(FileDto v) => v.metadata;
  static const Field<FileDto, FileMetadata> _f$metadata = Field(
    'metadata',
    _$metadata,
  );

  @override
  final MappableFields<FileDto> fields = const {
    #id: _f$id,
    #fileName: _f$fileName,
    #size: _f$size,
    #fileType: _f$fileType,
    #hash: _f$hash,
    #preview: _f$preview,
    #legacy: _f$legacy,
    #metadata: _f$metadata,
  };

  static FileDto _instantiate(DecodingData data) {
    return FileDto(
      id: data.dec(_f$id),
      fileName: data.dec(_f$fileName),
      size: data.dec(_f$size),
      fileType: data.dec(_f$fileType),
      hash: data.dec(_f$hash),
      preview: data.dec(_f$preview),
      legacy: data.dec(_f$legacy),
      metadata: data.dec(_f$metadata),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FileDto fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FileDto>(map);
  }

  static FileDto deserialize(String json) {
    return ensureInitialized().decodeJson<FileDto>(json);
  }
}

mixin FileDtoMappable {
  String serialize() {
    return FileDtoMapper.ensureInitialized().encodeJson<FileDto>(
      this as FileDto,
    );
  }

  Map<String, dynamic> toJson() {
    return FileDtoMapper.ensureInitialized().encodeMap<FileDto>(
      this as FileDto,
    );
  }

  FileDtoCopyWith<FileDto, FileDto, FileDto> get copyWith =>
      _FileDtoCopyWithImpl<FileDto, FileDto>(
        this as FileDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FileDtoMapper.ensureInitialized().stringifyValue(this as FileDto);
  }

  @override
  bool operator ==(Object other) {
    return FileDtoMapper.ensureInitialized().equalsValue(
      this as FileDto,
      other,
    );
  }

  @override
  int get hashCode {
    return FileDtoMapper.ensureInitialized().hashValue(this as FileDto);
  }
}

extension FileDtoValueCopy<$R, $Out> on ObjectCopyWith<$R, FileDto, $Out> {
  FileDtoCopyWith<$R, FileDto, $Out> get $asFileDto =>
      $base.as((v, t, t2) => _FileDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FileDtoCopyWith<$R, $In extends FileDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata>? get metadata;
  $R call({
    String? id,
    String? fileName,
    int? size,
    FileType? fileType,
    String? hash,
    String? preview,
    bool? legacy,
    FileMetadata? metadata,
  });
  FileDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FileDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FileDto, $Out>
    implements FileDtoCopyWith<$R, FileDto, $Out> {
  _FileDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FileDto> $mapper =
      FileDtoMapper.ensureInitialized();
  @override
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata>? get metadata =>
      $value.metadata?.copyWith.$chain((v) => call(metadata: v));
  @override
  $R call({
    String? id,
    String? fileName,
    int? size,
    FileType? fileType,
    Object? hash = $none,
    Object? preview = $none,
    bool? legacy,
    Object? metadata = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (fileName != null) #fileName: fileName,
      if (size != null) #size: size,
      if (fileType != null) #fileType: fileType,
      if (hash != $none) #hash: hash,
      if (preview != $none) #preview: preview,
      if (legacy != null) #legacy: legacy,
      if (metadata != $none) #metadata: metadata,
    }),
  );
  @override
  FileDto $make(CopyWithData data) => FileDto(
    id: data.get(#id, or: $value.id),
    fileName: data.get(#fileName, or: $value.fileName),
    size: data.get(#size, or: $value.size),
    fileType: data.get(#fileType, or: $value.fileType),
    hash: data.get(#hash, or: $value.hash),
    preview: data.get(#preview, or: $value.preview),
    legacy: data.get(#legacy, or: $value.legacy),
    metadata: data.get(#metadata, or: $value.metadata),
  );

  @override
  FileDtoCopyWith<$R2, FileDto, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FileDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

