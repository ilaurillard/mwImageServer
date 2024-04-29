import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class StartDate {

  final XsdDate value; // (date)

  StartDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static StartDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return StartDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  static StartDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return StartDate (
      value: null,
    );
  }

}

