import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class HumanFoodApprovedIndicator {

  final bool value; // (boolean)

  HumanFoodApprovedIndicator ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static HumanFoodApprovedIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return HumanFoodApprovedIndicator (
      value: json['value'] as bool? ?? false,
    );
  }

  static HumanFoodApprovedIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return HumanFoodApprovedIndicator (
      value: null,
    );
  }

}

