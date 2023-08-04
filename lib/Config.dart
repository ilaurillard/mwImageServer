import 'dart:io';

import 'package:mwcdn/Etc/Types.dart';

class Config {

  static final String dataDir = '/home/ilja/PhpstormProjects/mwcdn/data';

  static const int isolates = 1; // cpu cores ...

  static final InternetAddress ip = InternetAddress.anyIPv4;
  static const int port = 8080;

  static const String matchBucket = '/<bucket|[0-9]{1,8}>';
  static const String matchSeg1 = '/<any|[a-f0-9]{2}>';
  static const String matchSeg2 = '/<any|[a-f0-9]{2}>';
  static const String matchResource = '/<resource|[a-f0-9]{32}>';
  static const String matchToken = '/<token|[a-f0-9]{32}>';
  static const String matchMethod = '/<method|[a-z0-9]{1,24}>';
  static const String matchFile = '/<file|.*>';

  static const int maxBucket = 99999;

  static RegExp validBucketName = RegExp(r'^[a-zA-Z0-9]{0,24}$');
  static RegExp validMethodName = RegExp(r'^[a-zA-Z0-9]{1,16}$');

  static const int maxFileSize = 1000000;

  static const List<String> acceptedTypes = [
    'image/jpeg',
    'application/json'
  ];
  static const List<String> acceptedSuffixes = [
    '.jpg',
    '.jpeg',
    '.json',
    '.pdf',
  ];
  static const Map<String, List<String>> mimeToSuffix = {
    'image/jpeg': ['.jpg', '.jpeg',],
    'application/json': ['.json',],
    'application/pdf': ['.pdf',],
  };

  static const KeyValue jsonHeaders = {
    'content-type': 'application/json',
  };

}

