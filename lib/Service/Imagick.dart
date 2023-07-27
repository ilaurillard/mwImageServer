import 'dart:io';

import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Method.dart';

class Imagick {
  final String dataDir;

  Imagick({
    required this.dataDir,
  });

  Future<void> init() async {
    printInfo('[imagemagick]');
    ProcessResult result = await Process.run(
      'convert',
      ['-version'],
    );
    if (exitCode == 1) {
      printError(result.stderr.toString());
      throw 'Imagick error';
    }
    printNotice(result.stdout.toString());
  }

  // ---------------------

  Future<void> convert(
    String sourcePath,
    String targetPath,
    Method method,
  ) async {
    sourcePath = dataDir + sourcePath;
    targetPath = dataDir + targetPath;

    printNotice(
      'Magic from ' +
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
      printError(result.stderr.toString());
    } else {
      printNotice(result.stdout.toString());
    }
  }
}
