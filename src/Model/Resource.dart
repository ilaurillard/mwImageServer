import '../Types.dart';
import 'JsonSerializable.dart';

class Resource
    extends JsonSerializable {
  final String id;

  final int bucket;
  final String filename;
  final List<int> users;
  final List<int> groups;

  Resource(
    this.id, {
    required this.bucket,
    required this.filename,
    this.users = const [],
    this.groups = const [],
  });

  bool empty() {
    return bucket == 0;
  }

  String toString() {
    return 'Resource#' + id + '/' + bucket.toString();
  }

  // --> public/77/ff/aa/ffaa112233334444ffaa112233334444
  String path() {
    return (public() ? 'public' : 'private') +
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
    };
  }

  Dict toJson() {
    return {
      'id': id,
      'public': public(),
      'bucket': bucket,
      'users': users,
      'groups': groups,
      'path': path(),
      'filename': filename,
    };
  }
}
