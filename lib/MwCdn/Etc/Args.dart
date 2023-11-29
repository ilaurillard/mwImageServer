import 'dart:convert';
import 'dart:math';

import 'package:args/args.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';

import '../../MwMs/Etc/Types.dart';

class Args {
  late final String dataDir;
  late final String rootKey;

  Args(
    List<String> args,
  ) {
    final ArgParser parser = ArgParser()
      ..addOption('dataDir', abbr: 'd', defaultsTo: '/data')
      ..addOption('rootKey', abbr: 'k', defaultsTo: '');
    final ArgResults arguments = parser.parse(args);

    dataDir = arguments['dataDir'] as String? ?? '';

    String rk = arguments['rootKey'] as String? ?? '';
    if (rk.isEmpty) {
      rk = randString(24);
    }
    rootKey = rk;

    Console.info('[rootKey] $rootKey');
  }

  String randString(
    int len,
  ) {
    Random random = Random.secure();
    Ids values = Ids.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values).replaceAll('=', '');
  }
}
