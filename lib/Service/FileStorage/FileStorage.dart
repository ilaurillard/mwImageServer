import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:path/path.dart';

class FileStorage {
  final String dataDir;

  FileStorage({
    required this.dataDir,
  }) {
    Console.info('[filesystem] $dataDir');
  }

  // ---------------------

  Future<bool> dirExists(
    String path,
  ) async {
    path = dataDir + path;
    return await Directory(path).exists();
  }

  // ---------------------


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
    Console.notice(
      'Writing ${bytes.length} bytes to $path',
    );

    path = dataDir + path;
    File f = await File(path).create(
      recursive: true,
    );
    return f.writeAsBytes(bytes, flush: true,);
  }

  // ---------------------

  File file(
      String path,
      ) {
    path = dataDir + path;
    return File(path);
  }

  Future<bool> fileExists(
      String path,
      ) async {
    path = dataDir + path;
    return await File(path).exists();
  }

  Future<Dict> fileData(
      Resource resource,
      ) async {
    if (await dirExists(resource.path())) {
      String filename = '${resource.path()}/${resource.filename}';
      if (await fileExists(filename)) {
        File f = file(filename);
        String content = await f.readAsString();

        // print(content);

        return json.decode(content) as Dict;
      }
    }
    return {};
  }

  // ---------------------

  Future<bool> flushResourceFiles(
    Resource resource,
  ) async {
    // delete all files for resource, except original
    if (await dirExists(resource.path())) {
      String path = dataDir + resource.path();
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
