import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Model/JsonSerializable.dart';
import 'package:shelf/shelf.dart';
// ignore: depend_on_referenced_packages
import 'package:string_scanner/string_scanner.dart';

class Util {
  static const KeyValue jsonHeaders = {
    'content-type': 'application/json',
  };
  static const KeyValue pdfHeaders = {
    'content-type': 'application/pdf',
  };

  static const Map<String, List<String>> mimeToSuffix = {
    'image/jpeg': [
      '.jpg',
      '.jpeg',
    ],
    'application/json': [
      '.json',
    ],
    'application/pdf': [
      '.pdf',
    ],
  };

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

  // ----------------

  static Future<Dict> incomingJson(
    Request request, {
    bool throwError = false,
  }) async {
    String tmp = await request.readAsString();

    Dict data;
    try {
      data = json.decode(tmp) as Dict;
    } catch (e) {
      data = {};
      Console.warning('[500] Json decode: $e');
      if (throwError) {
        throw ResponseException(
          Util.rBadRequest(
            message: json.encode({
              'errors': [
                e.toString(),
              ]
            })
          ),
        );
      }
    }

    return data;
  }

  // ----------------

  static Response rJsonOk(
    JsonSerializable subject,
  ) {
    return Response.ok(
      json.encode(subject.toJson()),
      headers: jsonHeaders,
    );
  }

  static Response rBucketError() {
    return rBadRequest(message: 'Invalid bucket');
  }

  static Response rNotFound({
    String message = 'Not found',
  }) {
    Console.warning('[404] $message');
    return Response.notFound(
      message,
      headers: jsonHeaders,
    );
  }

  static Response rError({
    String message = 'Error',
  }) {
    Console.warning('[500] $message');
    return Response.internalServerError(
      body: message,
      headers: jsonHeaders,
    );
  }

  static Response rBadRequest({
    String message = 'Bad request',
  }) {
    Console.warning('[400] $message');
    return Response.badRequest(
      body: message,
      headers: jsonHeaders,
    );
  }

  static Response rUnauthorized({
    String message = 'Unauthorized',
  }) {
    Console.warning('[401] $message');
    return Response.unauthorized(
      message,
      headers: jsonHeaders,
    );
  }

  static Response rForbidden({
    String message = 'Forbidden',
  }) {
    Console.warning('[403] $message');
    return Response.forbidden(
      message,
      headers: jsonHeaders,
    );
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
}
