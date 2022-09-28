import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Config.dart';
import '../DataStore.dart';
import '../Model/Bucket.dart';
import '../Types.dart';
import '../Util.dart';

class ApiBucket {
  final DataStore dataStore;

  ApiBucket({
    required this.dataStore,
  });

  FutureOr<Response> create(
    Request request,
  ) async {
    // create folder

    Dict data = await Util.jsonObject(request);

    int bucket = Util.intData(data, 'id');
    if (bucket < 1 || bucket > 999999999) {
      return Response.badRequest(body: 'Invalid bucket');
    }

    // TODO create folders
    // cfg.dataDir

    // await Future.delayed(Duration(milliseconds: 100));

    return Util.jsonResponse(
      Bucket(
        bucket,
      ),
    );
  }

  FutureOr<Response> show(
    Request request,
  ) {
    int bucket = int.parse(request.params['bucket'] ?? '0');
    if (bucket < 1 || bucket > 999999999) {
      return Response.badRequest(body: 'Invalid bucket');
    }

    // TODO check existance of folders

    String p = Config.dataDir + '/public/' + bucket.toString();
    print(p);

    return Util.jsonResponse(
      Bucket(
        bucket,
      ),
    );

    // return Response.ok(
    //   // "API - (isolate ${Isolate.current.hashCode}) " + request.method,
    //   json.encode({'id': bucket}),
    //   headers: cfg.jsonHeaders,
    // );
  }
}
