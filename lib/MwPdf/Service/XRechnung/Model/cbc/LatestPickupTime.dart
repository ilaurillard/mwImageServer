import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// An instance of time that occurs every day.
class LatestPickupTime {

  final XsdTime value; // (time)

  LatestPickupTime ({
    required this.value,
  });

  static LatestPickupTime? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LatestPickupTime (
      value: XsdTime.fromJson(json['value'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static LatestPickupTime? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return LatestPickupTime (
      value: XsdTime.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'LatestPickupTime',
        'cbc',
      ),
    );
  }
}

