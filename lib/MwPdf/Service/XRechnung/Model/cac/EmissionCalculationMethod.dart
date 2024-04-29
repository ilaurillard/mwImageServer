import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/CalculationMethodCode.dart';
import '../cbc/FullnessIndicationCode.dart';
import '../cac/MeasurementFromLocation.dart';
import '../cac/MeasurementToLocation.dart';

// A class to define how an environmental emission is calculated.
class EmissionCalculationMethod {


  // A code signifying the method used to calculate the emission.
  final CalculationMethodCode? calculationMethodCode;

  // A code signifying whether a piece of transport equipment is full, partially full, or empty. This indication is used as a parameter when calculating the environmental emission.
  final FullnessIndicationCode? fullnessIndicationCode;

  // A start location from which an environmental emission is calculated.
  final MeasurementFromLocation? measurementFromLocation;

  // An end location to which an environmental emission is calculated.
  final MeasurementToLocation? measurementToLocation;

  EmissionCalculationMethod ({
    this.calculationMethodCode,
    this.fullnessIndicationCode,
    this.measurementFromLocation,
    this.measurementToLocation,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'calculationMethodCode': calculationMethodCode?.toJson(),
      'fullnessIndicationCode': fullnessIndicationCode?.toJson(),
      'measurementFromLocation': measurementFromLocation?.toJson(),
      'measurementToLocation': measurementToLocation?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EmissionCalculationMethod? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EmissionCalculationMethod (
      calculationMethodCode: CalculationMethodCode.fromJson(json['calculationMethodCode'] as Map<String, dynamic>?),
      fullnessIndicationCode: FullnessIndicationCode.fromJson(json['fullnessIndicationCode'] as Map<String, dynamic>?),
      measurementFromLocation: MeasurementFromLocation.fromJson(json['measurementFromLocation'] as Map<String, dynamic>?),
      measurementToLocation: MeasurementToLocation.fromJson(json['measurementToLocation'] as Map<String, dynamic>?),
    );
  }

  static EmissionCalculationMethod? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return EmissionCalculationMethod (
      calculationMethodCode: null,
      fullnessIndicationCode: null,
      measurementFromLocation: null,
      measurementToLocation: null,
    );
  }

}

