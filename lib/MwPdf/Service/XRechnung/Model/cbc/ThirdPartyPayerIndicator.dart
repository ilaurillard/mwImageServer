import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class ThirdPartyPayerIndicator {

  final bool value; // (boolean)

  ThirdPartyPayerIndicator ({
    required this.value,
  });

  static ThirdPartyPayerIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ThirdPartyPayerIndicator (
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

  static ThirdPartyPayerIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ThirdPartyPayerIndicator (
      value: xml.innerText as bool? ?? false,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'ThirdPartyPayerIndicator',
        'cbc',
      ),
    );
  }
}

