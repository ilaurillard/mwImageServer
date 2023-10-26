import 'dart:typed_data';

import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Files.dart';
import 'package:mwcdn/Etc/ResponseException.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';

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

    Dict template = await fileStorage.fileData(templateResource);
    if (template.isEmpty) {
      throw ResponseException(
        Api.rError('Templatefile not found or empty'),
      );
    }

    Console.warning('Data: $data');
    Console.warning('Template: $template');





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
  //   //   basedir: basedir,
  //   // );
  //
  //   // return await engine.buildPdf().save();
  // }
}
