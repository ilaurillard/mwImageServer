import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Etc/ResponseException.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:path/path.dart';

// ignore: depend_on_referenced_packages
import 'package:string_scanner/string_scanner.dart';

class Files {
  // ----------------

  static String filenameFromRequest(
    Dict data,
  ) {
    String filename = data['filename'] as String? ?? '';
    if (!Files.validFilename(filename)) {
      throw ResponseException(
        Api.rBadRequest(message: 'Invalid filename'),
      );
    }
    return filename;
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

  // --------------

  static bool validFilename(
    String filename,
  ) {
    if (!Config.acceptedSuffixes.contains(
      suffix(
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
      suffix(
        filename,
      ),
    );
  }

  // -----------

  static String suffix(
    String filename,
  ) {
    return extension(filename);
  }
}
