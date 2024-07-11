// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/AttributeID.dart';
import '../cbc/Measure.dart';
import '../cbc/MeasureCode.dart';
import '../cbc/Description.dart';

// A class to describe a measurement of temperature.
class FlashpointTemperature {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this temperature measurement.
  final AttributeID? attributeID;

  // The value of this temperature measurement.
  final Measure? measure;

  // A code describing the temperature, when not expressed as a measure.
  final MeasureCode? measureCode;

  // Text describing this temperature measurement.
  final List<Description> description;

  FlashpointTemperature ({
    this.uBLExtensions,
    this.attributeID,
    this.measure,
    this.measureCode,
    this.description = const [],
  });

  static FlashpointTemperature? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return FlashpointTemperature (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      attributeID: AttributeID.fromJson(json['attributeID'] as Map<String, dynamic>?),
      measure: Measure.fromJson(json['measure'] as Map<String, dynamic>?),
      measureCode: MeasureCode.fromJson(json['measureCode'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'attributeID': attributeID?.toJson(),
      'measure': measure?.toJson(),
      'measureCode': measureCode?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static FlashpointTemperature? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return FlashpointTemperature (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      attributeID: AttributeID.fromXml(xml.findElements('cbc:AttributeID').singleOrNull),
      measure: Measure.fromXml(xml.findElements('cbc:Measure').singleOrNull),
      measureCode: MeasureCode.fromXml(xml.findElements('cbc:MeasureCode').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      attributeID?.toXml(),
      measure?.toXml(),
      measureCode?.toXml(),
      ...description.map((Description e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'FlashpointTemperature',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

