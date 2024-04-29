import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/AttributeID.dart';
import '../cbc/Measure.dart';
import '../cbc/Description.dart';
import '../cbc/MinimumMeasure.dart';
import '../cbc/MaximumMeasure.dart';

// A class to define a measurable condition of an object.
class Condition {


  // An identifier for the attribute that applies to the condition.
  final AttributeID attributeID;

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


  Condition fromJson(Map<String, dynamic> json) {
    return Condition (
    );
  }

}

