import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:sqflite_common/sqlite_api.dart';

class BucketRepository {
  late final Database db;

  BucketRepository(this.db);

  Future<Bucket> create(
    int id,
    String name,
  ) async {
    // printNotice('sqliteStorage:createBucket');

    Bucket bucket = Bucket.fresh(
      id,
      name,
    );

    await db.insert(
      'Bucket',
      bucket.toDatabase(),
    );

    return bucket;
  }

  // ---------------------

  Future<void> update(
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

  Future<Bucket> load(
    int id,
  ) async {
    List<dynamic> data = await db.query(
      'Bucket',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (data.isNotEmpty) {
      printNotice('Loaded bucket: ' + id.toString());
      return Bucket.fromDatabase(
        data.first as Dict,
      );
    } else {
      printWarning(
        ' Bucket not found: ' + id.toString(),
      );
    }

    return Bucket.notFound(id);
  }
}
