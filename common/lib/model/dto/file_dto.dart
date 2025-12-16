import 'package:collection/collection.dart';
import 'package:common/model/file_type.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:mime/mime.dart';

part 'file_dto.mapper.dart';

@MappableClass(ignoreNull: true)
class FileMetadata with FileMetadataMappable {
  @MappableField(key: 'modified')
  final DateTime? lastModified;

  @MappableField(key: 'accessed')
  final DateTime? lastAccessed;

  const FileMetadata({
    required this.lastModified,
    required this.lastAccessed,
  });
}

/// The file DTO that is sent between server and client.
@MappableClass()
class FileDto with FileDtoMappable {
  final String id; // unique inside session
  final String fileName;
  final int size;
  final FileType fileType;
  final String? hash;
  final String? preview;
  final FileMetadata? metadata;

  /// This is only used internally to determine if fileType is a mime type or a legacy enum.
  /// It is not serialized.
  final bool legacy;

  const FileDto({
    required this.id,
    required this.fileName,
    required this.size,
    required this.fileType,
    required this.hash,
    required this.preview,
    this.legacy = false,
    required this.metadata,
  });

  String lookupMime() => lookupMimeType(fileName) ?? 'application/octet-stream';
}
