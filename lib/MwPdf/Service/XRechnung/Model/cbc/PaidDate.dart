import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class PaidDate {

  final XsdDate value; // (date)

  PaidDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PaidDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PaidDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  static PaidDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return PaidDate (
      value: null,
    );
  }

}

