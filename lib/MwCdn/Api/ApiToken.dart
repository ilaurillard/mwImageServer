import 'dart:async';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwCdn/Model/Token.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
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

    Dict data = await Util.incomingJson(request);

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

    return Util.rJsonOk(
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
      return Util.rNotFound(message: 'Token not found');
    }

    if (bucket > 0 && token.bucket != bucket) {
      return Util.rForbidden();
    }

    return Util.rJsonOk(
      token,
    );
  }
}
