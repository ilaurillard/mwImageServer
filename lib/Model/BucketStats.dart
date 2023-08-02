
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';

class BucketStats implements JsonSerializable {
  final Bucket bucket;
  final int amountResources;
  final int amountTokens;

  BucketStats(
    this.bucket,
      {
        this.amountResources = 0,
        this.amountTokens = 0,
      }
  );

  @override
  Dict toJson() {
    return {
      'bucket': bucket.toJson(),
      'resources': {
        'total': amountResources,
      },
      'tokens': {
        'total': amountTokens,
      },
    };
  }
}
