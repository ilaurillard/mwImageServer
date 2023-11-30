import 'dart:async';
import 'dart:typed_data';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:shelf/shelf.dart';

import '../Service/Pdf.dart';

class ApiPdf {
  final FileStorage fileStorage;

  ApiPdf({
    required this.fileStorage,
  });

  // ---------------------

  FutureOr<Response> pdf(
    Request request,
  ) async {
    Console.info('[ApiPdf.pdf]');

    Dict data = await Util.incomingJson(request);

    try {
      Uint8List binary = await (Pdf(
        fileStorage: fileStorage,
      )).build(
        data,
      );
      return Response.ok(
        binary,
        headers: Util.pdfHeaders,
      );
    } on ResponseException catch (e) {
      return e.response;
    } on Exception catch (e) {
      return Util.rError(
        message: e.toString(),
      );
    }
  }
}
