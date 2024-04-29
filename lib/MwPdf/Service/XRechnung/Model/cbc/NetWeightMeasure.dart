import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A numeric value determined by measuring an object using a specified unit of measure.
class NetWeightMeasure {

  final double value; // (decimal)

  // The type of unit of measure.
  final String unitCode; // (normalizedString)

  // The version of the measure unit code list.
  final String? unitCodeListVersionID; // (normalizedString)

  NetWeightMeasure ({
    required this.value,
    required this.unitCode,
    this.unitCodeListVersionID,
  }) {
    assert(unitCode.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
      'unitCode': unitCode,
      'unitCodeListVersionID': unitCodeListVersionID,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static NetWeightMeasure? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return NetWeightMeasure (
      value: double.tryParse(json['value'].toString()) ?? 0,
      unitCode: json['unitCode'] as String? ?? '',
      unitCodeListVersionID: json['unitCodeListVersionID'] as String?,
    );
  }

  static NetWeightMeasure? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return NetWeightMeasure (
      value: null,
      unitCode: null,
      unitCodeListVersionID: null,
    );
  }

}

