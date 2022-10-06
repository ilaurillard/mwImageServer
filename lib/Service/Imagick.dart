import 'dart:io';

import 'package:mwcdn/Etc/Util.dart';
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
      method.tool,
      Util.replaceParameters(
        method.parameters,
        {
          'source': sourcePath,
          'target': targetPath,
        },
      ),
    );

    if (exitCode == 1) {
      print(result.stderr);
      throw 'Imagick error';
    } else {
      print(result.stdout);
    }
  }
}
