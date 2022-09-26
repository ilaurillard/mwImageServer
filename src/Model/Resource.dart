import 'Token.dart';

class Resource {
  final String id;

  final int bucket;
  final List<int> users;
  final List<int> groups;

  Resource(
    this.id,
    {
      required this.bucket,
    this.users = const [],
    this.groups = const [],
  });



  bool empty() {
    return bucket == 0;
  }

  String toString() {
    return 'Resource#' + id + '/' + bucket.toString();
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'bucket': bucket,
      'users': users.join(';'),
      'groups': groups.join(';'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bucket': bucket,
      'users': users,
      'groups': groups,
    };
  }
}
