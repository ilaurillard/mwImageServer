import 'dart:async';
import 'dart:io';

import 'package:mwcdn/Service/FileStore.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Service/DataStore.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';

class ApiBucket {
  final DataStore dataStore;
  final FileStore fileStore;

  ApiBucket({
    required this.dataStore,
    required this.fileStore,
  });

  FutureOr<Response> create(
    Request request,
  ) async {
    // create folder

    Dict data = await Util.jsonObject(request);

    int bucket = Util.intData(data, 'id');
    if (bucket < 1 || bucket > 999999999) {
      return Util.invalidbucket();
    }

    String pathPublic = '/public/' + bucket.toString();
    String pathPrivate = '/private/' + bucket.toString();

    if (await fileStore.dirExists(pathPublic)) {
      return Response(409,  body: 'Bucket collision');
    }
    if (await fileStore.dirExists(pathPrivate)) {
      return Response(409, body: 'Bucket collision');
    }

    await fileStore.createDir(pathPublic);
    await fileStore.createDir(pathPrivate);

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
      return Util.invalidbucket();
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
