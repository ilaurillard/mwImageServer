import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A counted number of non-monetary units, possibly including a fractional part.
class PackQuantity {

  final double value; // (decimal)

  // The unit of the quantity
  final String? unitCode; // (normalizedString)

  // The quantity unit code list.
  final String? unitCodeListID; // (normalizedString)

  // The identification of the agency that maintains the quantity unit code list
  final String? unitCodeListAgencyID; // (normalizedString)

  // The name of the agency which maintains the quantity unit code list.
  final String? unitCodeListAgencyName; // (string)

  PackQuantity ({
    required this.value,
    this.unitCode,
    this.unitCodeListID,
    this.unitCodeListAgencyID,
    this.unitCodeListAgencyName,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
      'unitCode': unitCode,
      'unitCodeListID': unitCodeListID,
      'unitCodeListAgencyID': unitCodeListAgencyID,
      'unitCodeListAgencyName': unitCodeListAgencyName,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PackQuantity? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PackQuantity (
      value: double.tryParse(json['value'].toString()) ?? 0,
      unitCode: json['unitCode'] as String?,
      unitCodeListID: json['unitCodeListID'] as String?,
      unitCodeListAgencyID: json['unitCodeListAgencyID'] as String?,
      unitCodeListAgencyName: json['unitCodeListAgencyName'] as String?,
    );
  }

  static PackQuantity? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return PackQuantity (
      value: null,
      unitCode: null,
      unitCodeListID: null,
      unitCodeListAgencyID: null,
      unitCodeListAgencyName: null,
    );
  }

}

