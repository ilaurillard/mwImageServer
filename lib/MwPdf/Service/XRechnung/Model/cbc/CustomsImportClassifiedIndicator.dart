import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class CustomsImportClassifiedIndicator {

  final bool value; // (boolean)

  CustomsImportClassifiedIndicator ({
    required this.value,
  });

  static CustomsImportClassifiedIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CustomsImportClassifiedIndicator (
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

  static CustomsImportClassifiedIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return CustomsImportClassifiedIndicator (
      value: xml.innerText as bool? ?? false,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'CustomsImportClassifiedIndicator',
        'cbc',
      ),
    );
  }
}

