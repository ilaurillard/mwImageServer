import '../cac/AttributeID.dart';
import '../cac/Measure.dart';
import '../cac/Description.dart';

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
}

