import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class HazardousRiskIndicator {

  final bool value; // (boolean)

  HazardousRiskIndicator ({
    required this.value,
  });

  static HazardousRiskIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return HazardousRiskIndicator (
      value: json['value'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static HazardousRiskIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return HazardousRiskIndicator (
      value: xml.innerText as bool? ?? false,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'HazardousRiskIndicator',
        'cbc',
      ),
    );
  }
}

