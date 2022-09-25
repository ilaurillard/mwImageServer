import 'Token.dart';

class Resource {
  final String id;

  final int bucket;
  final List<int> users;
  final List<int> groups;

  Resource(
    this.id,
    this.bucket, {
    this.users = const [],
    this.groups = const [],
  });



  bool empty() {
    return false;
  }

  String toString() {
    return 'Resource#' + id + '/' + bucket.toString();
  }
}
