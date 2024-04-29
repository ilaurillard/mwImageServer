import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// An instance of time that occurs every day.
class LatestPickupTime {

  final XsdTime value; // (time)

  LatestPickupTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static LatestPickupTime? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LatestPickupTime (
      value: XsdTime.fromJson(json['value'] as String?)!,
    );
  }

  static LatestPickupTime? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return LatestPickupTime (
      value: null,
    );
  }

}

