import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class MarkCareIndicator {

  final bool value; // (boolean)

  MarkCareIndicator ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static MarkCareIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return MarkCareIndicator (
      value: json['value'] as bool? ?? false,
    );
  }

  static MarkCareIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return MarkCareIndicator (
      value: null,
    );
  }

}

