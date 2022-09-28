import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'Config.dart';
import 'DataStore.dart';
import 'Imagick.dart';
import 'Model/Resource.dart';

class Converter {
  final DataStore dataStore;
  final Imagick imagick;

  Converter({
    required this.dataStore,
    required this.imagick,
  });

  FutureOr<Response> onTheFly(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');

    Resource resource = await dataStore.resource(
      bucket,
      request.params['resource'] ?? '',
    );
    if (resource.empty()) {
      return Response.notFound(
        'Resource not found',
      );
    }

    String file = request.params['file'] ?? '';

    print('On the fly - ' +
        resource.toString() +
        ' ' +
        file +
        ' ' +
        bucket.toString());

    // TODO

    Handler handler = createStaticHandler(
      Config.dataDir,
    );
    return handler(request);
  }
}
