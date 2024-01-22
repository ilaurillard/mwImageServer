import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Model/AnonToken.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Engine/Engine.dart';
import 'package:mwcdn/MwPdf/Engine/Invoice.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:path/path.dart' show dirname;
import 'package:xml/xml.dart';

class Pdf {
  final FileStorage fileStorage;

  Pdf({
    required this.fileStorage,
  });

  Future<String> schema() async {
    return (await Schema.create(
      resDir: _resDir(),
    ))
        .schemaData;
  }

  Future<String> schemaf() async {
    return (await Schema.create(
      resDir: _resDir(),
    ))
        .schemaDataZugferd;
  }

  String _resDir() {
    return '${fileStorage.resDir}/MwPdf';
  }

  Future<Results> validate(
    Dict data,
  ) async {
    return await _validate(data);
  }


  Future<XmlDocument?> facturx(Dict data) async {
    Engine engine = await Engine.create(
      data,
      resDir: _resDir(), // for fonts
      storage: Storage(
        fileStorage: fileStorage,
        token: AnonToken(),
      ),
    );
    return engine.invoice.facturx;
  }

  Future<Uint8List> build(
    Dict data,
  ) async {
    // validate incoming data via json-scheme
    Results results = await _validate(data);

    if (results.valid) {
      Engine engine = await Engine.create(
        data,
        resDir: _resDir(), // for fonts
        storage: Storage(
          fileStorage: fileStorage,
          token: AnonToken(),
        ),
      );

      return await engine.pdf().save();
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
    print('Document does not validate!');
    if (results.errors.isNotEmpty) {
      print('Errors: ');
      for (String e in results.errors) {
        print('>> $e');
      }
    }
    if (results.warnings.isNotEmpty) {
      print('Warnings: ');
      for (String w in results.warnings) {
        print('>> $w');
      }
    }
  }

}
