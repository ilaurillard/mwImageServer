import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class LastDrinkingWaterAnalysisDate {

  final XsdDate value; // (date)

  LastDrinkingWaterAnalysisDate ({
    required this.value,
  });

  static LastDrinkingWaterAnalysisDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LastDrinkingWaterAnalysisDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static LastDrinkingWaterAnalysisDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return LastDrinkingWaterAnalysisDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      XmlText(value.toString()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'LastDrinkingWaterAnalysisDate',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

