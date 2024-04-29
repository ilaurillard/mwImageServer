import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// An instance of time that occurs every day.
class ActualDeliveryTime {

  final XsdTime value; // (time)

  ActualDeliveryTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ActualDeliveryTime? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ActualDeliveryTime (
      value: XsdTime.fromJson(json['value'] as String?)!,
    );
  }

  static ActualDeliveryTime? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ActualDeliveryTime (
      value: null,
    );
  }

}

