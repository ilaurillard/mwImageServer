// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/AttributeID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Measure.dart';
import '../cbc/Description.dart';
import '../cbc/MinimumMeasure.dart';
import '../cbc/MaximumMeasure.dart';

// A class to define a measurable condition of an object.
class Condition {


  // An identifier for the attribute that applies to the condition.
  final AttributeID attributeID;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
    this.uBLExtensions,
    this.measure,
    this.description = const [],
    this.minimumMeasure,
    this.maximumMeasure,
  });

  static Condition? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Condition (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      attributeID: AttributeID.fromJson(json['attributeID'] as Map<String, dynamic>?)!,
      measure: Measure.fromJson(json['measure'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      minimumMeasure: MinimumMeasure.fromJson(json['minimumMeasure'] as Map<String, dynamic>?),
      maximumMeasure: MaximumMeasure.fromJson(json['maximumMeasure'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'attributeID': attributeID.toJson(),
      'measure': measure?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'minimumMeasure': minimumMeasure?.toJson(),
      'maximumMeasure': maximumMeasure?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Condition? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return Condition (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      attributeID: AttributeID.fromXml(xml.findElements('cbc:AttributeID').singleOrNull)!,
      measure: Measure.fromXml(xml.findElements('cbc:Measure').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      minimumMeasure: MinimumMeasure.fromXml(xml.findElements('cbc:MinimumMeasure').singleOrNull),
      maximumMeasure: MaximumMeasure.fromXml(xml.findElements('cbc:MaximumMeasure').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      attributeID.toXml(),
      measure?.toXml(),
      ...description.map((Description e) => e.toXml()),
      minimumMeasure?.toXml(),
      maximumMeasure?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'Condition',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

