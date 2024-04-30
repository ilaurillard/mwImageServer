import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A numeric value determined by measuring an object using a specified unit of measure.
class ToBeDeliveredMeasure {

  final double value; // (decimal)

  // The type of unit of measure.
  final String unitCode; // (normalizedString)

  // The version of the measure unit code list.
  final String? unitCodeListVersionID; // (normalizedString)

  ToBeDeliveredMeasure ({
    required this.value,
    required this.unitCode,
    this.unitCodeListVersionID,
  }) {
    assert(unitCode.isNotEmpty);
  }

  static ToBeDeliveredMeasure? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ToBeDeliveredMeasure (
      value: double.tryParse(json['value'].toString()) ?? 0,
      unitCode: json['unitCode'] as String? ?? '',
      unitCodeListVersionID: json['unitCodeListVersionID'] as String?,
    );
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

  static ToBeDeliveredMeasure? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ToBeDeliveredMeasure (
      value: double.tryParse(xml.innerText.toString()) ?? 0,
      unitCode: xml.getAttribute('unitCode') ?? '',
      unitCodeListVersionID: xml.getAttribute('unitCodeListVersionID'),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'ToBeDeliveredMeasure',
        'cbc',
      ),
    );
  }
}

