import 'dart:convert';
import 'dart:io';

import 'package:merge_map_null_safety/merge_map.dart';
import 'package:mwcdn/Etc/Files.dart';
import 'package:mwcdn/Etc/ResponseException.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/MwPdf/Engine/Engine.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:path/path.dart' show dirname;

class Pdf {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;

  final Token token;
  final int bucketId;

  Pdf({
    required this.sqliteStorage,
    required this.fileStorage,
    this.bucketId = -1,
    required this.token,
  });

  Future<Resource> buildResource(
    Dict data,
    Resource templateResource,
  ) async {
    String filename = Files.filenameFromRequest(data);

    Dict template = {};
    try {
      template = await fileStorage.fileDataAsJson(templateResource);
    } catch (e) {
      throw ResponseException(
        Api.rError(message: 'Templatefile parse error'),
      );
    }
    if (template.isEmpty) {
      throw ResponseException(
        Api.rError(message: 'Templatefile not found or empty'),
      );
    }

    String baseDir = '${dirname(Platform.script.path)}/../lib/MwPdf';

    Schema schema = await Schema.create(
      baseDir: baseDir,
    );

    Dict pdfJsonDict = mergeMap([
      template,
      data['data'] as Dict? ?? {},
    ]);
    String pdfJson = json.encode(pdfJsonDict);
    Results results = schema.validate(pdfJson);

    if (results.valid) {
      // TODO start the engine

      Engine engine = await Engine.run(
        pdfJsonDict,
        baseDir: baseDir,
        fileStorage: fileStorage,
        sqliteStorage: sqliteStorage,
        bucketId: bucketId,
        token: token,
      );

      // String name = '$examplesDir/output/$jsonFile.pdf';
      await engine.buildPdf().save();
    } else {
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
      throw ResponseException(
        Api.rError(message: 'Schema validation failed!'),
      );
    }

    Resource pdf = await sqliteStorage.resources.create(
      templateResource.bucket,
      filename: filename,
      mimeType: 'application/pdf',
      size: 12345,
      users: Types.idListFromDict(data, 'users'),
      groups: Types.idListFromDict(data, 'groups'),
    );

    return pdf;
  }

// Future<Uint8List> build(
//   Dict data,
//   Resource resource,
// ) async {
//
//   // Engine engine = await Engine.run(
//   //   json.decode(pdfJson) as Dict,
//   //   baseDir: baseDir,
//   // );
//
//   // return await engine.buildPdf().save();
// }
}
