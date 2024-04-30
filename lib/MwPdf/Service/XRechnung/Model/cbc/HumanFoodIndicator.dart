import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class HumanFoodIndicator {

  final bool value; // (boolean)

  HumanFoodIndicator ({
    required this.value,
  });

  static HumanFoodIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return HumanFoodIndicator (
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

  static HumanFoodIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return HumanFoodIndicator (
      value: xml.innerText as bool? ?? false,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'HumanFoodIndicator',
        'cbc',
      ),
    );
  }
}

