import 'dart:io';

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
    return result.stdout;
  }
}
