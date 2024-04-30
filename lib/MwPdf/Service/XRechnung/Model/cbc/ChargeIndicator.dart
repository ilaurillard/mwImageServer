import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class ChargeIndicator {

  final bool value; // (boolean)

  ChargeIndicator ({
    required this.value,
  });

  static ChargeIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ChargeIndicator (
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

  static ChargeIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ChargeIndicator (
      value: xml.innerText as bool? ?? false,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'ChargeIndicator',
        'cbc',
      ),
    );
  }
}

