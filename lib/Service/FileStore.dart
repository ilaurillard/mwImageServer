import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Model/Resource.dart';

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

  Future<bool> fileExists(
      String path,
      ) async {
    path = Config.dataDir + path;
    return await File(path).exists();
  }

  Future<Directory> createDir(
    String path,
  ) async {
    // print('FileStore:createDir');

    path = Config.dataDir + path;
    return await Directory(path).create(
      recursive: true,
    );
  }

  Future<File> createFile(
    String path,
    Uint8List bytes,
  ) async {
    // print('FileStore:createFile');

    path = Config.dataDir + path;
    File f = await File(path).create(
      recursive: true,
    );
    return f.writeAsBytes(bytes);
  }

  Future<bool> delete(
    Resource resource,
  ) async {
    // print('FileStore:delete');
    // delete all files for resource

    String path = Config.dataDir + '/' + resource.path();
    // print(path);

    if (await dirExists('/' + resource.path())) {

      print('+++');

      await Directory(path).delete(
        recursive: true,
      );
      return true;
    }

    return false;
  }
}
