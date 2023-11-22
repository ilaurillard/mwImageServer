import 'dart:convert';

import 'package:mwcdn/Api/ApiBucket.dart';
import 'package:mwcdn/Api/ApiResource.dart';
import 'package:mwcdn/Api/ApiStats.dart';
import 'package:mwcdn/Api/ApiToken.dart';
import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:mwcdn/Service/Api/Authorization.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Api {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;
  final String rootKey;

  Api({
    required this.sqliteStorage,
    required this.fileStorage,
    required this.rootKey,
  });

  Handler create() {
    Authorization authorization = Authorization(
      sqliteStorage: sqliteStorage,
      rootKey: rootKey,
    );
    ApiBucket apiBucket = ApiBucket(
      sqliteStorage: sqliteStorage,
      fileStorage: fileStorage,
    );
    ApiResource apiResource = ApiResource(
      sqliteStorage: sqliteStorage,
      fileStorage: fileStorage,
      authorization: authorization,
    );
    ApiToken apiToken = ApiToken(
      sqliteStorage: sqliteStorage,
    );
    ApiStats apiStats = ApiStats(
      sqliteStorage: sqliteStorage,
      fileStorage: fileStorage,
    );

    return Pipeline()
        // --------- auth/security middleware
        .addMiddleware(
          authorization.apiAccess(),
        )
        .addHandler(
          Router()
            // ----------------------------
            // ---------------------------- bucket
            // ----------------------------
            ..post(
              // add new bucket or update (POST)
              '/bucket', // /api/bucket
              apiBucket.store,
            )
            ..get(
              // info on bucket (GET)
              '/bucket${Config.matchBucket}', // /api/bucket/77
              apiBucket.show,
            )
            ..get(
              // more info on bucket (GET)
              '/bucket${Config.matchBucket}/stats', // /api/bucket/77/stats
              apiStats.bucket,
            )
            ..post(
              // create a method
              '/bucket${Config.matchBucket}/method',
              apiBucket.addMethod,
            )
            ..delete(
              // remove a method
              '/bucket${Config.matchBucket}/method${Config.matchMethod}',
              apiBucket.deleteMethod,
            )
            // ----------------------------
            // ---------------------------- resource
            // ----------------------------
            ..post(
              // create a resource
              // /api/bucket/77/resource
              '/bucket${Config.matchBucket}/resource',
              apiResource.create,
            )
            ..all(
              '/bucket${Config.matchBucket}/resource${Config.matchResource}',
              apiResource.crud,
            )
            ..post(
              // /api/bucket/77/resource/[resource]/flush
              '/bucket${Config.matchBucket}/resource${Config.matchResource}/flush',
              apiResource.flush,
            )
            ..post(
              '/bucket${Config.matchBucket}/resource${Config.matchResource}/pdf',
              apiResource.pdf,
            )
            // ----------------------------
            // ---------------------------- token (customer/bucket)
            // ----------------------------
            ..post(
              // /api/bucket/77/token
              '/bucket${Config.matchBucket}/token',
              apiToken.create,
            )
            ..get(
              // show token meta
              // /api/bucket/77/token/[token]
              '/bucket${Config.matchBucket}/token${Config.matchToken}',
              apiToken.show,
            )
            // ----------------------------
            // ---------------------------- root tokens (root only)
            // ----------------------------
            ..post(
              '/token', // /api/token
              apiToken.create,
            )
            ..get(
              // show token meta
              '/token${Config.matchToken}',
              apiToken.show,
            )
            ..get(
              '/stats',
              apiStats.all,
            ),
        );
  }

  // ----------------

  static Future<Dict> incomingJson(
    Request request,
  ) async {
    String tmp = await request.readAsString();

    Dict data;
    try {
      data = json.decode(tmp) as Dict;
    } catch (e) {
      data = {};
      Console.warning('[500] Json decode: $e');
    }

    return data;
  }

  // ----------------

  static Response rJsonOk(
    JsonSerializable subject,
  ) {
    return Response.ok(
      json.encode(subject.toJson()),
      headers: Config.jsonHeaders,
    );
  }

  static Response rBucketError() {
    return rBadRequest(message: 'Invalid bucket');
  }

  static Response rNotFound({
    String message = 'Not found',
  }) {
    Console.warning('[404] $message');
    return Response.notFound(
      message,
      headers: Config.jsonHeaders,
    );
  }

  static Response rError({
    String message = 'Error',
  }) {
    Console.warning('[500] $message');
    return Response.internalServerError(
      body: message,
      headers: Config.jsonHeaders,
    );
  }

  static Response rBadRequest({
    String message = 'Bad request',
  }) {
    Console.warning('[400] $message');
    return Response.badRequest(
      body: message,
      headers: Config.jsonHeaders,
    );
  }

  static Response rUnauthorized({
    String message = 'Unauthorized',
  }) {
    Console.warning('[401] $message');
    return Response.unauthorized(
      message,
      headers: Config.jsonHeaders,
    );
  }

  static Response rForbidden({
    String message = 'Forbidden',
  }) {
    Console.warning('[403] $message');
    return Response.forbidden(
      message,
      headers: Config.jsonHeaders,
    );
  }
}
