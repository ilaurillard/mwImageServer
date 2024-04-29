import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/EnvironmentalEmissionTypeCode.dart';
import '../cbc/ValueMeasure.dart';
import '../cbc/Description.dart';
import '../cac/EmissionCalculationMethod.dart';

// A class to describe an environmental emission.
class EnvironmentalEmission {


  // A code specifying the type of environmental emission.
  final EnvironmentalEmissionTypeCode environmentalEmissionTypeCode;

  // A value measurement for the environmental emission.
  final ValueMeasure valueMeasure;

  // Text describing this environmental emission.
  final List<Description> description;

  // A method used to calculate the amount of this emission.
  final List<EmissionCalculationMethod> emissionCalculationMethod;

  EnvironmentalEmission ({
    required this.environmentalEmissionTypeCode,
    required this.valueMeasure,
    this.description = const [],
    this.emissionCalculationMethod = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'environmentalEmissionTypeCode': environmentalEmissionTypeCode.toJson(),
      'valueMeasure': valueMeasure.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'emissionCalculationMethod': emissionCalculationMethod.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EnvironmentalEmission? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EnvironmentalEmission (
      environmentalEmissionTypeCode: EnvironmentalEmissionTypeCode.fromJson(json['environmentalEmissionTypeCode'] as Map<String, dynamic>?)!,
      valueMeasure: ValueMeasure.fromJson(json['valueMeasure'] as Map<String, dynamic>?)!,
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      emissionCalculationMethod: (json['emissionCalculationMethod'] as List? ?? []).map((dynamic d) => EmissionCalculationMethod.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static EnvironmentalEmission? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return EnvironmentalEmission (
      environmentalEmissionTypeCode: null,
      valueMeasure: null,
      description: null,
      emissionCalculationMethod: null,
    );
  }

}

