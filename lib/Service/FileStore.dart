import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:path/path.dart';

class FileStore {
  FileStore();

  // ---------------------

  Future<void> init() async {
    print('[filesystem]');
    print(Config.dataDir);
    print('');
  }

  // ---------------------

  Future<bool> dirExists(
    String path,
  ) async {
    path = Config.dataDir + path;
    return await Directory(path).exists();
  }

  // ---------------------

  Future<bool> fileExists(
    String path,
  ) async {
    path = Config.dataDir + path;
    return await File(path).exists();
  }

  // ---------------------

  Future<Directory> createDir(
    String path,
  ) async {
    // print('FileStore:createDir');

    path = Config.dataDir + path;
    return await Directory(path).create(
      recursive: true,
    );
  }

  // ---------------------

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

  // ---------------------

  Future<bool> flush(
    Resource resource,
  ) async {
    // print('FileStore:flush');
    // delete all files for resource, except original
    String path = Config.dataDir + '/' + resource.path();
    if (await dirExists('/' + resource.path())) {
      await for (FileSystemEntity file in Directory(path).list()) {
        if (file is File) {
          if (basename(file.path) != resource.filename) {
            await file.delete();
          }
        }
      }
      return true;
    }
    return false;
  }

  // ---------------------

  Future<bool> delete(
    Resource resource,
  ) async {
    // print('FileStore:delete');
    // delete all files for resource

    String path = Config.dataDir + '/' + resource.path();

    if (await dirExists('/' + resource.path())) {
      await Directory(path).delete(
        recursive: true,
      );
      return true;
    }

    return false;
  }
}
