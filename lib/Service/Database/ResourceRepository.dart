import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ResourceRepository {
  late final Database db;

  ResourceRepository(this.db);

  // ----------------- RESOURCE

  Future<Resource> create(
    int bucket, {
    required String filename,
    String mimeType = '',
    int size = 0,
    Ids users = const [],
    Ids groups = const [],
  }) async {
    String id = Util.randMd5();

    // printNotice('sqliteStorage:createToken ' + id);

    Resource resource = Resource(
      id,
      bucket: bucket,
      filename: filename,
      mimeType: mimeType,
      size: size,
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

  Future<void> update(
    Resource resource,
  ) async {
    await db.update(
      'Resource',
      resource.toDatabaseUpdate(),
      where: 'id = ?',
      whereArgs: [
        resource.id,
      ],
    );
  }

  // ---------------------

  Future<Resource> load(
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
        Console.notice('Loaded resource: $id');
        // Console.notice(data.toString());
        return Resource.fromDatabase(
          data.first as Dict,
        );
      } else {
        Console.warning('Resource not found: $id');
      }
    }
    return Resource.notFound(id);
  }

  // Future<Resource> last(
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

  Future<int> count([
    Bucket? bucket,
  ]) async {
    List<dynamic> data = await db.query(
      'Resource',
      columns: ['COUNT (*) AS amount'],
      where: bucket != null ? 'bucket = ?' : null,
      whereArgs: bucket != null ? [bucket.id] : null,
      limit: 1,
    );
    if (data.isNotEmpty) {
      Dict row = data.first as Dict;
      return row['amount'] as int;
    }
    return 0;
  }
}
