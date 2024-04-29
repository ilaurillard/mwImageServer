import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Model/AnonToken.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwXls/Engine/Engine.dart';
import 'package:mwcdn/MwXls/Engine/Schema/Schema.dart';
import 'package:mwcdn/MwXls/Engine/Storage.dart';

class Xls {
  final FileStorage fileStorage;

  Xls({
    required this.fileStorage,
  });

  Future<Results> validate(
    Dict data,
  ) async {
    data = _expandTemplate(data);

    return await _validate(data);
  }

  Future<List<int>> build(
    Dict data,
  ) async {
    data = _expandTemplate(data);

    // validate incoming data via json-scheme
    Results results = await _validate(data);

    if (results.valid) {
      Engine engine = await _engine(data);

      return await engine.excel.save();
    } else {
      _printErrors(results);
      throw ResponseException(
        Util.rBadRequest(
          message: json.encode({
            'errors': results.errors,
            'warnings': results.warnings,
          }),
        ),
      );
    }
  }

  Future<String> schema() async {
    return (await Schema.create(
      resDir: _resDir(),
    ))
        .schemaData;
  }

  Future<String> template(
    Dict data,
  ) async {
    String content = json.encode(data);
    if (content.length > 32000) {
      throw ResponseException(
        Util.rBadRequest(
          message: 'Maximum size exceeded',
        ),
      );
    }
    String token = md5.convert(content.codeUnits).toString();
    fileStorage.putFile(
      _templatePath(token),
      content,
    );
    return token;
  }

  // ----------------

  String _resDir() {
    return '${fileStorage.resDir}/MwXls';
  }

  Future<Results> _validate(
    Dict data,
  ) async {
    return (await Schema.create(
      resDir: _resDir(),
    ))
        .validate(
      json.encode(
        data,
      ),
    );
  }

  void _printErrors(
    Results results,
  ) {
    Console.notice('Document does not validate!');
    if (results.errors.isNotEmpty) {
      Console.notice('Errors: ');
      for (String e in results.errors) {
        Console.notice('>> $e');
      }
    }
    if (results.warnings.isNotEmpty) {
      Console.notice('Warnings: ');
      for (String w in results.warnings) {
        Console.notice('>> $w');
      }
    }
  }

  Dict _expandTemplate(
    Dict xlsData,
  ) {
    String token = xlsData['import'] as String? ?? '';
    if (token.isNotEmpty && Util.validHash(token)) {
      String data = fileStorage
          .file(
            _templatePath(token),
          )
          .readAsStringSync();
      Dict xlsTplData = json.decode(data) as Dict;
      return Util.mergeMap([xlsTplData, xlsData]);
    }
    return xlsData;
  }

  Future<Engine> _engine(
    Dict data,
  ) {
    return Engine.create(
      data,
      resDir: _resDir(), // for fonts
      storage: Storage(
        fileStorage: fileStorage,
        token: AnonToken(),
      ),
    );
  }

  String _templatePath(
    String token,
  ) {
    return '/files/${token.substring(0, 2)}/${token.substring(2, 4)}/$token.json';
  }
}
