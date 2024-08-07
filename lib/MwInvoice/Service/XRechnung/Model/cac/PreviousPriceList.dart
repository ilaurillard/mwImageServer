// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/StatusCode.dart';
import '../cac/ValidityPeriod.dart';

// A class to describe a price list.
class PreviousPriceList {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this price list.
  final ID? iD;

  // A code signifying whether this price list is an original, copy, revision, or cancellation.
  final StatusCode? statusCode;

  // A period during which this price list is valid.
  final List<ValidityPeriod> validityPeriod;

  // The previous price list.
  final PreviousPriceList? previousPriceList;

  PreviousPriceList ({
    this.uBLExtensions,
    this.iD,
    this.statusCode,
    this.validityPeriod = const [],
    this.previousPriceList,
  });

  static PreviousPriceList? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PreviousPriceList (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      statusCode: StatusCode.fromJson(json['statusCode'] as Map<String, dynamic>?),
      validityPeriod: (json['validityPeriod'] as List? ?? []).map((dynamic d) => ValidityPeriod.fromJson(d as Map<String, dynamic>?)!).toList(),
      previousPriceList: PreviousPriceList.fromJson(json['previousPriceList'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'statusCode': statusCode?.toJson(),
      'validityPeriod': validityPeriod.map((e) => e.toJson()).toList(),
      'previousPriceList': previousPriceList?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PreviousPriceList? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PreviousPriceList (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      statusCode: StatusCode.fromXml(xml.findElements('cbc:StatusCode').singleOrNull),
      validityPeriod: xml.findElements('cac:ValidityPeriod').map((XmlElement e) => ValidityPeriod.fromXml(e)!).toList(),
      previousPriceList: PreviousPriceList.fromXml(xml.findElements('cac:PreviousPriceList').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      statusCode?.toXml(),
      ...validityPeriod.map((ValidityPeriod e) => e.toXml()),
      previousPriceList?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PreviousPriceList',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

