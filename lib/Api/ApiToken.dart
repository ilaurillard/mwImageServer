import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/DataStore.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';

class ApiToken {
  final DataStore dataStore;

  ApiToken({
    required this.dataStore,
  });

  // ---------------------

  FutureOr<Response> create(
    Request request,
  ) async {
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
    }

    Token token = await dataStore.createToken(
      bucket,
      users: Util.intListData(data, 'users'),
      groups: Util.intListData(data, 'groups'),
      buckets: buckets,
      root: root,
    );

    return Util.jsonResponse(
      token,
    );
  }

  // ---------------------

  FutureOr<Response> show(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');

    Token token = await dataStore.token(
      request.params['token'] ?? '',
    );
    if (!token.valid()) {
      return Response.notFound(
        'Token not found',
      );
    }

    if (bucket > 0 && token.bucket != bucket) {
      return Response.forbidden(
        'Forbidden',
      );
    }

    return Util.jsonResponse(
      token,
    );
  }
}
