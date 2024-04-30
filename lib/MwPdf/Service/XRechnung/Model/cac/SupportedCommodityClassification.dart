import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/NatureCode.dart';
import '../cbc/CargoTypeCode.dart';
import '../cbc/CommodityCode.dart';
import '../cbc/ItemClassificationCode.dart';

// A class to describe the classification of a commodity.
class SupportedCommodityClassification {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A code defined by a specific maintenance agency signifying the high-level nature of the commodity.
  final NatureCode? natureCode;

  // A mutually agreed code signifying the type of cargo for purposes of commodity classification.
  final CargoTypeCode? cargoTypeCode;

  // The harmonized international commodity code for cross border and regulatory (customs and trade statistics) purposes.
  final CommodityCode? commodityCode;

  // A code signifying the trade classification of the commodity.
  final ItemClassificationCode? itemClassificationCode;

  SupportedCommodityClassification ({
    this.uBLExtensions,
    this.natureCode,
    this.cargoTypeCode,
    this.commodityCode,
    this.itemClassificationCode,
  });

  static SupportedCommodityClassification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SupportedCommodityClassification (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      natureCode: NatureCode.fromJson(json['natureCode'] as Map<String, dynamic>?),
      cargoTypeCode: CargoTypeCode.fromJson(json['cargoTypeCode'] as Map<String, dynamic>?),
      commodityCode: CommodityCode.fromJson(json['commodityCode'] as Map<String, dynamic>?),
      itemClassificationCode: ItemClassificationCode.fromJson(json['itemClassificationCode'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'natureCode': natureCode?.toJson(),
      'cargoTypeCode': cargoTypeCode?.toJson(),
      'commodityCode': commodityCode?.toJson(),
      'itemClassificationCode': itemClassificationCode?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static SupportedCommodityClassification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SupportedCommodityClassification (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      natureCode: NatureCode.fromXml(xml.findElements('cbc:NatureCode').singleOrNull),
      cargoTypeCode: CargoTypeCode.fromXml(xml.findElements('cbc:CargoTypeCode').singleOrNull),
      commodityCode: CommodityCode.fromXml(xml.findElements('cbc:CommodityCode').singleOrNull),
      itemClassificationCode: ItemClassificationCode.fromXml(xml.findElements('cbc:ItemClassificationCode').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'SupportedCommodityClassification',
        'cac',
      ),
    );
  }
}

