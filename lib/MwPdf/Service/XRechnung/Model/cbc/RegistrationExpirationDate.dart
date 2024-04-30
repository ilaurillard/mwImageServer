import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class RegistrationExpirationDate {

  final XsdDate value; // (date)

  RegistrationExpirationDate ({
    required this.value,
  });

  static RegistrationExpirationDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return RegistrationExpirationDate (
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

  static RegistrationExpirationDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return RegistrationExpirationDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'RegistrationExpirationDate',
        'cbc',
      ),
    );
  }
}

