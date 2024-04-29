import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class ReferenceDate {

  final XsdDate value; // (date)

  ReferenceDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ReferenceDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ReferenceDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  static ReferenceDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ReferenceDate (
      value: null,
    );
  }

}

