import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Entity.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/Schema.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DataStore {
  late final Database db;

  DataStore();

  // ---------------------

  Future<void> init() async {
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase(
      Config.dataDir + '/database/system.db',
      options: OpenDatabaseOptions(
        version: 1,
        onUpgrade: Schema.schema,
      ),
    );
    print('[sqlite]');
    print(db.toString());
    print('');
  }

  // -------------------------------- BUCKET

  Future<Bucket> createBucket(
    int id,
  ) async {
    // print('DataStore:createBucket');

    Bucket bucket = Bucket.empty(id);

    await db.insert(
      'Bucket',
      bucket.toDatabase(),
    );

    return bucket;
  }

  // ---------------------

  Future<Bucket> bucket(
    int id,
  ) async {
    List<dynamic> data = await db.query(
      'Bucket',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (data.isNotEmpty) {
      print('Loaded bucket: ' + id.toString());
      return Bucket.fromDatabase(
        data.first,
      );
    } else {
      print(
        'Bucket not found: ' + id.toString(),
      );
    }

    return Bucket.empty(id);
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

    // print('DataStore:createToken ' + id);

    Token token = Token(
      id,
      bucket: bucket,
      users: users,
      groups: groups,
      buckets: buckets,
      root: root,
    );

    await db.insert(
      'Token',
      token.toDatabase(),
    );

    return token;
  }

  // ---------------------

  Future<Token> token(
    String id,
  ) async {
    List<dynamic> data = await db.query(
      'Token',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (data.isNotEmpty) {
      print('Loaded token: ' + id);
      return Token.fromDatabase(data.first);
    } else {
      print('Token not found: ' + id);
    }

    return Token.empty(id);
  }

  // ----------------- RESOURCE

  Future<Resource> createResource(
    int bucket, {
    required String filename,
    List<int> users = const [],
    List<int> groups = const [],
  }) async {
    String id = Util.randMd5();

    // print('DataStore:createToken ' + id);

    Resource resource = Resource(
      id,
      bucket: bucket,
      filename: filename,
      users: users,
      groups: groups,
    );

    await db.insert(
      'Resource',
      resource.toDatabase(),
    );

    return resource;
  }

  // ---------------------

  Future<Resource> resource(
    int bucket,
    String id,
  ) async {
    print('Load resource: ' + id);

    if (bucket > 0) {
      List<dynamic> data = await db.query(
        'Resource',
        where: 'id = ? AND bucket = ?',
        whereArgs: [id, bucket],
        limit: 1,
      );
      if (data.isNotEmpty) {
        return Resource.fromDatabase(data.first);
      }
    }

    return Resource.empty(id);
  }

  // -----------------

  Future<bool> delete(
    Entity entity,
  ) async {
    print('Delete #' + entity.id + ' --> ' + entity.toString());

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
    }
    else if (entity is Token) {
      amountDeleted = await db.delete(
        'Token',
        where: 'id = ? AND bucket = ?',
        whereArgs: [
          entity.id,
          entity.bucket,
        ],
      );
    }
    else if (entity is Bucket) {
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
