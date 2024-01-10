import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Model/ResourceInterface.dart';
import 'package:path/path.dart';

class FileStorage {
  final String dataDir;
  final String resDir;

  FileStorage({
    required this.dataDir,
    required this.resDir,
  }) {
    Console.info('[filesystem] data: $dataDir, res: $resDir');
  }

  // ---------------------

  Future<bool> dirExists(
    String path,
  ) async {
    path = dataDir + path;
    return await Directory(path).exists();
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

  Future<File> createFileFromBytes(
    String path,
    Uint8List bytes,
  ) async {
    Console.notice(
      'Writing ${bytes.length} bytes to $path',
    );
    File f = await File(dataDir + path).create(
      recursive: true,
    );
    return f.writeAsBytes(
      bytes,
      flush: true,
    );
  }

  Future<File> createFileFromString(
    String path,
    String binary,
  ) async {
    Console.notice(
      'Writing ${binary.length} bytes to $path',
    );
    File f = await File(dataDir + path).create(
      recursive: true,
    );
    return f.writeAsString(
      binary,
      flush: true,
    );
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

  Future<Dict> fileDataAsJson(
    ResourceInterface resource,
  ) async {
    if (await dirExists(resource.path())) {
      String filename = '${resource.path()}/${resource.filename}';
      if (await fileExists(filename)) {
        File f = file(filename);
        String content = await f.readAsString();
        return json.decode(content) as Dict;
      }
    }
    return {};
  }

  Future<Uint8List> fileData(
    ResourceInterface resource,
  ) async {
    if (await dirExists(resource.path())) {
      String filename = '${resource.path()}/${resource.filename}';
      if (await fileExists(filename)) {
        File f = file(filename);
        return await f.readAsBytes();
      }
    }
    return Uint8List(0);
  }

  // ---------------------

  String cacheKey(
    String url,
  ) {
    return md5.convert(url.codeUnits).toString();
  }

  String cachePath(
    String cacheKey,
  ) {
    return '/cache/${cacheKey.substring(0, 2)}/${cacheKey.substring(2, 4)}';
  }

  void putCache(
    String cacheKey,
    String binary,
  ) async {
    String path = cachePath(cacheKey);
    if (!await dirExists(path)) {
      await createDir(path);
    }
    String filename = '$path/$cacheKey';
    await createFileFromString(
      filename,
      binary,
    );
  }

  Future<bool> hasCache(
    String cacheKey,
  ) async {
    String path = cachePath(cacheKey);
    String filename = '$path/$cacheKey';
    return fileExists(filename);
  }

  Future<String> loadCache(
    String cacheKey,
  ) async {
    String path = cachePath(cacheKey);
    String filename = '$path/$cacheKey';
    if (await fileExists(filename)) {
      File f = file(filename);
      return f.readAsString();
    }
    return '';
  }

  // ---------------------

  Future<bool> flushResourceFiles(
    ResourceInterface resource,
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
    ResourceInterface resource,
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

  void storeResource(
    ResourceInterface resource,
    Uint8List bytes,
  ) async {
    File file = await createFileFromBytes(
      '${resource.path()}/${resource.filename}',
      bytes,
    );
    int realSize = file.lengthSync();
    if (realSize != bytes.length) {
      throw 'length check failed ($realSize vs ${bytes.length})';
    }
  }
}
