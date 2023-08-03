import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:sqflite_common/sqlite_api.dart';

class TokenRepository {
  late final Database db;

  TokenRepository(this.db);

// ----------------- TOKEN

  Future<Token> create(
    int bucket, {
    Ids users = const [],
    Ids groups = const [],
    Ids buckets = const [],
    bool root = false,
  }) async {
    String id = Util.randMd5();

    // printNotice('sqliteStorage:createToken ' + id);

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

  Future<Token> load(
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
        Console.notice('Loaded token: $id');
        return Token.fromDatabase(data.first as Dict);
      } else {
        Console.warning('Token not found: $id');
      }
    }
    return Token.notFound(id);
  }

  // Future<Token> last(
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

  Future<int> count([
    Bucket? bucket,
  ]) async {
    List<dynamic> data = await db.query(
      'Token',
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
