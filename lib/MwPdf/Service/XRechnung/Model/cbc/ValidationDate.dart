import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class ValidationDate {

  final XsdDate value; // (date)

  ValidationDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ValidationDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ValidationDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  static ValidationDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ValidationDate (
      value: null,
    );
  }

}

