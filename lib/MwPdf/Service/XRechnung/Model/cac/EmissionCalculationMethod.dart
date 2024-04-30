import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/CalculationMethodCode.dart';
import '../cbc/FullnessIndicationCode.dart';
import '../cac/MeasurementFromLocation.dart';
import '../cac/MeasurementToLocation.dart';

// A class to define how an environmental emission is calculated.
class EmissionCalculationMethod {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A code signifying the method used to calculate the emission.
  final CalculationMethodCode? calculationMethodCode;

  // A code signifying whether a piece of transport equipment is full, partially full, or empty. This indication is used as a parameter when calculating the environmental emission.
  final FullnessIndicationCode? fullnessIndicationCode;

  // A start location from which an environmental emission is calculated.
  final MeasurementFromLocation? measurementFromLocation;

  // An end location to which an environmental emission is calculated.
  final MeasurementToLocation? measurementToLocation;

  EmissionCalculationMethod ({
    this.uBLExtensions,
    this.calculationMethodCode,
    this.fullnessIndicationCode,
    this.measurementFromLocation,
    this.measurementToLocation,
  });

  static EmissionCalculationMethod? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EmissionCalculationMethod (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      calculationMethodCode: CalculationMethodCode.fromJson(json['calculationMethodCode'] as Map<String, dynamic>?),
      fullnessIndicationCode: FullnessIndicationCode.fromJson(json['fullnessIndicationCode'] as Map<String, dynamic>?),
      measurementFromLocation: MeasurementFromLocation.fromJson(json['measurementFromLocation'] as Map<String, dynamic>?),
      measurementToLocation: MeasurementToLocation.fromJson(json['measurementToLocation'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'calculationMethodCode': calculationMethodCode?.toJson(),
      'fullnessIndicationCode': fullnessIndicationCode?.toJson(),
      'measurementFromLocation': measurementFromLocation?.toJson(),
      'measurementToLocation': measurementToLocation?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EmissionCalculationMethod? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return EmissionCalculationMethod (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      calculationMethodCode: CalculationMethodCode.fromXml(xml.findElements('cbc:CalculationMethodCode').singleOrNull),
      fullnessIndicationCode: FullnessIndicationCode.fromXml(xml.findElements('cbc:FullnessIndicationCode').singleOrNull),
      measurementFromLocation: MeasurementFromLocation.fromXml(xml.findElements('cac:MeasurementFromLocation').singleOrNull),
      measurementToLocation: MeasurementToLocation.fromXml(xml.findElements('cac:MeasurementToLocation').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      calculationMethodCode?.toXml(),
      fullnessIndicationCode?.toXml(),
      measurementFromLocation?.toXml(),
      measurementToLocation?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'EmissionCalculationMethod',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

