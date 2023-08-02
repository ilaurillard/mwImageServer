import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:path/path.dart';
import 'package:shelf/shelf.dart';
// ignore: depend_on_referenced_packages
import 'package:string_scanner/string_scanner.dart';

class Util {
  // ----------------

  static bool validBucket(int id) {
    return id > 0 && id <= Config.maxBucket;
  }

  // ----------------

  static Future<Dict> jsonObject(
    Request request,
  ) async {
    String tmp = await request.readAsString();

    Dict data;
    try {
      data = json.decode(tmp) as Dict;
    } catch (e) {
      data = {};
      printWarning('[500] Json decode: $e');
    }

    return data;
  }

  // ----------------

  static List<int> intListData(
    Dict data,
    String key,
  ) {
    List<int> list = List<int>.from(
      data[key] as List? ?? [],
    ).toSet().toList().where((int i) => i > 0).toList();
    list.sort();
    return list;
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

    final token = RegExp(r'[^()<>@,;:"\\/[\]?={} \t\x00-\x1F\x7F]+');
    final whitespace = RegExp(r'(?:(?:\r\n)?[ \t]+)*');
    final quotedString = RegExp(r'"(?:[^"\x00-\x1F\x7F]|\\.)*"');
    final quotedPair = RegExp(r'\\(.)');

    scanner
      ..scan(whitespace)
      ..expect(token);
    if (scanner.lastMatch![0] != 'form-data') return {};

    final params = <String, String>{};

    while (scanner.scan(';')) {
      scanner
        ..scan(whitespace)
        ..scan(token);
      final key = scanner.lastMatch![0]!;
      scanner.expect('=');

      String value;
      if (scanner.scan(token)) {
        value = scanner.lastMatch![0]!;
      } else {
        scanner.expect(quotedString, name: 'quoted string');
        final string = scanner.lastMatch![0]!;

        value = string
            .substring(1, string.length - 1)
            .replaceAllMapped(quotedPair, (match) => match[1]!);
      }

      scanner.scan(whitespace);
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
            '%$key%',
            value,
          );
        });
      }
      replaced.add(p);
    }
    return replaced;
  }

  // ----------------

  static Response rJsonOk(
    JsonSerializable subject,
  ) {
    return Response.ok(
      json.encode(subject.toJson()),
      headers: Config.jsonHeaders,
    );
  }

  static Response rBucketError() {
    return Util.rBadRequest('Invalid bucket');
  }

  static Response rNotFound(String message) {
    printWarning('[404] $message');
    return Response.notFound(
      message,
      headers: Config.jsonHeaders,
    );
  }

  static Response rError(String message) {
    printWarning('[500] $message');
    return Response.internalServerError(
      body: message,
      headers: Config.jsonHeaders,
    );
  }

  static Response rBadRequest(String message) {
    printWarning('[400] $message');
    return Response.badRequest(
      body: message,
      headers: Config.jsonHeaders,
    );
  }

  static Response rUnauthorized(String message) {
    printWarning('[401] $message');
    return Response.unauthorized(
      message,
      headers: Config.jsonHeaders,
    );
  }

  static Response rForbidden(String message) {
    printWarning('[403] $message');
    return Response.forbidden(
      message,
      headers: Config.jsonHeaders,
    );
  }
}

void printInfo(String text) {
  //print('\x1B[36m$text\x1B[0m');
  print(text);
}

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printError(String text) {
  print('\x1B[31m$text\x1B[0m');
}

void printNotice(String text) {
  print('\x1B[37m$text\x1B[0m');
}
