import 'dart:async';

import 'package:mwcdn/Api/ApiBucket.dart';
import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/BucketStats.dart';
import 'package:mwcdn/Model/Stats.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:shelf/shelf.dart';

class ApiStats extends ApiBucket {
  ApiStats({
    required SqliteStorage sqliteStorage,
    required FileStorage fileStorage,
  }) : super(
          sqliteStorage: sqliteStorage,
          fileStorage: fileStorage,
        );

  // ---------------------

  FutureOr<Response> bucket(
    Request request,
  ) async {
    Console.info('[ApiStats.bucket]');

    Bucket bucket = await bucketFromRequest(request);
    if (!bucket.valid()) {
      return Api.rNotFound('Bucket not found');
    }

    BucketStats stats = BucketStats(
      bucket,
      amountResources: await sqliteStorage.resources.count(bucket),
      amountTokens: await sqliteStorage.tokens.count(bucket),
    );

    return Api.rJsonOk(
      stats,
    );
  }

  FutureOr<Response> all(
    Request request,
  ) async {
    Console.info('[ApiStats.all]');

    Stats stats = Stats(
      amountBuckets: await sqliteStorage.buckets.count(),
      amountResources: await sqliteStorage.resources.count(),
      amountTokens: await sqliteStorage.tokens.count(),
    );

    return Api.rJsonOk(
      stats,
    );
  }
}
