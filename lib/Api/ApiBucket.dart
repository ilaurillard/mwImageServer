import 'dart:async';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/BucketStats.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiBucket {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;

  ApiBucket({
    required this.sqliteStorage,
    required this.fileStorage,
  });

  // ---------------------

  FutureOr<Response> create(
    Request request,
  ) async {
    printInfo('[ApiBucket.create]');

    Dict data = await Util.jsonObject(request);

    int id = Util.intData(data, 'id');
    if (!Util.validBucket(id)) {
      return Util.rBucketError();
    }
    Bucket bucket = await sqliteStorage.buckets.load(
      id,
    );

    if (!bucket.valid()) {
      // TODO validate
      String name = Util.stringData(data, 'name');

      bucket = await sqliteStorage.buckets.create(
        id,
        name,
      );
    }

    // create folders
    String pathPublic = '/public/' + id.toString();
    String pathPrivate = '/private/' + id.toString();
    if (!await fileStorage.dirExists(pathPublic)) {
      await fileStorage.createDir(pathPublic);
    }
    if (!await fileStorage.dirExists(pathPrivate)) {
      await fileStorage.createDir(pathPrivate);
    }

    printNotice(bucket.toString());

    return Util.rJsonOk(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> show(
    Request request,
  ) async {
    printInfo('[ApiBucket.show]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Util.rNotFound('Bucket not found');
    }

    String pathPublic = '/public/' + bucket.id.toString();
    String pathPrivate = '/private/' + bucket.id.toString();
    if (!await fileStorage.dirExists(pathPublic)) {
      return Util.rNotFound('Bucket folder missing');
    }
    if (!await fileStorage.dirExists(pathPrivate)) {
      return Util.rNotFound('Bucket folder missing');
    }

    return Util.rJsonOk(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> stats(
    Request request,
  ) async {
    printInfo('[ApiBucket.stats]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Util.rNotFound('Bucket not found');
    }

    BucketStats stats = BucketStats(
      bucket,
      amountResources: await sqliteStorage.resources.count(bucket),
      amountTokens: await sqliteStorage.tokens.count(bucket),
    );

    return Util.rJsonOk(
      stats,
    );
  }

  // ---------------------

  FutureOr<Response> addMethod(
    Request request,
  ) async {
    printInfo('[ApiBucket.addMethod]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Util.rNotFound('Bucket not found');
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

    await sqliteStorage.buckets.update(
      bucket,
    );

    return Util.rJsonOk(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> deleteMethod(
    Request request,
  ) async {
    printInfo('[ApiBucket.deleteMethod]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Util.rNotFound('Bucket not found');
    }

    String name = (request.params['method'] ?? '');
    Method method = Method(name);
    bucket.removeMethod(method);

    await sqliteStorage.buckets.update(
      bucket,
    );

    return Util.rJsonOk(
      bucket,
    );
  }

  Future<Bucket> bucketFromRequest(
    Request request,
  ) async {
    int id = int.parse(request.params['bucket'] ?? '0');
    if (Util.validBucket(id)) {
      return await sqliteStorage.buckets.load(
        id,
      );
    }
    return Bucket.notFound(id);
  }
}
