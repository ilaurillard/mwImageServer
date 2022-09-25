import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'Config.dart';
import 'DataStore.dart';
import 'Imagick.dart';
import 'Model/Resource.dart';

class Converter {
  final Config cfg;
  final DataStore dataStore;
  final Imagick imagick;

  Converter({
    required this.cfg,
    required this.dataStore,
    required this.imagick,
  });

  FutureOr<Response> onTheFly(
    Request request,
  ) {
    Resource? resource = dataStore.resource(
        request.params['resource'] ?? ''
    );
    if (resource == null) {
      return Response.notFound('resource not found');
    }

    int bucket = int.parse(request.params['bucket'] ?? '0');
    String file = request.params['file'] ?? '';

    print('On the fly - ' + resource.toString() + ' ' + file + ' ' + bucket.toString());

    // TODO

    Handler handler = createStaticHandler(
      cfg.dataDir,
    );
    return handler(request);
  }


}
