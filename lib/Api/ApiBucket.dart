import 'dart:async';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Service/DataStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiBucket {
  final DataStorage dataStorage;
  final FileStorage fileStorage;

  ApiBucket({
    required this.dataStorage,
    required this.fileStorage,
  });

  // ---------------------

  FutureOr<Response> create(
    Request request,
  ) async {
    print('[ApiBucket.create]');

    Dict data = await Util.jsonObject(request);

    int bucketId = Util.intData(data, 'id');
    if (!Util.validBucket(bucketId)) {
      return Util.invalidBucket();
    }

    // Load from Database, check exists?
    // Bucket bucket = await dataStorage.bucket(
    //   bucketId,
    // );

    // create folders
    String pathPublic = '/public/' + bucketId.toString();
    String pathPrivate = '/private/' + bucketId.toString();

    if (await fileStorage.dirExists(pathPublic)) {
      return Response(409, body: 'Bucket collision');
    }
    if (await fileStorage.dirExists(pathPrivate)) {
      return Response(409, body: 'Bucket collision');
    }

    await fileStorage.createDir(pathPublic);
    await fileStorage.createDir(pathPrivate);

    Bucket bucket = await dataStorage.createBucket(bucketId);

    return Util.jsonResponse(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> show(
    Request request,
  ) async {
    print('[ApiBucket.show]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Util.validBucket(bucketId)) {
      return Util.invalidBucket();
    }

    Bucket bucket = await dataStorage.loadBucket(
      bucketId,
    );

    String pathPublic = '/public/' + bucketId.toString();
    String pathPrivate = '/private/' + bucketId.toString();
    if (!await fileStorage.dirExists(pathPublic)) {
      return Response(404, body: 'Bucket folder missing');
    }
    if (!await fileStorage.dirExists(pathPrivate)) {
      return Response(404, body: 'Bucket folder missing');
    }

    return Util.jsonResponse(
      bucket,
    );
  }
}
