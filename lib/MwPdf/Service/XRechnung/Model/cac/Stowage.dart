import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/LocationID.dart';
import '../cbc/Location.dart';
import '../cac/MeasurementDimension.dart';

// A class to describe a location on board a means of transport where specified goods or transport equipment have been stowed or are to be stowed.
class Stowage {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for the location.
  final LocationID? locationID;

  // Text describing the location.
  final List<Location> location;

  // A measurable dimension (length, mass, weight, or volume) of this stowage.
  final List<MeasurementDimension> measurementDimension;

  Stowage ({
    this.uBLExtensions,
    this.locationID,
    this.location = const [],
    this.measurementDimension = const [],
  });

  static Stowage? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Stowage (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      locationID: LocationID.fromJson(json['locationID'] as Map<String, dynamic>?),
      location: (json['location'] as List? ?? []).map((dynamic d) => Location.fromJson(d as Map<String, dynamic>?)!).toList(),
      measurementDimension: (json['measurementDimension'] as List? ?? []).map((dynamic d) => MeasurementDimension.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'locationID': locationID?.toJson(),
      'location': location.map((e) => e.toJson()).toList(),
      'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Stowage? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return Stowage (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      locationID: LocationID.fromXml(xml.findElements('cbc:LocationID').singleOrNull),
      location: xml.findElements('cbc:Location').map((XmlElement e) => Location.fromXml(e)!).toList(),
      measurementDimension: xml.findElements('cac:MeasurementDimension').map((XmlElement e) => MeasurementDimension.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'Stowage',
        'cac',
      ),
    );
  }
}

