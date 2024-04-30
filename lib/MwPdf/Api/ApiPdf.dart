import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Util.dart'
    as zugferd_util;
import 'package:pdf/widgets.dart';
import 'package:shelf/shelf.dart';
import 'package:xml/xml.dart';

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

  FutureOr<Response> schemaf(
    Request request,
  ) async {
    Console.info('[ApiPdf.schemaf]');

    String schema = await (Pdf(
      fileStorage: fileStorage,
    )).schemaf();

    return Response.ok(
      schema,
      headers: Util.jsonHeaders,
    );
  }

  FutureOr<Response> schemax(
    Request request,
  ) async {
    Console.info('[ApiPdf.schemax]');

    String schema = await (Pdf(
      fileStorage: fileStorage,
    )).schemax();

    return Response.ok(
      schema,
      headers: Util.jsonHeaders,
    );
  }

  FutureOr<Response> invoice(
    Request request,
  ) async {
    Console.info('[ApiPdf.invoice]');

    try {
      Dict data = await Util.incomingJson(
        request,
        throwError: true,
      );

      XmlDocument? xml = await (Pdf(
        fileStorage: fileStorage,
      )).invoice(
        data,
      );

      if (xml == null) {
        return Util.rNotFound(
          message: 'No embedded invoice',
        );
      }

      return Response.ok(
        zugferd_util.Util.prettyXml(xml),
        headers: Util.xmlHeaders,
      );
    } on ResponseException catch (e) {
      return e.response;
    } on Exception catch (e) {
      return Util.rError(
        message: e.toString(),
      );
    }
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

  // create and store a template
  FutureOr<Response> template(
    Request request,
  ) async {
    Console.info('[ApiPdf.template]');

    try {
      Dict data = await Util.incomingJson(
        request,
        throwError: true,
      );

      String token = await (Pdf(
        fileStorage: fileStorage,
      )).template(
        data,
      );

      return Response.ok(
        json.encode({
          'token': token,
          'message':
              'Put this token into the import attribute of your json data',
        }),
        headers: Util.jsonHeaders,
      );
    } on ResponseException catch (e) {
      return e.response;
    } on Exception catch (e) {
      return Util.rError(
        message: '(${e.runtimeType}) $e',
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
    } on TooManyPagesException {
      return Util.rError(
        message:
            'TooManyPagesException, a widget is probably too big for one page!',
      );
    } on Exception catch (e) {
      return Util.rError(
        message: '(${e.runtimeType}) $e',
      );
    }
  }
}
