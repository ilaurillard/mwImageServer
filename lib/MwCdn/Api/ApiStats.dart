import 'dart:async';

import 'package:mwcdn/MwCdn/Api/ApiBucket.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwCdn/Model/Bucket.dart';
import 'package:mwcdn/MwCdn/Model/BucketStats.dart';
import 'package:mwcdn/MwCdn/Model/Stats.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
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
      return Util.rNotFound(message: 'Bucket not found');
    }

    BucketStats stats = BucketStats(
      bucket,
      amountResources: await sqliteStorage.resources.count(bucket),
      amountTokens: await sqliteStorage.tokens.count(bucket),
    );

    return Util.rJsonOk(
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

    return Util.rJsonOk(
      stats,
    );
  }
}
