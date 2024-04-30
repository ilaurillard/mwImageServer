import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A numeric expression of a rate that is assigned or is determined by calculation, counting, or sequencing. It does not require a unit of quantity or unit of measure.
class OrderableUnitFactorRate {

  final double value; // (decimal)

  // Whether the number is an integer, decimal, real number or percentage.
  final String? format; // (string)

  OrderableUnitFactorRate ({
    required this.value,
    this.format,
  });

  static OrderableUnitFactorRate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OrderableUnitFactorRate (
      value: double.tryParse(json['value'].toString()) ?? 0,
      format: json['format'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
      'format': format,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OrderableUnitFactorRate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OrderableUnitFactorRate (
      value: double.tryParse(xml.innerText.toString()) ?? 0,
      format: xml.getAttribute('format'),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'OrderableUnitFactorRate',
        'cbc',
      ),
    );
  }
}

