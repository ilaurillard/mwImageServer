import 'dart:async';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Token.dart';
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
    printInfo('[ApiToken.create]');

    int bucket = int.parse(request.params['bucket'] ?? '0');

    Dict data = await Util.jsonObject(request);

    bool root = Util.boolData(data, 'root');
    List<int> buckets = Util.intListData(data, 'buckets');

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
      users: root ? [] : Util.intListData(data, 'users'),
      groups: root ? [] : Util.intListData(data, 'groups'),
      buckets: root ? [] : buckets,
      root: root,
    );

    printNotice(token.toString());

    return Util.rJsonOk(
      token,
    );
  }

  // ---------------------

  FutureOr<Response> show(
    Request request,
  ) async {
    printInfo('[ApiToken.show]');

    int bucket = int.parse(request.params['bucket'] ?? '0');

    Token token = await sqliteStorage.tokens.load(
      request.params['token'] ?? '',
    );
    if (!token.valid()) {
      return Util.rNotFound('Token not found');
    }

    if (bucket > 0 && token.bucket != bucket) {
      return Util.rForbidden(
        'Forbidden',
      );
    }

    return Util.rJsonOk(
      token,
    );
  }
}
