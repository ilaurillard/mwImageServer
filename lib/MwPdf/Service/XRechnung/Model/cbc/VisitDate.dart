import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class VisitDate {

  final XsdDate value; // (date)

  VisitDate ({
    required this.value,
  });

  static VisitDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return VisitDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static VisitDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return VisitDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'VisitDate',
        'cbc',
      ),
    );
  }
}

