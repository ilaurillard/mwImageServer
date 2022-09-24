import 'dart:io';

import 'Args.dart';

class Config {
  late final String dataDir;
  late final String apiKey;

  final int isolates = 2; // cpu cores ...

  final InternetAddress ip = InternetAddress.anyIPv4;
  final int port = 8080;

  Config({
    required Args args,
  }) {
    dataDir = args.dataDir;
    apiKey = args.apiKey;
  }
}
