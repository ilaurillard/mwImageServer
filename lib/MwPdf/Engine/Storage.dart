import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';

class Storage {
  final FileStorage fileStorage;
  final SqliteStorage? sqliteStorage;
  final int bucketId;
  final Token token;

  Storage({
    required this.fileStorage,
    this.sqliteStorage,
    this.bucketId = -1,
    required this.token,
  });
}
