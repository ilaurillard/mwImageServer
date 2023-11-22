import 'dart:async';

import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/Service/Work/Images/Converter.dart';
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
    Console.info('[ApiBucket.store]');

    Dict data = await Api.incomingJson(request);

    int id = Types.intFromDict(data, 'id');
    if (!Bucket.validId(id)) {
      return Api.rBucketError();
    }
    Bucket bucket = await sqliteStorage.buckets.load(
      id,
    );

    String name = Types.stringData(data, 'name');
    if (!Bucket.validName(name)) {
      return Api.rBadRequest(message: 'Invalid bucket name');
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

    Console.notice(bucket.toString());

    return Api.rJsonOk(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> show(
    Request request,
  ) async {
    Console.info('[ApiBucket.show]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Api.rNotFound(message: 'Bucket not found');
    }

    String pathPublic = '/pub/${bucket.id}';
    String pathPrivate = '/priv/${bucket.id}';
    if (!await fileStorage.dirExists(pathPublic)) {
      return Api.rNotFound(message: 'Bucket folder missing');
    }
    if (!await fileStorage.dirExists(pathPrivate)) {
      return Api.rNotFound(message: 'Bucket folder missing');
    }

    return Api.rJsonOk(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> addMethod(
    Request request,
  ) async {
    Console.info('[ApiBucket.addMethod]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Api.rNotFound(message: 'Bucket not found');
    }

    Dict data = await Api.incomingJson(request);

    // TODO check incoming data
    String name = Types.stringData(data, 'name');
    if (!Method.validName(name)) {
      return Api.rBadRequest(message: 'Invalid method name');
    }
    String tool = Types.stringData(data, 'tool');
    if (!Converter.tools.contains(tool)) {
      return Api.rBadRequest(message: 'Unknown tool name');
    }

    List<String> parameters = Types.stringListFromDict(data, 'parameters');

    Method method = Method(
      name,
      tool: tool,
      parameters: parameters,
    );

    bucket.addMethod(method);

    await sqliteStorage.buckets.update(
      bucket,
    );

    return Api.rJsonOk(
      bucket,
    );
  }

  // ---------------------

  FutureOr<Response> deleteMethod(
    Request request,
  ) async {
    Console.info('[ApiBucket.deleteMethod]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Api.rNotFound(message: 'Bucket not found');
    }

    String name = (request.params['method'] ?? '');
    Method method = Method(name);
    bucket.removeMethod(method);

    await sqliteStorage.buckets.update(
      bucket,
    );

    return Api.rJsonOk(
      bucket,
    );
  }

  Future<Bucket> bucketFromRequest(
    Request request,
  ) async {
    int id = int.parse(request.params['bucket'] ?? '0');
    if (Bucket.validId(id)) {
      return await sqliteStorage.buckets.load(
        id,
      );
    }
    return Bucket.notFound(id);
  }
}
