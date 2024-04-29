import 'dart:convert';
import '../cbc/AttributeID.dart';
import '../cbc/Measure.dart';
import '../cbc/Description.dart';

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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'attributeID': attributeID.toJson(),
     'measure': measure.toJson(),
     'description': description.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

