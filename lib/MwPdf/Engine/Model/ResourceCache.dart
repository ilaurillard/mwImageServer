import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class ResourceCache {
  final String cacheDir;

  ResourceCache({
    required this.cacheDir,
  });

  String cachePath(
    String cacheKey,
  ) {
    return '/${cacheKey.substring(0, 2)}/${cacheKey.substring(2, 4)}';
  }

  String cacheKey(
    String url,
  ) {
    return md5.convert(url.codeUnits).toString();
  }

  void put(
    String cacheKey,
    String binary,
  ) async {
    String path = cachePath(cacheKey);
    if (!await dirExists(path)) {
      await createDir(path);
    }
    String filename = '$path/$cacheKey';
    await createFile(filename, binary);
  }

  Future<bool> has(
    String cacheKey,
  ) async {
    String path = cachePath(cacheKey);
    String filename = '$path/$cacheKey';
    return fileExists(filename);
  }

  Future<String> get(
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

  Future<File> createFile(
    String path,
    String binary,
  ) async {
    path = cacheDir + path;
    File f = await File(path).create(
      recursive: true,
    );
    return f.writeAsString(
      binary,
      flush: true,
    );
  }

  Future<bool> dirExists(
    String path,
  ) async {
    path = cacheDir + path;
    return await Directory(path).exists();
  }

  Future<Directory> createDir(
    String path,
  ) async {
    path = cacheDir + path;
    return await Directory(path).create(
      recursive: true,
    );
  }

  File file(
    String path,
  ) {
    path = cacheDir + path;
    return File(path);
  }

  Future<bool> fileExists(
    String path,
  ) async {
    path = cacheDir + path;
    return await File(path).exists();
  }
}
