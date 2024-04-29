import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class EarliestPickupDate {

  final XsdDate value; // (date)

  EarliestPickupDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EarliestPickupDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EarliestPickupDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  static EarliestPickupDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return EarliestPickupDate (
      value: null,
    );
  }

}

