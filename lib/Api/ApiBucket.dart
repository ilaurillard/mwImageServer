import 'dart:async';

import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Service/Converter.dart';
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

  FutureOr<Response> store(
    Request request,
  ) async {
    printInfo('[ApiBucket.store]');

    Dict data = await Util.jsonObject(request);

    int id = Util.intData(data, 'id');
    if (!Util.validBucket(id)) {
      return Util.rBucketError();
    }
    Bucket bucket = await sqliteStorage.buckets.load(
      id,
    );

    String name = Util.stringData(data, 'name');
    if (!Config.validBucketName.hasMatch(name)) {
      return Util.rBadRequest('Invalid bucket name');
    }

    if (bucket.valid()) {
      // update existing bucket
      bucket.name = name;
      await sqliteStorage.buckets.update(bucket);
    } else {
      // create new bucket
      bucket = await sqliteStorage.buckets.create(
        id,
        name,
      );
    }

    // create folders
    String pathPublic = '/pub/$id';
    String pathPrivate = '/priv/$id';
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

    String pathPublic = '/pub/${bucket.id}';
    String pathPrivate = '/priv/${bucket.id}';
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
    if (!Config.validMethodName.hasMatch(name)) {
      return Util.rBadRequest('Invalid method name');
    }
    String tool = Util.stringData(data, 'tool');
    if (!Converter.tools.contains(tool)) {
      return Util.rBadRequest('Unknown tool name');
    }

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
