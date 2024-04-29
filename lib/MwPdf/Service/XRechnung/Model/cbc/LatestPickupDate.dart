import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class LatestPickupDate {

  final XsdDate value; // (date)

  LatestPickupDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static LatestPickupDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LatestPickupDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  static LatestPickupDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return LatestPickupDate (
      value: null,
    );
  }

}

