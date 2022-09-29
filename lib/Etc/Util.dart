import 'dart:convert';

import 'package:path/path.dart';
import 'package:shelf/shelf.dart';
import 'package:string_scanner/string_scanner.dart';

import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:mwcdn/Etc/Types.dart';

class Util {
  static Map<String, String> dispo(
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

  static Response jsonResponse(
    JsonSerializable subject,
  ) {
    return Response.ok(
      json.encode(subject.toJson()),
      headers: Config.jsonHeaders,
    );
  }

  static Response invalidbucket() {
    return Response.badRequest(body: 'Invalid bucket');
  }

  static Future<Dict> jsonObject(
    Request request,
  ) async {
    String tmp = await request.readAsString();
    return json.decode(tmp);
  }

  static List<int> intListData(
    Dict data,
    String key,
  ) {
    return List<int>.from(
      data[key] ?? [],
    );
  }

  static bool boolData(
    Dict data,
    String key,
  ) {
    return data[key] as bool? ?? false;
  }

  static int intData(
    Dict data,
    String key,
  ) {
    return data[key] as int? ?? 0;
  }

  static bool checkFilename(
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

  static bool mimetypeVsSuffix(
    String filename,
    String mimeType,
  ) {
    return (Config.mimeToSuffix[mimeType] ?? []).contains(
      Util.suffix(
        filename,
      ),
    );
  }

  static String suffix(
    String filename,
  ) {
    return extension(filename);
  }
}
