import 'dart:convert';
import '../cbc/AttributeID.dart';
import '../cbc/Measure.dart';
import '../cbc/Description.dart';
import '../cbc/MinimumMeasure.dart';
import '../cbc/MaximumMeasure.dart';

// A class to define a measurable dimension (length, mass, weight, volume, or area) of an item.
class RangeDimension {


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

  RangeDimension ({
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

}

