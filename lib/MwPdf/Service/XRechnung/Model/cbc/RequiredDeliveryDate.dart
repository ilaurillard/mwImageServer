import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class RequiredDeliveryDate {

  final XsdDate value; // (date)

  RequiredDeliveryDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static RequiredDeliveryDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return RequiredDeliveryDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  static RequiredDeliveryDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return RequiredDeliveryDate (
      value: null,
    );
  }

}

