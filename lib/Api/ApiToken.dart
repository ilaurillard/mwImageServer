import 'dart:async';

import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiToken {
  final SqliteStorage sqliteStorage;

  ApiToken({
    required this.sqliteStorage,
  });

  // ---------------------

  FutureOr<Response> create(
    Request request,
  ) async {
    Console.info('[ApiToken.create]');

    int bucket = int.parse(request.params['bucket'] ?? '0');

    Dict data = await Api.incomingJson(request);

    bool root = Types.boolFromDict(data, 'root');
    Ids buckets = Types.idListFromDict(data, 'buckets');

    if (bucket > 0) {
      // only !root tokens in bucket
      root = false;
      if (buckets.isNotEmpty) {
        // no access to other buckets
        buckets = [bucket];
      }
    } else if (buckets.isNotEmpty) {
      bucket = buckets.first;
    }

    Token token = await sqliteStorage.tokens.create(
      root ? 0 : bucket,
      users: root ? [] : Types.idListFromDict(data, 'users'),
      groups: root ? [] : Types.idListFromDict(data, 'groups'),
      buckets: root ? [] : buckets,
      root: root,
    );

    Console.notice(token.toString());

    return Api.rJsonOk(
      token,
    );
  }

  // ---------------------

  FutureOr<Response> show(
    Request request,
  ) async {
    Console.info('[ApiToken.show]');

    int bucket = int.parse(request.params['bucket'] ?? '0');

    Token token = await sqliteStorage.tokens.load(
      request.params['token'] ?? '',
    );
    if (!token.valid()) {
      return Api.rNotFound(message: 'Token not found');
    }

    if (bucket > 0 && token.bucket != bucket) {
      return Api.rForbidden();
    }

    return Api.rJsonOk(
      token,
    );
  }
}
