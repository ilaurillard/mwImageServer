import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Config.dart';
import 'Model/Resource.dart';
import 'Model/Token.dart';

class DataStore {
  final Config cfg;
  late final Database db;

  DataStore({
    required this.cfg,
  });

  Future<void> init() async {
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase(
      cfg.dataDir + '/database/system.db',
      options: OpenDatabaseOptions(
        version: 1,
        onUpgrade: schema,
      ),
    );
    print('>>> sqlite db: ' + db.toString() + "\n");
  }

  Future<Token> createToken(
    int bucket, {
    List<int> users = const [],
    List<int> groups = const [],
    List<int> buckets = const [],
    bool root = false,
  }) async {
    String id = _randMd5();

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

  Future<Token> token(
    String id,
  ) async {

    print('Load token: ' + id);

    List<dynamic> data = await db.query(
      'Token',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (data.isNotEmpty) {
      Map<String, dynamic> row = data.first;
      return Token(
        id,
        bucket: row['bucket'],
        users: intList(row['users'] ?? ''),
        groups: intList(row['groups'] ?? ''),
        buckets: intList(row['buckets'] ?? ''),
        root: (row['root'] as int? ?? 0) == 1,
      );
    }

    return Token(
      id,
      bucket: 0,
    );
  }

  List<int> intList(String csv)
  {
    if (csv.isEmpty) {
      return [];
    }
    List<String> ls = (List<String>.from(csv.split(';')));
    return ls.map((String s) => int.parse(s)).toList();
  }

  Resource resource(
    String id,
  ) {
    // TODO

    return Resource(
      id,
      77,
      users: [55],
      groups: [666],
    );
  }

  Future<void> schema(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (newVersion == 1 && oldVersion < 1) {
      await db.execute('''
    CREATE TABLE Token (
        id TEXT PRIMARY KEY,
        bucket INTEGER,
        users TEXT,
        groups TEXT,
        buckets TEXT,
        root BOOLEAN DEFAULT 0 NOT NULL CHECK (root IN (0, 1))
    )
  ''');

      await db.execute('''
    CREATE TABLE Resource (
        id TEXT PRIMARY KEY,
        bucket INTEGER,
        users TEXT,
        groups TEXT
    )
  ''');
    }
  }

  String _randMd5() {
    return md5
        .convert(
          utf8.encode(
            Random().nextDouble().toString(),
          ),
        )
        .toString();
  }
}
