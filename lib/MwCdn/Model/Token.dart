import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Model/Entity.dart';
import 'package:mwcdn/MwMs/Model/JsonSerializable.dart';
import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/MwMs/Model/ResourceInterface.dart';
import 'package:mwcdn/MwMs/Model/TokenInterface.dart';

class Token implements JsonSerializable, Entity, TokenInterface {
  final String _id;

  final bool root;
  final int bucket; // read access to (resource) bucket

  final Ids users;
  final Ids groups;

  final Ids buckets; // write access to buckets (admin)

  final DateTime? stamp;
  final DateTime? created;

  const Token(
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

  @override
  bool accessResource(
    // read
    ResourceInterface resource,
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

  bool accessBucket(
    // api access
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

  factory Token.empty() {
    return const Token(
      '',
      bucket: 0,
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

  factory Token.root() {
    return Token('', bucket: 0, root: true);
  }
}
