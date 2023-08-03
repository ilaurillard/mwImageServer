import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Entity.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';

class Token implements JsonSerializable, Entity {
  final String _id;

  final bool root;
  final int bucket; // read access to (resource) bucket

  final Ids users;
  final Ids groups;

  final Ids buckets; // write access to buckets (admin)

  final DateTime? stamp;
  final DateTime? created;

  Token(
    this._id, {
    required this.bucket,
    this.users = const [],
    this.groups = const [],
    this.buckets = const [],
    this.root = false,
    this.stamp,
    this.created,
  });

  @override
  String get id => _id;

  bool valid() {
    return !(users.isEmpty && groups.isEmpty && buckets.isEmpty && !root);
  }

  bool accessResource( // read
    Resource resource,
  ) {
    if (root || buckets.contains(resource.bucket)) {
      // Root token or resource bucket matches one of tokens buckets
      return true;
    }
    if (bucket != resource.bucket) {
      // Token bucket does not match resource bucket
      return false;
    }
    // Access via group id match or via user id match
    return Set<int>.from(groups)
            .intersection(
              Set.from(resource.groups),
            )
            .isNotEmpty ||
        Set<int>.from(users)
            .intersection(
              Set.from(resource.users),
            )
            .isNotEmpty;
  }

  bool accessBucket( // api access
    int bucket,
  ) {
    if (root || buckets.contains(bucket)) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return 'Token#$id/$bucket';
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

  @override
  Dict toJson() {
    return {
      'id': id,
      'bucket': bucket,
      'users': users,
      'groups': groups,
      'buckets': buckets,
      'root': root,
      'stamp': stamp?.millisecondsSinceEpoch,
      'created': created?.millisecondsSinceEpoch,
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
      users: Types.idListFromCsv(row['users'] as String? ?? ''),
      groups: Types.idListFromCsv(row['groups'] as String? ?? ''),
      buckets: Types.idListFromCsv(row['buckets'] as String? ?? ''),
      root: (row['root'] as int? ?? 0) == 1,
      stamp: DateTime.parse(row['stamp'] as String? ?? ''),
      created: DateTime.parse(row['created'] as String? ?? ''),
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
