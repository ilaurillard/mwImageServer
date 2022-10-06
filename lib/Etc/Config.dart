import 'dart:io';

import 'package:mwcdn/Etc/Types.dart';

class Config {

  static final String dataDir = '/home/ilja/PhpstormProjects/mwcdn/data';

  static const int isolates = 1; // cpu cores ...

  static final InternetAddress ip = InternetAddress.anyIPv4;
  static const int port = 8080;

  // final String paramVis = '/<vis|public|private>';
  static const String matchBucket = '/<bucket|[0-9]{1,8}>';
  static const String matchSeg1 = '/<any|[a-f0-9]{2}>';
  static const String matchSeg2 = '/<any|[a-f0-9]{2}>';
  static const String matchResource = '/<resource|[a-f0-9]{32}>';
  static const String matchToken = '/<token|[a-f0-9]{32}>';
  static const String matchFile = '/<file|.*>';

  static const KeyValue jsonHeaders = {
    'content-type': 'application/json',
  };

  static const int maxBucket = 99999;

  static const int maxFileSize = 1000000;
  static const List<String> acceptedTypes = [
    'image/jpeg',
  ];
  static const List<String> acceptedSuffixes = [
    '.jpg',
    '.jpeg',
  ];
  static const Map<String, List<String>> mimeToSuffix = {
    'image/jpeg': ['.jpg', '.jpeg',],
  };
}
