import '../cac/AttributeID.dart';
import '../cac/Measure.dart';
import '../cac/Description.dart';
import '../cac/MinimumMeasure.dart';
import '../cac/MaximumMeasure.dart';

// A class to define a measurable dimension (length, mass, weight, volume, or area) of an item.
class Dimension {


  // An identifier for the attribute to which the measure applies.
  final AttributeID attributeID;

  // The measurement value.
  final Measure? measure;

  // Text describing the measurement attribute.
  final List<Description> description;

  // The minimum value in a range of measurement of this dimension.
  final MinimumMeasure? minimumMeasure;

  // The maximum value in a range of measurement of this dimension.
  final MaximumMeasure? maximumMeasure;

  Dimension ({
    required this.attributeID,
    this.measure,
    this.description = const [],
    this.minimumMeasure,
    this.maximumMeasure,
  });
}

