import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// An instance of time that occurs every day.
class EstimatedDeliveryTime {

  final XsdTime value; // (time)

  EstimatedDeliveryTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EstimatedDeliveryTime? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EstimatedDeliveryTime (
      value: XsdTime.fromJson(json['value'] as String?)!,
    );
  }

  static EstimatedDeliveryTime? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return EstimatedDeliveryTime (
      value: null,
    );
  }

}

