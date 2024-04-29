import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// An instance of time that occurs every day.
class ManufactureTime {

  final XsdTime value; // (time)

  ManufactureTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ManufactureTime? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ManufactureTime (
      value: XsdTime.fromJson(json['value'] as String?)!,
    );
  }

  static ManufactureTime? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ManufactureTime (
      value: null,
    );
  }

}

