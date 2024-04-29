import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/AttributeID.dart';
import '../cbc/Measure.dart';
import '../cbc/Description.dart';

// A class to describe a measurement of temperature.
class FlashpointTemperature {


  // An identifier for this temperature measurement.
  final AttributeID attributeID;

  // The value of this temperature measurement.
  final Measure measure;

  // Text describing this temperature measurement.
  final List<Description> description;

  FlashpointTemperature ({
    required this.attributeID,
    required this.measure,
    this.description = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'attributeID': attributeID.toJson(),
      'measure': measure.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static FlashpointTemperature? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return FlashpointTemperature (
      attributeID: AttributeID.fromJson(json['attributeID'] as Map<String, dynamic>?)!,
      measure: Measure.fromJson(json['measure'] as Map<String, dynamic>?)!,
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static FlashpointTemperature? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return FlashpointTemperature (
      attributeID: null,
      measure: null,
      description: null,
    );
  }

}

