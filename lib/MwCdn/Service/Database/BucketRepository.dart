import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwCdn/Model/Bucket.dart';
import 'package:sqflite_common/sqlite_api.dart';

class BucketRepository {
  late final Database db;

  BucketRepository(this.db);

  Future<Bucket> create(
    int id,
    String name,
  ) async {
    // Console.notice('sqliteStorage:createBucket');

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
      bucket.toDatabaseUpdate(),
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
      Console.notice('Loaded bucket: $id');
      return Bucket.fromDatabase(
        data.first as Dict,
      );
    } else {
      Console.warning(
        ' Bucket not found: $id',
      );
    }

    return Bucket.notFound(id);
  }

  // ---------------------

  Future<int> count(
      ) async {
    List<dynamic> data = await db.query(
      'Bucket',
      columns: ['COUNT (*) AS amount'],
      limit: 1,
    );
    if (data.isNotEmpty) {
      Dict row = data.first as Dict;
      return row['amount'] as int;
    }
    return 0;
  }
}
