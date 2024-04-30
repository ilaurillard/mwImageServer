import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class AnimalFoodIndicator {

  final bool value; // (boolean)

  AnimalFoodIndicator ({
    required this.value,
  });

  static AnimalFoodIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AnimalFoodIndicator (
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

  static AnimalFoodIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AnimalFoodIndicator (
      value: xml.innerText as bool? ?? false,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'AnimalFoodIndicator',
        'cbc',
      ),
    );
  }
}

