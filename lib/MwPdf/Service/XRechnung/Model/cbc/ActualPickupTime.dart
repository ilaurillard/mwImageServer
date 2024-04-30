import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// An instance of time that occurs every day.
class ActualPickupTime {

  final XsdTime value; // (time)

  ActualPickupTime ({
    required this.value,
  });

  static ActualPickupTime? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ActualPickupTime (
      value: XsdTime.fromJson(json['value'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ActualPickupTime? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ActualPickupTime (
      value: XsdTime.fromJson(xml.innerText)!,
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
        'ActualPickupTime',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

