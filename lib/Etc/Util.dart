import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:path/path.dart';
import 'package:shelf/shelf.dart';
import 'package:string_scanner/string_scanner.dart';

class Util {
  // ----------------

  static bool validBucket(int bucketId) {
    return bucketId > 0 && bucketId <= Config.maxBucket;
  }

  // ----------------

  static Response invalidBucket() {
    return Response.badRequest(body: 'Invalid bucket');
  }

  // ----------------

  static Response jsonResponse(
    JsonSerializable subject,
  ) {
    return Response.ok(
      json.encode(subject.toJson()),
      headers: Config.jsonHeaders,
    );
  }

  // ----------------

  static Future<Dict> jsonObject(
    Request request,
  ) async {
    String tmp = await request.readAsString();
    return json.decode(tmp) as Dict;
  }

  // ----------------

  static List<int> intListData(
    Dict data,
    String key,
  ) {
    return List<int>.from(
      data[key] as List? ?? [],
    );
  }

  // ----------------

  static List<String> stringListData(
      Dict data,
      String key,
      ) {
    return List<String>.from(
      data[key] as List? ?? [],
    );
  }

  // ----------------

  static List<int> intList(
    String csv,
  ) {
    if (csv.isEmpty) {
      return [];
    }
    List<String> ls = (List<String>.from(csv.split(';')));
    return ls.map((String s) => int.parse(s)).toList();
  }

  // ----------------

  static bool boolData(
    Dict data,
    String key,
  ) {
    return data[key] as bool? ?? false;
  }

  // ----------------

  static int intData(
    Dict data,
    String key,
  ) {
    return data[key] as int? ?? 0;
  }

  // ----------------

  static String stringData(
      Dict data,
      String key,
      ) {
    return data[key] as String? ?? '';
  }

  // ----------------

  static bool validFilename(
    String filename,
  ) {
    if (!Config.acceptedSuffixes.contains(
      Util.suffix(
        filename,
      ),
    )) {
      return false;
    }

    String base = basenameWithoutExtension(filename);
    if (RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(base)) {
      return true;
    }

    return false;
  }

  // ----------------

  static bool validMimetype(
    String filename,
    String mimeType,
  ) {
    return (Config.mimeToSuffix[mimeType] ?? []).contains(
      Util.suffix(
        filename,
      ),
    );
  }

  // ----------------

  static String suffix(
    String filename,
  ) {
    return extension(filename);
  }

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

  static Map<String, String> parseContentDisposition(
    String header,
  ) {
    final scanner = StringScanner(header);

    final _token = RegExp(r'[^()<>@,;:"\\/[\]?={} \t\x00-\x1F\x7F]+');
    final _whitespace = RegExp(r'(?:(?:\r\n)?[ \t]+)*');
    final _quotedString = RegExp(r'"(?:[^"\x00-\x1F\x7F]|\\.)*"');
    final _quotedPair = RegExp(r'\\(.)');

    scanner
      ..scan(_whitespace)
      ..expect(_token);
    if (scanner.lastMatch![0] != 'form-data') return {};

    final params = <String, String>{};

    while (scanner.scan(';')) {
      scanner
        ..scan(_whitespace)
        ..scan(_token);
      final key = scanner.lastMatch![0]!;
      scanner.expect('=');

      String value;
      if (scanner.scan(_token)) {
        value = scanner.lastMatch![0]!;
      } else {
        scanner.expect(_quotedString, name: 'quoted string');
        final string = scanner.lastMatch![0]!;

        value = string
            .substring(1, string.length - 1)
            .replaceAllMapped(_quotedPair, (match) => match[1]!);
      }

      scanner.scan(_whitespace);
      params[key] = value;
    }

    scanner.expectDone();
    return params;
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
            '%' + key + '%',
            value,
          );
        });
      }
      replaced.add(p);
    }
    return replaced;
  }
}
