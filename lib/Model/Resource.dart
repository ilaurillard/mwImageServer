import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Entity.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';

class Resource implements JsonSerializable, Entity {
  final String _id;

  final int bucket;
  final String filename;
  int size;
  final List<int> users;
  final List<int> groups;

  final DateTime? created;

  Resource(
    this._id, {
    required this.bucket,
    required this.filename,
    this.size = 0,
    this.users = const [],
    this.groups = const [],
    this.created,
  });

  String get id => _id;

  bool valid() {
    return bucket != 0;
  }

  String toString() {
    return 'Resource#' + id + '/' + bucket.toString();
  }

  // --> public/77/ff/aa/ffaa112233334444ffaa112233334444
  String path({bool absolute = true}) {
    return (absolute ? '/' : '') +
        (public() ? 'public' : 'private') +
        '/' +
        bucket.toString() +
        '/' +
        id.substring(0, 2) +
        '/' +
        id.substring(2, 4) +
        '/' +
        id.toString();
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
      'size': size,
    };
  }

  Dict toJson() {
    return {
      'id': id,
      'public': public(),
      'bucket': bucket,
      'users': users,
      'groups': groups,
      'path': path(absolute: false),
      'filename': filename,
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
      size: row['size'] as int? ?? 0,
      users: Util.intList(row['users'] as String? ?? ''),
      groups: Util.intList(row['groups'] as String? ?? ''),
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
