import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';

class Stats implements JsonSerializable {
  final int amountBuckets;
  final int amountResources;
  final int amountTokens;

  Stats({
    this.amountBuckets = 0,
    this.amountResources = 0,
    this.amountTokens = 0,
  });

  @override
  Dict toJson() {
    return {
      'buckets': {
        'total': amountBuckets,
      },
      'resources': {
        'total': amountResources,
      },
      'tokens': {
        'total': amountTokens,
      },
    };
  }
}