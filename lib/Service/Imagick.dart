import 'dart:io';

import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Model/Method.dart';

class Imagick {
  Imagick();

  Future<String> version() async {
    print('[imagemagick]');
    ProcessResult result = await Process.run(
      'convert',
      ['-version'],
    );
    if (exitCode == 1) {
      print(result.stderr);
      throw 'Imagick error';
    }
    return ' ' + result.stdout;
  }

  // ---------------------

  Future<void> convert(
    String sourcePath,
    String targetPath,
    Method method,
  ) async {
    sourcePath = Config.dataDir + sourcePath;
    targetPath = Config.dataDir + targetPath;

    print(
      ' Magic from ' +
          sourcePath +
          ' to ' +
          targetPath +
          ' method ' +
          method.name,
    );

    ProcessResult result = await Process.run(
      'convert',
      [sourcePath, '-thumbnail',  '100x100', targetPath],
    );

    if (exitCode == 1) {
      print(result.stderr);
      throw 'Imagick error';
    }
    else {
      print(result.stdout);
    }
  }
}
