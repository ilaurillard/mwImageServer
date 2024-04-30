import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class ReceivedDate {

  final XsdDate value; // (date)

  ReceivedDate ({
    required this.value,
  });

  static ReceivedDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ReceivedDate (
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

  static ReceivedDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ReceivedDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'ReceivedDate',
        'cbc',
      ),
    );
  }
}

