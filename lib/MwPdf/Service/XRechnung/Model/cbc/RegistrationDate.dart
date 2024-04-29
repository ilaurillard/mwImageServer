import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class RegistrationDate {

  final XsdDate value; // (date)

  RegistrationDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static RegistrationDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return RegistrationDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  static RegistrationDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return RegistrationDate (
      value: null,
    );
  }

}

