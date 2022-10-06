import 'dart:async';

import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/DataStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:mwcdn/Service/Imagick.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

class Converter {
  final DataStorage dataStorage;
  final FileStorage fileStorage;
  final Imagick imagick;

  Converter({
    required this.dataStorage,
    required this.fileStorage,
    required this.imagick,
  });

  // ---------------------

  FutureOr<Response> onTheFly(
    Request request,
  ) async {
    print('[Converter.onTheFly]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    Bucket bucket = await dataStorage.loadBucket(
      bucketId,
    );

    Resource resource = await dataStorage.loadResource(
      bucketId,
      request.params['resource'] ?? '',
    );
    if (!resource.valid()) {
      return Response.notFound(
        'Resource not found',
      );
    }

    String file = request.params['file'] ?? '';

    String methodName = file.split('-').first;

    Method method = bucket.method(methodName);
    if (!method.valid()) {
      return Response.notFound('Method "' + methodName + '" not exists');
    }

    String path = resource.path();
    String original = path + '/' + resource.filename;
    String target = path + '/' + file;

    if (!await fileStorage.dirExists(path)) {
      return Response.notFound('Folder not exists (' + path + ')');
    }

    if (!await fileStorage.fileExists(original)) {
      return Response.notFound('File not exists (' + original + ')');
    }

    await imagick.convert(
      original,
      target,
      method,
    );

    Handler handler = createStaticHandler(
      Config.dataDir,
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
      );
    }

    return Method.notFound(
      methodName,
    );
  }
}
