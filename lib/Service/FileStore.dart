import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Config.dart';

class FileStore {
  FileStore();

  Future<void> init() async {
    print('[filesystem]');
    print(Config.dataDir);
    print('');
  }

  Future<bool> dirExists(
    String path,
  ) async {
    path = Config.dataDir + path;
    return await Directory(path).exists();
  }

  Future<Directory> createDir(
    String path,
  ) async {
    path = Config.dataDir + path;
    return await Directory(path).create(
      recursive: true,
    );
  }

  Future<File> createFile(
    String path,
    Uint8List bytes,
  ) async {
    path = Config.dataDir + path;
    File f = await File(path).create(
      recursive: true,
    );
    return f.writeAsBytes(bytes);
  }
}
