import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:pdf/widgets.dart';
import 'package:shelf/shelf.dart';

import '../Service/Pdf.dart';

class ApiPdf {
  final FileStorage fileStorage;

  ApiPdf({
    required this.fileStorage,
  });

  // download schema file
  FutureOr<Response> schema(
      Request request,
      ) async {
    Console.info('[ApiPdf.schema]');

    String schema = await (Pdf(
      fileStorage: fileStorage,
    )).schema();

    return Response.ok(
      schema,
      headers: Util.jsonHeaders,
    );
  }

  // validate against schema
  FutureOr<Response> validate(
      Request request,
      ) async {
    Console.info('[ApiPdf.validate]');

    try {
      Dict data = await Util.incomingJson(
        request,
        throwError: true,
      );

      Results results = await (Pdf(
        fileStorage: fileStorage,
      )).validate(
        data,
      );

      return Response.ok(
        json.encode({
          'errors': results.errors,
          'warnings': results.warnings,
        }),
        headers: Util.jsonHeaders,
      );

    } on ResponseException catch (e) {
      return e.response;
    } on Exception catch (e) {
      return Util.rError(
        message: e.toString(),
      );
    }
  }

  // create a pdf
  FutureOr<Response> pdf(
    Request request,
  ) async {
    Console.info('[ApiPdf.pdf]');

    Stopwatch s = Stopwatch()..start();

    try {
      Dict data = await Util.incomingJson(
        request,
        throwError: true,
      );

      Uint8List binary = await (Pdf(
        fileStorage: fileStorage,
      )).build(
        data,
      );

      Console.notice('took: ${s.elapsed}');

      return Response.ok(
        binary,
        headers: Util.pdfHeaders,
      );
    } on ResponseException catch (e) {
      return e.response;
    } on TooManyPagesException catch (e) {
      return Util.rError(
        message: 'TooManyPagesException, a widget is probably too big for one page!',
      );

    } on Exception catch (e) {
      return Util.rError(
        message: '(${e.runtimeType}) $e',
      );
    }
  }
}
