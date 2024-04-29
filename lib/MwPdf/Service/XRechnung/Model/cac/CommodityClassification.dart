import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/NatureCode.dart';
import '../cbc/CargoTypeCode.dart';
import '../cbc/CommodityCode.dart';
import '../cbc/ItemClassificationCode.dart';

// A class to describe the classification of a commodity.
class CommodityClassification {


  // A code defined by a specific maintenance agency signifying the high-level nature of the commodity.
  final NatureCode? natureCode;

  // A mutually agreed code signifying the type of cargo for purposes of commodity classification.
  final CargoTypeCode? cargoTypeCode;

  // The harmonized international commodity code for cross border and regulatory (customs and trade statistics) purposes.
  final CommodityCode? commodityCode;

  // A code signifying the trade classification of the commodity.
  final ItemClassificationCode? itemClassificationCode;

  CommodityClassification ({
    this.natureCode,
    this.cargoTypeCode,
    this.commodityCode,
    this.itemClassificationCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'natureCode': natureCode?.toJson(),
     'cargoTypeCode': cargoTypeCode?.toJson(),
     'commodityCode': commodityCode?.toJson(),
     'itemClassificationCode': itemClassificationCode?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  CommodityClassification fromJson(Map<String, dynamic> json) {
    return CommodityClassification (
    );
  }

}

