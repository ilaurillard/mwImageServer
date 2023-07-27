import 'dart:async';

import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:mwcdn/Service/Imagick.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

class Converter {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;
  final Imagick imagick;

  Converter({
    required this.sqliteStorage,
    required this.fileStorage,
    required this.imagick,
  });

  // ---------------------

  FutureOr<Response> enPassant(
    Request request,
  ) async {
    printInfo('[Converter.enPassant]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Util.validBucket(bucketId)) {
      return Util.rBucketError();
    }

    Bucket bucket = await sqliteStorage.buckets.load(
      bucketId,
    );

    Resource resource = await sqliteStorage.resources.load(
      bucketId,
      request.params['resource'] ?? '',
    );
    if (!resource.valid()) {
      return Util.rNotFound('Resource not found');
    }

    String file = request.params['file'] ?? '';

    String methodName = file.split('-').first;

    Method method = bucket.method(methodName);
    if (!method.valid()) {
      return Util.rNotFound('Method "' + methodName + '" not exists');
    }

    String path = resource.path();
    String original = path + '/' + resource.filename;
    String target = path + '/' + file;

    if (!await fileStorage.dirExists(path)) {
      return Util.rNotFound('Folder not exists (' + path + ')');
    }

    if (!await fileStorage.fileExists(original)) {
      return Util.rNotFound('File not exists (' + original + ')');
    }

    if (method.tool == 'convert') {
      await imagick.convert(
        original,
        target,
        method,
      );
    }
    else {
      return Util.rNotFound('Tool not found (' + method.tool + ')');
    }

    // now try again to serve file after converting took place
    Handler handler = createStaticHandler(
      fileStorage.dataDir,
    );
    return handler(request);
  }

  // ---------------------

  static Method builtInMethods(
    String methodName,
  ) {

    if (methodName == 'thumb1') {
      return Method(
        methodName,
        tool: 'convert',
        parameters: [
          '%source%',
          '-thumbnail',
          '100x100',
          '%target%',
        ],
      );
    }

    return Method.notFound(
      methodName,
    );
  }
}
