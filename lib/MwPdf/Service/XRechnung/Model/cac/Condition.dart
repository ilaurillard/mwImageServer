import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/AttributeID.dart';
import '../cbc/Measure.dart';
import '../cbc/Description.dart';
import '../cbc/MinimumMeasure.dart';
import '../cbc/MaximumMeasure.dart';

// A class to define a measurable condition of an object.
class Condition {


  // An identifier for the attribute that applies to the condition.
  final AttributeID attributeID;

  // The measurement value.
  final Measure? measure;

  // Text describing the attribute that applies to the condition.
  final List<Description> description;

  // The minimum value in a range of measurement for this condition.
  final MinimumMeasure? minimumMeasure;

  // The maximum value in a range of measurement for this condition.
  final MaximumMeasure? maximumMeasure;

  Condition ({
    required this.attributeID,
    this.measure,
    this.description = const [],
    this.minimumMeasure,
    this.maximumMeasure,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'attributeID': attributeID.toJson(),
      'measure': measure?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'minimumMeasure': minimumMeasure?.toJson(),
      'maximumMeasure': maximumMeasure?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Condition? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Condition (
      attributeID: AttributeID.fromJson(json['attributeID'] as Map<String, dynamic>?)!,
      measure: Measure.fromJson(json['measure'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      minimumMeasure: MinimumMeasure.fromJson(json['minimumMeasure'] as Map<String, dynamic>?),
      maximumMeasure: MaximumMeasure.fromJson(json['maximumMeasure'] as Map<String, dynamic>?),
    );
  }

  static Condition? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return Condition (
      attributeID: null,
      measure: null,
      description: null,
      minimumMeasure: null,
      maximumMeasure: null,
    );
  }

}

