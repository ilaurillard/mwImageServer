import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class ValidityStartDate {

  final XsdDate value; // (date)

  ValidityStartDate ({
    required this.value,
  });

  static ValidityStartDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ValidityStartDate (
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

  static ValidityStartDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ValidityStartDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'ValidityStartDate',
        'cbc',
      ),
    );
  }
}

