import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:merge_map_null_safety/merge_map.dart';
import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Files.dart';
import 'package:mwcdn/Etc/ResponseException.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/MwPdf/Engine/Engine.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
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
    String baseDir = '${dirname(
      Platform.script.path,
    )}/../lib/MwPdf';

    String filename = Files.filenameFromRequest(data);

    // merge request data onto resource template
    Dict pdfJsonDict = mergeMap([
      await templateFromResource(
        templateResource,
      ),
      data['data'] as Dict? ?? {},
    ]);

    // validate incoming data via json-scheme
    Results results = (await Schema.create(
      baseDir: baseDir, // for schema
    ))
        .validate(
      json.encode(
        pdfJsonDict,
      ),
    );

    if (results.valid) {
      Engine engine = await Engine.create(
        pdfJsonDict,
        baseDir: baseDir, // for fonts
        storage: Storage(
          fileStorage: fileStorage,
          sqliteStorage: sqliteStorage,
          bucketId: bucketId,
          token: token,
        ),
      );

      Uint8List content = await engine.pdf().save();

      Resource resource = await sqliteStorage.resources.create(
        templateResource.bucket,
        filename: filename,
        mimeType: 'application/pdf',
        size: content.length,
        users: Types.idListFromDict(data, 'users'),
        groups: Types.idListFromDict(data, 'groups'),
      );
      Console.notice(resource.toString());

      if (await fileStorage.dirExists(resource.path())) {
        throw ResponseException(
          Api.rError(
            message: 'Fatal, resource collision',
          ),
        );
      }

      // ------------------- Store file (async!)
      try {
        fileStorage.storeResource(
          resource,
          content,
        );
      } catch (e) {
        Api.rError(message: 'File error: $e');
        // TODO append this error to database record
      }

      return resource;

    } else {
      printErrors(results);
      throw ResponseException(
        Api.rError(message: 'Schema validation failed!'),
      );
    }
  }

  Future<Dict> templateFromResource(
    Resource templateResource,
  ) async {
    Dict template = {};
    try {
      template = await fileStorage.fileDataAsJson(
        templateResource,
      );
    } catch (e) {
      throw ResponseException(
        Api.rError(
          message: 'Templatefile parse error',
        ),
      );
    }
    // if (template.isEmpty) {
    //   throw ResponseException(
    //     Api.rError(message: 'Templatefile not found or empty'),
    //   );
    // }
    return template;
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
