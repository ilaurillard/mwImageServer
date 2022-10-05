import 'dart:io';

import 'package:mwcdn/Args.dart';
import 'package:mwcdn/Etc/Types.dart';

class Config {
  static void init({
    required Args args,
  }) {
    dataDir = args.dataDir;
    rootKey = args.rootKey;
  }

  static late final String dataDir;
  static late final String rootKey;

  static const int isolates = 1; // cpu cores ...

  static final InternetAddress ip = InternetAddress.anyIPv4;
  static const int port = 8080;

  // final String paramVis = '/<vis|public|private>';
  static const String paramBucket = '/<bucket|[0-9]{1,8}>';
  static const String paramSeg1 = '/<any|[a-f0-9]{2}>';
  static const String paramSeg2 = '/<any|[a-f0-9]{2}>';
  static const String paramResource = '/<resource|[a-f0-9]{32}>';
  static const String paramToken = '/<token|[a-f0-9]{32}>';
  static const String paramFile = '/<file|.*>';

  static const KeyValue jsonHeaders = {'content-type': 'application/json'};

  static const int maxFileSize = 1000000;
  static const List<String> acceptedTypes = [
    'image/jpeg',
  ];
  static const List<String> acceptedSuffixes = [
    '.jpg',
    '.jpeg',
  ];
  static const Map<String, List<String>> mimeToSuffix = {
    'image/jpeg': ['.jpg', '.jpeg'],
  };
}
