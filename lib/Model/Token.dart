import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Entity.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/SqliteStorage.dart';

class Token implements JsonSerializable, Entity {
  final String _id;

  final bool root;
  final int bucket; // read resource bucket
  final List<int> users;
  final List<int> groups;
  final List<int> buckets; // bucket api access (admin)

  final DateTime? stamp;

  Token(
    this._id, {
    required this.bucket,
    this.users = const [],
    this.groups = const [],
    this.buckets = const [],
    this.root = false,
    this.stamp,
  });

  String get id => _id;

  bool valid() {
    return !(users.isEmpty && groups.isEmpty && buckets.isEmpty && !root);
  }

  bool accessResource(
    Resource resource,
  ) {
    if (root || buckets.contains(resource.bucket)) {
      return true;
    }
    if (bucket != resource.bucket) {
      return false;
    }
    return Set.from(users).intersection(Set.from(resource.users)).isNotEmpty ||
        Set.from(groups).intersection(Set.from(resource.groups)).isNotEmpty;
  }

  bool accessBucket(
    int bucket,
  ) {
    if (root || buckets.contains(bucket)) {
      return true;
    }
    return false;
  }

  String toString() {
    return 'Token#' + id + '/' + bucket.toString();
  }

  Dict toDatabase() {
    return {
      'id': id,
      'bucket': bucket,
      'users': users.join(';'),
      'groups': groups.join(';'),
      'buckets': buckets.join(';'),
      'root': root ? 1 : 0,
    };
  }

  Dict toJson() {
    return {
      'id': id,
      'bucket': bucket,
      'users': users,
      'groups': groups,
      'buckets': buckets,
      'root': root,
    };
  }

  bool keepLive(
    SqliteStorage sqliteStorage,
  ) {
    // TODO check ttl of token
    // update if not too old
    // return false if expired

    // print(stamp);

    return true;
  }

  factory Token.fromDatabase(
    Dict row,
  ) {
    return Token(
      row['id'] as String? ?? '',
      bucket: row['bucket'] as int? ?? 0,
      users: Util.intList(row['users'] as String? ?? ''),
      groups: Util.intList(row['groups'] as String? ?? ''),
      buckets: Util.intList(row['buckets'] as String? ?? ''),
      root: (row['root'] as int? ?? 0) == 1,
      stamp: DateTime.parse(row['stamp'] as String? ?? ''),
    );
  }

  factory Token.notFound(
    String id,
  ) {
    return Token(
      id,
      bucket: 0,
    );
  }
}
