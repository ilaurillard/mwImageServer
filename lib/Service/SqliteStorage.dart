import 'package:mwcdn/Etc/Schema.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Entity.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../Etc/Types.dart';

class SqliteStorage {
  late final Database db;

  final String dataDir;

  SqliteStorage({
    required this.dataDir,
  });

  // ---------------------

  Future<void> init() async {
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase(
      dataDir + '/database/system.db',
      options: OpenDatabaseOptions(
        version: 1,
        onUpgrade: Schema.schema,
        singleInstance: false,
      ),
    );
    print('[sqlite] ' + db.toString());
  }

  // -------------------------------- BUCKET

  Future<Bucket> createBucket(
    int id,
  ) async {
    // print('sqliteStorage:createBucket');

    Bucket bucket = Bucket.fresh(id);

    await db.insert(
      'Bucket',
      bucket.toDatabase(),
    );

    return bucket;
  }

  // ---------------------

  Future<void> updateBucket(
    Bucket bucket,
  ) async {
    await db.update(
      'Bucket',
      bucket.toDatabase(),
      where: 'id = ?',
      whereArgs: [
        bucket.id,
      ],
    );
  }

  // ---------------------

  Future<Bucket> loadBucket(
    int id,
  ) async {
    List<dynamic> data = await db.query(
      'Bucket',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (data.isNotEmpty) {
      print(' Loaded bucket: ' + id.toString());
      return Bucket.fromDatabase(
        data.first as Dict,
      );
    } else {
      print(
        ' Bucket not found: ' + id.toString(),
      );
    }

    return Bucket.notFound(id);
  }

  // ----------------- TOKEN

  Future<Token> createToken(
    int bucket, {
    List<int> users = const [],
    List<int> groups = const [],
    List<int> buckets = const [],
    bool root = false,
  }) async {
    String id = Util.randMd5();

    // print('sqliteStorage:createToken ' + id);

    Token token = Token(
      id,
      bucket: bucket,
      users: users,
      groups: groups,
      buckets: buckets,
      root: root,
      stamp: DateTime.now(),
      created: DateTime.now(),
    );

    await db.insert(
      'Token',
      token.toDatabase(),
    );

    return token;
  }

  // ---------------------

  Future<Token> loadToken(
    String id,
  ) async {
    if (id.isNotEmpty) {
      List<dynamic> data = await db.query(
        'Token',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (data.isNotEmpty) {
        print(' Loaded token: ' + id);
        return Token.fromDatabase(data.first as Dict);
      } else {
        print(' Token not found: ' + id);
      }
    }
    return Token.notFound(id);
  }

  // Future<Token> lastToken(
  //     Bucket bucket,
  //     ) async {
  //   List<dynamic> data = await db.query(
  //     'Token',
  //     where: 'bucket = ?',
  //     whereArgs: [bucket.id],
  //     orderBy: 'stamp DESC',
  //     limit: 1,
  //   );
  //   if (data.isNotEmpty) {
  //     return Token.fromDatabase(data.first as Dict);
  //   }
  //   return Token.notFound('');
  // }

  // ----------------

  Future<int> countTokens(
    Bucket bucket,
  ) async {
    List<dynamic> data = await db.query(
      'Token',
      columns: ['COUNT (*) AS amount'],
      where: 'bucket = ?',
      whereArgs: [bucket.id],
      limit: 1,
    );
    if (data.isNotEmpty) {
      Dict row = data.first as Dict;
      return row['amount'] as int;
    }
    return 0;
  }

  // ----------------- RESOURCE

  Future<Resource> createResource(
    int bucket, {
    required String filename,
    List<int> users = const [],
    List<int> groups = const [],
  }) async {
    String id = Util.randMd5();

    // print('sqliteStorage:createToken ' + id);

    Resource resource = Resource(
      id,
      bucket: bucket,
      filename: filename,
      users: users,
      groups: groups,
      created: DateTime.now(),
    );

    await db.insert(
      'Resource',
      resource.toDatabase(),
    );

    return resource;
  }

  // ---------------------

  Future<Resource> loadResource(
    int bucket,
    String id,
  ) async {
    if (bucket > 0 && id.isNotEmpty) {
      List<dynamic> data = await db.query(
        'Resource',
        where: 'id = ? AND bucket = ?',
        whereArgs: [id, bucket],
        limit: 1,
      );
      if (data.isNotEmpty) {
        print(' Loaded resource: ' + id);
        return Resource.fromDatabase(data.first as Dict);
      } else {
        print(' Resource not found: ' + id);
      }
    }

    return Resource.notFound(id);
  }

  // Future<Resource> lastResource(
  //   Bucket bucket,
  // ) async {
  //   List<dynamic> data = await db.query(
  //     'Resource',
  //     where: 'bucket = ?',
  //     whereArgs: [bucket.id],
  //     orderBy: 'created DESC',
  //     limit: 1,
  //   );
  //   if (data.isNotEmpty) {
  //     return Resource.fromDatabase(data.first as Dict);
  //   }
  //   return Resource.notFound('');
  // }

  // ---------------------

  Future<int> countResources(
    Bucket bucket,
  ) async {
    List<dynamic> data = await db.query(
      'Resource',
      columns: ['COUNT (*) AS amount'],
      where: 'bucket = ?',
      whereArgs: [bucket.id],
      limit: 1,
    );
    if (data.isNotEmpty) {
      Dict row = data.first as Dict;
      return row['amount'] as int;
    }
    return 0;
  }

  // -----------------

  Future<bool> deleteEntity(
    // Token, Resource, ...
    Entity entity,
  ) async {
    print(' Delete #' + entity.id + ' --> ' + entity.toString());

    int amountDeleted = 0;

    if (entity is Resource) {
      amountDeleted = await db.delete(
        'Resource',
        where: 'id = ? AND bucket = ?',
        whereArgs: [
          entity.id,
          entity.bucket,
        ],
      );
    } else if (entity is Token) {
      amountDeleted = await db.delete(
        'Token',
        where: 'id = ? AND bucket = ?',
        whereArgs: [
          entity.id,
          entity.bucket,
        ],
      );
    } else if (entity is Bucket) {
      amountDeleted = await db.delete(
        'Bucket',
        where: 'id = ?',
        whereArgs: [
          entity.id,
        ],
      );
    }

    return Future<bool>.value(amountDeleted > 0);
  }
}
