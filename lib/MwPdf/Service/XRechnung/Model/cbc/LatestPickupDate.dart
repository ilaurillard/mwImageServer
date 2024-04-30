import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class LatestPickupDate {

  final XsdDate value; // (date)

  LatestPickupDate ({
    required this.value,
  });

  static LatestPickupDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LatestPickupDate (
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

  static LatestPickupDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return LatestPickupDate (
      value: XsdDate.fromJson(xml.innerText)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      XmlText(value.toString()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'LatestPickupDate',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

