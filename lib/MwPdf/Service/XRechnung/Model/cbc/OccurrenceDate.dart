import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class OccurrenceDate {

  final XsdDate value; // (date)

  OccurrenceDate ({
    required this.value,
  });

  static OccurrenceDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OccurrenceDate (
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

  static OccurrenceDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OccurrenceDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'OccurrenceDate',
        'cbc',
      ),
    );
  }
}

