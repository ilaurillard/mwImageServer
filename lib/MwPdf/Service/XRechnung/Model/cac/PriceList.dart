import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/StatusCode.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/PreviousPriceList.dart';

// A class to describe a price list.
class PriceList {


  // An identifier for this price list.
  final ID? iD;

  // A code signifying whether this price list is an original, copy, revision, or cancellation.
  final StatusCode? statusCode;

  // A period during which this price list is valid.
  final List<ValidityPeriod> validityPeriod;

  // The previous price list.
  final PreviousPriceList? previousPriceList;

  PriceList ({
    this.iD,
    this.statusCode,
    this.validityPeriod = const [],
    this.previousPriceList,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'statusCode': statusCode?.toJson(),
     'validityPeriod': validityPeriod.map((e) => e.toJson()).toList(),
     'previousPriceList': previousPriceList?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

