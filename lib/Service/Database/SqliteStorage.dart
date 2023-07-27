import 'package:mwcdn/Etc/Schema.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Entity.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/Database/BucketRepository.dart';
import 'package:mwcdn/Service/Database/ResourceRepository.dart';
import 'package:mwcdn/Service/Database/TokenRepository.dart';
import 'package:sqflite_common/sqlite_api.dart';
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
    printInfo('[sqlite] ' + db.path);

    buckets = BucketRepository(db);
    tokens = TokenRepository(db);
    resources = ResourceRepository(db);
  }

  Future<bool> deleteEntity(
    // Token, Resource, ...
    Entity entity,
  ) async {
    printNotice('Delete #' + entity.id + ' --> ' + entity.toString());

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
