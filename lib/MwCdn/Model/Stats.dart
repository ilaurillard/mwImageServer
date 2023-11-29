import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Model/JsonSerializable.dart';

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
