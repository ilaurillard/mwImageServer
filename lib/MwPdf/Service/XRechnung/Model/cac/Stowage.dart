import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
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

  static Stowage? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Stowage (
      locationID: LocationID.fromJson(json['locationID'] as Map<String, dynamic>?),
      location: (json['location'] as List? ?? []).map((dynamic d) => Location.fromJson(d as Map<String, dynamic>?)!).toList(),
      measurementDimension: (json['measurementDimension'] as List? ?? []).map((dynamic d) => MeasurementDimension.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static Stowage? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return Stowage (
      locationID: null,
      location: null,
      measurementDimension: null,
    );
  }

}

