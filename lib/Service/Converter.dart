import 'dart:async';

import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/DataStore.dart';
import 'package:mwcdn/Service/FileStore.dart';
import 'package:mwcdn/Service/Imagick.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

class Converter {
  final DataStore dataStore;
  final FileStore fileStore;
  final Imagick imagick;

  Converter({
    required this.dataStore,
    required this.fileStore,
    required this.imagick,
  });

  FutureOr<Response> onTheFly(
    Request request,
  ) async {
    int bucketId = int.parse(request.params['bucket'] ?? '0');

    Bucket bucket = await dataStore.bucket(
      bucketId,
    );

    Resource resource = await dataStore.resource(
      bucketId,
      request.params['resource'] ?? '',
    );
    if (resource.empty()) {
      return Response.notFound(
        'Resource not found',
      );
    }

    String file = request.params['file'] ?? '';

    String methodName = file.split('-').first;

    print(
      'On the fly - ' +
          resource.toString() +
          ' original: ' +
          resource.filename +
          ' file: ' +
          file +
          ' bucket: ' +
          bucketId.toString() +
          ' method: ' + methodName,
    );

    String path = '/' + resource.path();
    String original = path + '/' + resource.filename;
    String target = path + '/' + file;

    if (!await fileStore.dirExists(path)) {
      return Response.notFound('Folder not exists (' + path + ')');
    }

    if (!await fileStore.fileExists(original)) {
      return Response.notFound('File not exists (' + original + ')');
    }

    // TODO from Bucket
    Method method = Method(methodName);

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
}
