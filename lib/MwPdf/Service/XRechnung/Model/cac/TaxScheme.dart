import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/TaxTypeCode.dart';
import '../cbc/CurrencyCode.dart';
import '../cac/JurisdictionRegionAddress.dart';

// A class to describe a taxation scheme (e.g., VAT, State tax, County tax).
class TaxScheme {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this taxation scheme.
  final ID? iD;

  // The name of this taxation scheme.
  final Name? name;

  // A code signifying the type of tax.
  final TaxTypeCode? taxTypeCode;

  // A code signifying the currency in which the tax is collected and reported.
  final CurrencyCode? currencyCode;

  // A geographic area in which this taxation scheme applies.
  final List<JurisdictionRegionAddress> jurisdictionRegionAddress;

  TaxScheme ({
    this.uBLExtensions,
    this.iD,
    this.name,
    this.taxTypeCode,
    this.currencyCode,
    this.jurisdictionRegionAddress = const [],
  });

  static TaxScheme? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TaxScheme (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      taxTypeCode: TaxTypeCode.fromJson(json['taxTypeCode'] as Map<String, dynamic>?),
      currencyCode: CurrencyCode.fromJson(json['currencyCode'] as Map<String, dynamic>?),
      jurisdictionRegionAddress: (json['jurisdictionRegionAddress'] as List? ?? []).map((dynamic d) => JurisdictionRegionAddress.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'taxTypeCode': taxTypeCode?.toJson(),
      'currencyCode': currencyCode?.toJson(),
      'jurisdictionRegionAddress': jurisdictionRegionAddress.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TaxScheme? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TaxScheme (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      taxTypeCode: TaxTypeCode.fromXml(xml.findElements('cbc:TaxTypeCode').singleOrNull),
      currencyCode: CurrencyCode.fromXml(xml.findElements('cbc:CurrencyCode').singleOrNull),
      jurisdictionRegionAddress: xml.findElements('cac:JurisdictionRegionAddress').map((XmlElement e) => JurisdictionRegionAddress.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'TaxScheme',
        'cac',
      ),
    );
  }
}

