import 'dart:io';
import 'dart:typed_data';
import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Files.dart';
import 'package:mwcdn/Etc/ResponseException.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:merge_map_null_safety/merge_map.dart';
import 'dart:convert';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:path/path.dart' show dirname;

class Pdf {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;

  Pdf({
    required this.sqliteStorage,
    required this.fileStorage,
  });

  Future<Resource> buildResource(
    Dict data,
    Resource templateResource,
  ) async {
    String filename = Files.filenameFromRequest(data);

    Dict template = {};
    try {
      template = await fileStorage.fileData(templateResource);
    } catch (e) {
      throw ResponseException(
        Api.rError('Templatefile parse error'),
      );
    }
    if (template.isEmpty) {
      throw ResponseException(
        Api.rError('Templatefile not found or empty'),
      );
    }

    String baseDir = '${dirname(Platform.script.path)}/../lib/MwPdf';

    // Console.warning('Template: $template');
    // Console.warning('Data: $data');

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



      // TODO





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
        Api.rError('Schema validation failed!'),
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
