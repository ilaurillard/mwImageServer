import 'dart:convert';
import '../../Etc/Util.dart';
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


  EnvironmentalEmission fromJson(Map<String, dynamic> json) {
    return EnvironmentalEmission (
    );
  }

}

