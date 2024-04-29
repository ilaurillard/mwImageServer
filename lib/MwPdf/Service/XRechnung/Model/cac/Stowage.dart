import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/LocationID.dart';
import '../cbc/Location.dart';
import '../cac/MeasurementDimension.dart';

// A class to describe a location on board a means of transport where specified goods or transport equipment have been stowed or are to be stowed.
class Stowage {


  // An identifier for the location.
  final LocationID? locationID;

  // Text describing the location.
  final List<Location> location;

  // A measurable dimension (length, mass, weight, or volume) of this stowage.
  final List<MeasurementDimension> measurementDimension;

  Stowage ({
    this.locationID,
    this.location = const [],
    this.measurementDimension = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'locationID': locationID?.toJson(),
     'location': location.map((e) => e.toJson()).toList(),
     'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  Stowage fromJson(Map<String, dynamic> json) {
    return Stowage (
    );
  }

}

