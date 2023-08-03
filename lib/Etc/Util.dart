import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:mwcdn/Etc/Types.dart';

class Util {

  // ----------------

  static String randMd5() {
    return md5
        .convert(
          utf8.encode(
            Random().nextDouble().toString(),
          ),
        )
        .toString();
  }

  // ----------------

  static List<String> replaceParameters(
    List<String> parameters,
    KeyValue map,
  ) {
    List<String> replaced = [];
    for (String p in parameters) {
      if (p.contains('%')) {
        map.forEach((String key, String value) {
          p = p.replaceAll(
            '%$key%',
            value,
          );
        });
      }
      replaced.add(p);
    }
    return replaced;
  }
}
