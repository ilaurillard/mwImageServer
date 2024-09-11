import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Model/AnonToken.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Engine/Engine.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:pdf/widgets.dart';
import 'package:xml/xml.dart';

class Pdf {
  final FileStorage fileStorage;

  Pdf({
    required this.fileStorage,
  });

  Future<Uint8List> build(
    Dict data,
  ) async {
    data = _expandTemplate(data);

    // validate incoming data via json-scheme
    Results results = await _validate(data);

    if (results.valid) {
      Engine engine = await _engine(data);

      Document pdf = await engine.pdf();
      return await pdf.save();
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

  Future<Results> validate(
      Dict data,
      ) async {
    return await _validate(
      _expandTemplate(
        data,
      ),
    );
  }

  // extract invoice -> create invoice xml
  Future<XmlDocument?> invoice(
      Dict data,
      ) async {

    data = _expandTemplate(data);

    // validate incoming data via json-scheme
    Results results = await _validate(data);

    if (results.valid) {
      Engine engine = await _engine(data);

      // may be an CII or UBL xml document
      return engine.state.invoice.xml();
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

  // return main (json) schema definition
  Future<String> schema() async {
    return (await Schema.create(
      resDir: _resDir(),
    ))
        .schemaData;
  }

  /// factur x / cii
  Future<String> schemaf() async {
    return (await Schema.create(
      resDir: _resDir(),
    ))
        .schemaDataCii;
  }

  /// xrechnung / ubl
  Future<String> schemax() async {
    return (await Schema.create(
      resDir: _resDir(),
    ))
        .schemaDataUbl;
  }

  /// store pdf template data on server
  /// return a hashkey for later reference
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
    return '${fileStorage.resDir}/MwPdf';
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
    Dict pdfData,
  ) {
    String token = pdfData['import'] as String? ?? '';
    if (token.isNotEmpty && Util.validHash(token)) {
      String data = fileStorage
          .file(
            _templatePath(token),
          )
          .readAsStringSync();
      Dict pdfTplData = json.decode(data) as Dict;
      return Util.mergeMap([pdfTplData, pdfData]);
    }
    return pdfData;
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
