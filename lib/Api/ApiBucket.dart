import 'dart:async';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Method.dart';
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
    Bucket bucket = await dataStorage.loadBucket(
      bucketId,
    );

    if (!bucket.valid()) {
      bucket = await dataStorage.createBucket(
        bucketId,
      );
    }

    // create folders
    String pathPublic = '/public/' + bucketId.toString();
    String pathPrivate = '/private/' + bucketId.toString();
    if (!await fileStorage.dirExists(pathPublic)) {
      await fileStorage.createDir(pathPublic);
    }
    if (!await fileStorage.dirExists(pathPrivate)) {
      await fileStorage.createDir(pathPrivate);
    }

    return Util.jsonResponse(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> show(
    Request request,
  ) async {
    print('[ApiBucket.show]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Response.notFound('Bucket not found');
    }

    String pathPublic = '/public/' + bucket.id.toString();
    String pathPrivate = '/private/' + bucket.id.toString();
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

  // ---------------------

  FutureOr<Response> addMethod(
    Request request,
  ) async {
    print('[ApiBucket.addMethod]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Response.notFound('Bucket not found');
    }

    Dict data = await Util.jsonObject(request);

    // TODO check incoming data
    String name = Util.stringData(data, 'name');
    String tool = Util.stringData(data, 'tool');
    List<String> parameters = Util.stringListData(data, 'parameters');

    Method method = Method(
      name,
      tool: tool,
      parameters: parameters,
    );

    bucket.addMethod(method);

    await dataStorage.updateBucket(
      bucket,
    );

    return Util.jsonResponse(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> deleteMethod(
      Request request,
      ) async {
    print('[ApiBucket.deleteMethod]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Response.notFound('Bucket not found');
    }

    String name = (request.params['method'] ?? '');
    Method method = Method(name);
    bucket.removeMethod(method);

    await dataStorage.updateBucket(
      bucket,
    );

    return Util.jsonResponse(
      bucket,
    );
  }

  Future<Bucket> bucketFromRequest(
      Request request,
      ) async
  {
    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (Util.validBucket(bucketId)) {
      return await dataStorage.loadBucket(
        bucketId,
      );
    }
    return Bucket.notFound(bucketId);
  }
}
