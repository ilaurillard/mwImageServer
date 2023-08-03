import 'dart:async';

import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/Service/Work/Images/Imagick.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

// ignore: depend_on_referenced_packages
import 'package:shelf_static/shelf_static.dart';

class Converter {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;
  final Imagick imagick;

  static List<String> tools = [
    'convert',
  ];

  Converter({
    required this.sqliteStorage,
    required this.fileStorage,
    required this.imagick,
  });

  // ---------------------

  FutureOr<Response> enPassant(
    Request request,
  ) async {
    Console.info('[Converter.enPassant]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Bucket.validId(bucketId)) {
      return Api.rBucketError();
    }

    Bucket bucket = await sqliteStorage.buckets.load(
      bucketId,
    );

    Resource resource = await sqliteStorage.resources.load(
      bucketId,
      request.params['resource'] ?? '',
    );
    if (!resource.valid()) {
      return Api.rNotFound('Resource not found');
    }

    String file = request.params['file'] ?? '';

    String methodName = file.split('-').first;

    Method method = bucket.method(methodName);
    if (!method.valid()) {
      return Api.rNotFound('Method "$methodName" not exists');
    }

    String path = resource.path();
    String original = '$path/${resource.filename}';
    String target = '$path/$file';

    if (!await fileStorage.dirExists(path)) {
      return Api.rNotFound('Folder not exists ($path)');
    }

    if (!await fileStorage.fileExists(original)) {
      return Api.rNotFound('File not exists ($original)');
    }

    if (method.tool == 'convert') {
      await imagick.convert(
        original,
        target,
        method,
      );
    } else {
      return Api.rNotFound('Tool not found (${method.tool})');
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
