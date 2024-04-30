import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class ExpiryDate {

  final XsdDate value; // (date)

  ExpiryDate ({
    required this.value,
  });

  static ExpiryDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ExpiryDate (
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

  static ExpiryDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ExpiryDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'ExpiryDate',
        'cbc',
      ),
    );
  }
}

