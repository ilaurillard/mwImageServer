import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// An instance of time that occurs every day.
class EstimatedDespatchTime {

  final XsdTime value; // (time)

  EstimatedDespatchTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EstimatedDespatchTime? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EstimatedDespatchTime (
      value: XsdTime.fromJson(json['value'] as String?)!,
    );
  }

  static EstimatedDespatchTime? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return EstimatedDespatchTime (
      value: null,
    );
  }

}

