import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Model/Resource.dart';
import 'package:path/path.dart';

class FileStorage {
  final String dataDir;

  FileStorage({
    required this.dataDir,
  }) {
    print('[filesystem] ' + dataDir);
  }

  // ---------------------

  Future<bool> dirExists(
    String path,
  ) async {
    path = dataDir + path;
    return await Directory(path).exists();
  }

  // ---------------------

  Future<bool> fileExists(
    String path,
  ) async {
    path = dataDir + path;
    return await File(path).exists();
  }

  // ---------------------

  Future<Directory> createDir(
    String path,
  ) async {
    path = dataDir + path;
    return await Directory(path).create(
      recursive: true,
    );
  }

  // ---------------------

  Future<File> createFile(
    String path,
    Uint8List bytes,
  ) async {
    print(
      ' Store ' + bytes.length.toString() + ' bytes to ' + path,
    );

    path = dataDir + path;
    File f = await File(path).create(
      recursive: true,
    );
    return f.writeAsBytes(bytes);
  }

  // ---------------------

  Future<bool> flushResourceFiles(
    Resource resource,
  ) async {
    // delete all files for resource, except original
    String path = dataDir + resource.path();
    if (await dirExists(resource.path())) {
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

  Future<bool> deleteResourceFiles(
    Resource resource,
  ) async {
    // delete all files for resource (including folder)
    String path = dataDir + resource.path();

    if (await dirExists(resource.path())) {
      await Directory(path).delete(
        recursive: true,
      );
      return true;
    }

    return false;
  }
}
