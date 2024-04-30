import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class SSPSecurityMeasuresAppliedIndicator {

  final bool value; // (boolean)

  SSPSecurityMeasuresAppliedIndicator ({
    required this.value,
  });

  static SSPSecurityMeasuresAppliedIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SSPSecurityMeasuresAppliedIndicator (
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

  static SSPSecurityMeasuresAppliedIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SSPSecurityMeasuresAppliedIndicator (
      value: xml.innerText as bool? ?? false,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'SSPSecurityMeasuresAppliedIndicator',
        'cbc',
      ),
    );
  }
}

