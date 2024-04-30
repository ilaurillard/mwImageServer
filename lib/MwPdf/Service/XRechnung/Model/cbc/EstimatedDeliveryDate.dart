import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class EstimatedDeliveryDate {

  final XsdDate value; // (date)

  EstimatedDeliveryDate ({
    required this.value,
  });

  static EstimatedDeliveryDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EstimatedDeliveryDate (
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

  static EstimatedDeliveryDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return EstimatedDeliveryDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'EstimatedDeliveryDate',
        'cbc',
      ),
    );
  }
}

