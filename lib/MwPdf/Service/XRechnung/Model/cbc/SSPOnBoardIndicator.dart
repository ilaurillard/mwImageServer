import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class SSPOnBoardIndicator {

  final bool value; // (boolean)

  SSPOnBoardIndicator ({
    required this.value,
  });

  static SSPOnBoardIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SSPOnBoardIndicator (
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

  static SSPOnBoardIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SSPOnBoardIndicator (
      value: xml.innerText as bool? ?? false,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'SSPOnBoardIndicator',
        'cbc',
      ),
    );
  }
}

