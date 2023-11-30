import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Model/AnonToken.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Engine/Engine.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:path/path.dart' show dirname;

class Pdf {
  final FileStorage fileStorage;

  Pdf({
    required this.fileStorage,
  });

  Future<Uint8List> build(
    Dict data,
  ) async {
    String baseDir = '${dirname(
      Platform.script.path,
    )}/../lib/MwPdf';

    // validate incoming data via json-scheme
    Results results = (await Schema.create(
      baseDir: baseDir, // for schema
    ))
        .validate(
      json.encode(
        data,
      ),
    );

    if (results.valid) {
      Engine engine = await Engine.create(
        data,
        baseDir: baseDir, // for fonts
        storage: Storage(
          fileStorage: fileStorage,
          token: AnonToken(),
        ),
      );

      return await engine.pdf().save();
    } else {
      printErrors(results);
      throw ResponseException(
        Util.rError(message: 'Schema validation failed!'),
      );
    }
  }

  void printErrors(
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
