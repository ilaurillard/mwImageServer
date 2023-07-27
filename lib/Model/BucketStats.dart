import 'dart:convert';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/Converter.dart';

class BucketStats implements JsonSerializable {
  final Bucket bucket;
  final int amountResources;
  // final Resource? lastResource;
  final int amountTokens;
  // final Token? lastToken;

  BucketStats(
    this.bucket,
      {
        this.amountResources = 0,
        // this.lastResource,
        this.amountTokens = 0,
        // this.lastToken,
      }
  );

  Dict toJson() {
    return {
      'bucket': bucket.toJson(),
      'resources': {
        'total': amountResources,
        // 'last': lastResource?.toJson(),
      },
      'tokens': {
        'total': amountTokens,
        // 'last': lastToken?.toJson(),
      },
    };
  }
}
