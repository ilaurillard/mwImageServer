import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Entity.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';

class Resource implements JsonSerializable, Entity {
  final String _id;

  final int bucket;
  final String filename;
  final String mimeType;
  int size;
  Ids users;
  Ids groups;

  final DateTime? created;

  Resource(
    this._id, {
    required this.bucket,
    required this.filename,
    this.mimeType = '',
    this.size = 0,
    this.users = const [],
    this.groups = const [],
    this.created,
  });

  @override
  String get id => _id;

  bool valid() {
    return bucket != 0;
  }

  @override
  String toString() {
    return 'Resource#$id/$bucket';
  }

  // --> public/77/ff/aa/ffaa112233334444ffaa112233334444
  String path({
    bool absolute = true,
  }) {
    return '${absolute ? '/' : ''}${public() ? 'pub' : 'priv'}/$bucket/${id.substring(0, 2)}/${id.substring(2, 4)}/$id';
  }

  bool public() {
    return users.isEmpty && groups.isEmpty;
  }

  Dict toDatabase() {
    return {
      'id': id,
      'bucket': bucket,
      'users': users.join(';'),
      'groups': groups.join(';'),
      'filename': filename,
      'mimeType': mimeType,
      'size': size,
    };
  }

  Dict toDatabaseUpdate() {
    return {
      'users': users.join(';'),
      'groups': groups.join(';'),
    };
  }

  @override
  Dict toJson() {
    return {
      'id': id,
      'public': public(),
      'bucket': bucket,
      'users': users,
      'groups': groups,
      'path': path(absolute: false),
      'filename': filename,
      'mimeType': mimeType,
      'size': size,
      'created': created?.millisecondsSinceEpoch,
    };
  }

  factory Resource.fromDatabase(
    Dict row,
  ) {
    return Resource(
      row['id'] as String? ?? '',
      bucket: row['bucket'] as int? ?? 0,
      filename: row['filename'] as String? ?? '',
      mimeType: row['mimeType'] as String? ?? '',
      size: row['size'] as int? ?? 0,
      users: Types.idListFromCsv(row['users'] as String? ?? ''),
      groups: Types.idListFromCsv(row['groups'] as String? ?? ''),
      created: DateTime.parse(row['created'] as String? ?? ''),
    );
  }

  factory Resource.notFound(
    String id,
  ) {
    return Resource(
      id,
      bucket: 0,
      filename: '',
    );
  }
}
