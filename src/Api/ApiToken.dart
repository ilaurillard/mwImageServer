import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Config.dart';
import '../DataStore.dart';
import '../Model/Resource.dart';
import '../Model/Token.dart';
import '../Types.dart';
import '../Util.dart';

class ApiToken {
  final DataStore dataStore;

  ApiToken({
    required this.dataStore,
  });

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

  FutureOr<Response> show(
      Request request,
      ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');

    Token token = await dataStore.token(
      request.params['token'] ?? '',
    );
    if (token.empty()) {
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
