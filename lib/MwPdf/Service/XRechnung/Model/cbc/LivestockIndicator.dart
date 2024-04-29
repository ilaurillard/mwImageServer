import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class LivestockIndicator {

  final bool value; // (boolean)

  LivestockIndicator ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static LivestockIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LivestockIndicator (
      value: json['value'] as bool? ?? false,
    );
  }

  static LivestockIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return LivestockIndicator (
      value: null,
    );
  }

}

