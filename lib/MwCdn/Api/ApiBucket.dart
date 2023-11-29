import 'dart:async';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwCdn/Model/Bucket.dart';
import 'package:mwcdn/MwCdn/Model/Method.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwCdn/Service/Work/Images/Converter.dart';
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

    Dict data = await Util.incomingJson(request);

    int id = Types.intFromDict(data, 'id');
    if (!Bucket.validId(id)) {
      return Util.rBucketError();
    }
    Bucket bucket = await sqliteStorage.buckets.load(
      id,
    );

    String name = Types.stringData(data, 'name');
    if (!Bucket.validName(name)) {
      return Util.rBadRequest(message: 'Invalid bucket name');
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

    return Util.rJsonOk(
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
      return Util.rNotFound(message: 'Bucket not found');
    }

    String pathPublic = '/pub/${bucket.id}';
    String pathPrivate = '/priv/${bucket.id}';
    if (!await fileStorage.dirExists(pathPublic)) {
      return Util.rNotFound(message: 'Bucket folder missing');
    }
    if (!await fileStorage.dirExists(pathPrivate)) {
      return Util.rNotFound(message: 'Bucket folder missing');
    }

    return Util.rJsonOk(
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
      return Util.rNotFound(message: 'Bucket not found');
    }

    Dict data = await Util.incomingJson(request);

    // TODO check incoming data
    String name = Types.stringData(data, 'name');
    if (!Method.validName(name)) {
      return Util.rBadRequest(message: 'Invalid method name');
    }
    String tool = Types.stringData(data, 'tool');
    if (!Converter.tools.contains(tool)) {
      return Util.rBadRequest(message: 'Unknown tool name');
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

    return Util.rJsonOk(
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
      return Util.rNotFound(message: 'Bucket not found');
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
    if (Bucket.validId(id)) {
      return await sqliteStorage.buckets.load(
        id,
      );
    }
    return Bucket.notFound(id);
  }
}
