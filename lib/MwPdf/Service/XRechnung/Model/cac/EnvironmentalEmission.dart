import '../cac/EnvironmentalEmissionTypeCode.dart';
import '../cac/ValueMeasure.dart';
import '../cac/Description.dart';
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
}

