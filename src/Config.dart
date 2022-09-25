import 'dart:io';

import 'Args.dart';

class Config {
  late final String dataDir;
  late final String rootKey;

  final int isolates = 1; // cpu cores ...

  final InternetAddress ip = InternetAddress.anyIPv4;
  final int port = 8080;

  // final String paramVis = '/<vis|public|private>';
  final String paramBucket = '/<bucket|[0-9]{1,8}>';
  final String paramSeg1 = '/<any|[a-f0-9]{2}>';
  final String paramSeg2 = '/<any|[a-f0-9]{2}>';
  final String paramRes = '/<resource|[a-f0-9]{32}>';
  final String paramFile = '/<file|.*>';

  Config({
    required Args args,
  }) {
    dataDir = args.dataDir;
    rootKey = args.rootKey;
  }
}
