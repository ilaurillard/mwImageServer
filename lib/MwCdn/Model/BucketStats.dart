
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwCdn/Model/Bucket.dart';
import 'package:mwcdn/MwMs/Model/JsonSerializable.dart';

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
