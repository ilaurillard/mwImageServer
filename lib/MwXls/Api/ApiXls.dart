import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwXls/Engine/Schema/Schema.dart';
import 'package:shelf/shelf.dart';

import '../Service/Xls.dart';

class ApiXls {
  final FileStorage fileStorage;

  ApiXls({
    required this.fileStorage,
  });

  // download schema file
  FutureOr<Response> schema(
    Request request,
  ) async {
    Console.info('[ApiXls.schema]');

    String schema = await (Xls(
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
    Console.info('[ApiXls.validate]');

    try {
      Dict data = await Util.incomingJson(
        request,
        throwError: true,
      );

      Results results = await (Xls(
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

  FutureOr<Response> template(
    Request request,
  ) async {
    Console.info('[ApiXls.template]');

    try {
      Dict data = await Util.incomingJson(
        request,
        throwError: true,
      );

      String token = await (Xls(
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

  // create a xls
  FutureOr<Response> xls(
    Request request,
  ) async {
    Console.info('[ApiXls.xls]');

    Stopwatch s = Stopwatch()..start();

    try {
      Dict data = await Util.incomingJson(
        request,
        throwError: true,
      );

      List<int> binary = await (Xls(
        fileStorage: fileStorage,
      )).build(
        data,
      );

      Console.notice('took: ${s.elapsed}');

      return Response.ok(
        binary,
        headers: Util.xlsHeaders,
      );
    } on ResponseException catch (e) {
      return e.response;
    } on Exception catch (e) {
      return Util.rError(
        message: '(${e.runtimeType}) $e',
      );
    }
  }
}
