import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Config.dart';
import 'Model/Resource.dart';
import 'Model/Token.dart';
import 'Types.dart';

class DataStore {
  late final Database db;

  DataStore();

  Future<void> init() async {
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase(
      Config.dataDir + '/database/system.db',
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
    List<dynamic> data = await db.query(
      'Token',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (data.isNotEmpty) {
      print('Loaded token: ' + id);
      Dict row = data.first;
      return Token(
        id,
        bucket: row['bucket'],
        users: _intList(row['users'] ?? ''),
        groups: _intList(row['groups'] ?? ''),
        buckets: _intList(row['buckets'] ?? ''),
        root: (row['root'] as int? ?? 0) == 1,
      );
    } else {
      print('Token not found: ' + id);
    }

    return Token(
      id,
      bucket: 0,
    );
  }

  Future<Resource> createResource(
    int bucket, {
    required String filename,
    List<int> users = const [],
    List<int> groups = const [],
  }) async {
    String id = _randMd5();

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
        Dict row = data.first;
        return Resource(
          id,
          bucket: row['bucket'],
          filename: row['filename'],
          users: _intList(row['users'] ?? ''),
          groups: _intList(row['groups'] ?? ''),
        );
      }
    }

    return Resource(
      id,
      bucket: 0,
      filename: '',
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
        id TEXT PRIMARY KEY NOT NULL,
        bucket INTEGER NOT NULL,
        users TEXT NOT NULL,
        groups TEXT NOT NULL,
        buckets TEXT NOT NULL,
        root BOOLEAN DEFAULT 0 NOT NULL CHECK (root IN (0, 1))
    )
  ''');

      await db.execute('''
    CREATE TABLE Resource (
        id TEXT PRIMARY KEY NOT NULL,
        bucket INTEGER NOT NULL,
        filename TEXT NOT NULL,
        users TEXT NOT NULL,
        groups TEXT NOT NULL
    )
  ''');

      await db.insert('Resource', {
        'id': 'aaaabbbbccccddddaaaabbbbccccdddd',
        'bucket': 77,
        'users': '55;66',
        'groups': '666',
        'filename': 'original.jpg',
      });
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

  List<int> _intList(String csv) {
    if (csv.isEmpty) {
      return [];
    }
    List<String> ls = (List<String>.from(csv.split(';')));
    return ls.map((String s) => int.parse(s)).toList();
  }
}
