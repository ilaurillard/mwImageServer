// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A numeric value determined by measuring an object using a specified unit of measure.
class BaseUnitMeasure {

  final double value; // (decimal)

  // The type of unit of measure.
  final String unitCode; // (normalizedString)

  // The version of the measure unit code list.
  final String? unitCodeListVersionID; // (normalizedString)

  BaseUnitMeasure ({
    required this.value,
    required this.unitCode,
    this.unitCodeListVersionID,
  }) {
    if (unitCode.isEmpty) { throw Exception('empty unitCode given'); }
  }

  static BaseUnitMeasure? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return BaseUnitMeasure (
      value: double.tryParse(json['value'].toString()) ?? 0,
      unitCode: json['unitCode'] as String? ?? '',
      unitCodeListVersionID: json['unitCodeListVersionID'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
      'unitCode': unitCode.toString(),
      'unitCodeListVersionID': unitCodeListVersionID?.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static BaseUnitMeasure? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return BaseUnitMeasure (
      value: double.tryParse(xml.innerText.toString()) ?? 0,
      unitCode: xml.getAttribute('unitCode') ?? '',
      unitCodeListVersionID: xml.getAttribute('unitCodeListVersionID'),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      XmlText(value.toString()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [

      XmlAttribute(XmlName('unitCode'), unitCode.toString(),),
      unitCodeListVersionID != null ? XmlAttribute(XmlName('unitCodeListVersionID'), unitCodeListVersionID.toString(),) : null,

    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'BaseUnitMeasure',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

