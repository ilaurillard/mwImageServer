import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class LatestDeliveryDate {

  final XsdDate value; // (date)

  LatestDeliveryDate ({
    required this.value,
  });

  static LatestDeliveryDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LatestDeliveryDate (
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

  static LatestDeliveryDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return LatestDeliveryDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'LatestDeliveryDate',
        'cbc',
      ),
    );
  }
}

