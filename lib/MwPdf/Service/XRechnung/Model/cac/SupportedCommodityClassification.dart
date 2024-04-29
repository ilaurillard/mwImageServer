import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/NatureCode.dart';
import '../cbc/CargoTypeCode.dart';
import '../cbc/CommodityCode.dart';
import '../cbc/ItemClassificationCode.dart';

// A class to describe the classification of a commodity.
class SupportedCommodityClassification {


  // A code defined by a specific maintenance agency signifying the high-level nature of the commodity.
  final NatureCode? natureCode;

  // A mutually agreed code signifying the type of cargo for purposes of commodity classification.
  final CargoTypeCode? cargoTypeCode;

  // The harmonized international commodity code for cross border and regulatory (customs and trade statistics) purposes.
  final CommodityCode? commodityCode;

  // A code signifying the trade classification of the commodity.
  final ItemClassificationCode? itemClassificationCode;

  SupportedCommodityClassification ({
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

  static SupportedCommodityClassification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SupportedCommodityClassification (
      natureCode: NatureCode.fromJson(json['natureCode'] as Map<String, dynamic>?),
      cargoTypeCode: CargoTypeCode.fromJson(json['cargoTypeCode'] as Map<String, dynamic>?),
      commodityCode: CommodityCode.fromJson(json['commodityCode'] as Map<String, dynamic>?),
      itemClassificationCode: ItemClassificationCode.fromJson(json['itemClassificationCode'] as Map<String, dynamic>?),
    );
  }

  static SupportedCommodityClassification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return SupportedCommodityClassification (
      natureCode: null,
      cargoTypeCode: null,
      commodityCode: null,
      itemClassificationCode: null,
    );
  }

}

