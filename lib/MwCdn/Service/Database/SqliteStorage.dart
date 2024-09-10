import 'package:mwcdn/MwCdn/Model/Bucket.dart';
import 'package:mwcdn/MwCdn/Model/Resource.dart';
import 'package:mwcdn/MwCdn/Model/Schema/Schema.dart';
import 'package:mwcdn/MwCdn/Model/Token.dart';
import 'package:mwcdn/MwCdn/Service/Database/BucketRepository.dart';
import 'package:mwcdn/MwCdn/Service/Database/ResourceRepository.dart';
import 'package:mwcdn/MwCdn/Service/Database/TokenRepository.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Model/Entity.dart';
// import 'package:sqflite_common/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteStorage {
  late final Database db;

  late final BucketRepository buckets;
  late final TokenRepository tokens;
  late final ResourceRepository resources;

  final String dataDir;

  SqliteStorage({
    required this.dataDir,
  });

  // ---------------------

  static Future<SqliteStorage> create({
    required String dataDir,
  }) async {
    SqliteStorage sqliteStorage = SqliteStorage(
      dataDir: dataDir,
    );
    await sqliteStorage.init();
    return sqliteStorage;
  }

  Future<void> init() async {
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase(
      '$dataDir/database/system.db',
      options: OpenDatabaseOptions(
        version: 1,
        onUpgrade: Schema.schema,
        singleInstance: false,
      ),
    );
    Console.info('[sqlite] ${db.path}');

    buckets = BucketRepository(db);
    tokens = TokenRepository(db);
    resources = ResourceRepository(db);
  }

  Future<bool> deleteEntity(
    // Token, Resource, ...
    Entity entity,
  ) async {
    Console.notice('Delete #${entity.id} --> $entity');

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
