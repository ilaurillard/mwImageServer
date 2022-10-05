import 'dart:async';
import 'dart:io';

import 'package:mwcdn/Service/FileStore.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

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

  // ---------------------

  FutureOr<Response> create(
    Request request,
  ) async {
    Dict data = await Util.jsonObject(request);

    int bucketId = Util.intData(data, 'id');
    if (bucketId < 1 || bucketId > 999999999) {
      return Util.invalidbucket();
    }

    // Load from Database
    // Bucket bucket = await dataStore.bucket(
    //   bucketId,
    // );

    // create folders
    String pathPublic = '/public/' + bucketId.toString();
    String pathPrivate = '/private/' + bucketId.toString();

    if (await fileStore.dirExists(pathPublic)) {
      return Response(409,  body: 'Bucket collision');
    }
    if (await fileStore.dirExists(pathPrivate)) {
      return Response(409, body: 'Bucket collision');
    }

    await fileStore.createDir(pathPublic);
    await fileStore.createDir(pathPrivate);

    Bucket bucket = await dataStore.createBucket(bucketId);

    return Util.jsonResponse(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> show(
    Request request,
  ) async {
    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (bucketId < 1 || bucketId > 999999999) {
      return Util.invalidbucket();
    }

    // Load from Database
    Bucket bucket = await dataStore.bucket(
      bucketId,
    );

    String pathPublic = '/public/' + bucketId.toString();
    String pathPrivate = '/private/' + bucketId.toString();
    if (!await fileStore.dirExists(pathPublic)) {
      return Response(404,  body: 'Bucket folder missing');
    }
    if (!await fileStore.dirExists(pathPrivate)) {
      return Response(404, body: 'Bucket folder missing');
    }

    return Util.jsonResponse(
      bucket,
    );
  }
}
