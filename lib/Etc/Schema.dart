import 'package:sqflite_common/sqlite_api.dart';

class Schema {
  static Future<void> schema(
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
        root BOOLEAN DEFAULT 0 NOT NULL CHECK (root IN (0, 1)),
        stamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        created DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  ''');

      await db.execute('''
    CREATE TABLE Resource (
        id TEXT PRIMARY KEY NOT NULL,
        bucket INTEGER NOT NULL,
        filename TEXT NOT NULL,
        mimeType TEXT DEFAULT "" NOT NULL,
        size INTEGER DEFAULT 0 NOT NULL,
        users TEXT NOT NULL,
        groups TEXT NOT NULL,
        created DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  ''');

      await db.execute('''
    CREATE TABLE Bucket (
        id INTEGER PRIMARY KEY NOT NULL,
        name TEXT NOT NULL,
        methods TEXT DEFAULT "[]" NOT NULL,
        created DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  ''');
    }
  }
}
