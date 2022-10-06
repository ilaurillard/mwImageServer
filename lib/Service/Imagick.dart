import 'dart:io';

import 'package:mwcdn/Model/Method.dart';

class Imagick {
  final String dataDir;

  Imagick({
    required this.dataDir,
  });

  Future<void> init() async {
    print('[imagemagick]');
    ProcessResult result = await Process.run(
      'convert',
      ['-version'],
    );
    if (exitCode == 1) {
      print(result.stderr);
      throw 'Imagick error';
    }
    print(result.stdout);
  }

  // ---------------------

  Future<void> convert(
    String sourcePath,
    String targetPath,
    Method method,
  ) async {
    sourcePath = dataDir + sourcePath;
    targetPath = dataDir + targetPath;

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
      [sourcePath, '-thumbnail', '100x100', targetPath],
    );

    if (exitCode == 1) {
      print(result.stderr);
      throw 'Imagick error';
    } else {
      print(result.stdout);
    }
  }
}
