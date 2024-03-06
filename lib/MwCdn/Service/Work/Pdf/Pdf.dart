import 'dart:convert';
import 'dart:typed_data';

import 'package:mwcdn/MwCdn/Etc/Files.dart';
import 'package:mwcdn/MwCdn/Model/Resource.dart';
import 'package:mwcdn/MwCdn/Model/Token.dart';
import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Engine/Engine.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:pdf/widgets.dart';

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
    String resDir = '${fileStorage.resDir}/MwPdf';

    String filename = Files.filenameFromRequest(data);

    // merge request data onto resource template
    Dict pdfJsonDict = Util.mergeMap([
      await templateFromResource(
        templateResource,
      ),
      data['data'] as Dict? ?? {},
    ]);

    // validate incoming data via json-scheme
    Results results = (await Schema.create(
      resDir: resDir, // for schema
    ))
        .validate(
      json.encode(
        pdfJsonDict,
      ),
    );

    if (results.valid) {
      Engine engine = await Engine.create(
        pdfJsonDict,
        resDir: resDir, // for fonts
        storage: Storage(
          fileStorage: fileStorage,
          resources: sqliteStorage.resources,
          bucketId: bucketId,
          token: token,
        ),
      );

      Document pdf = await engine.pdf();
      Uint8List content = await pdf.save();

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
          Util.rError(
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
        Util.rError(message: 'File error: $e');
        // TODO append this error to database record
      }

      return resource;
    } else {
      printErrors(results);
      throw ResponseException(
        Util.rError(message: 'Schema validation failed!'),
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
        Util.rError(
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
}
