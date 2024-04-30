import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/AircraftID.dart';
import '../ext/UBLExtensions.dart';

// A class to identify a specific aircraft used for transportation.
class AirTransport {


  // An identifer for a specific aircraft.
  final AircraftID aircraftID;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  AirTransport ({
    required this.aircraftID,
    this.uBLExtensions,
  });

  static AirTransport? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AirTransport (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      aircraftID: AircraftID.fromJson(json['aircraftID'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'aircraftID': aircraftID.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AirTransport? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AirTransport (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      aircraftID: AircraftID.fromXml(xml.findElements('cbc:AircraftID').singleOrNull)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'AirTransport',
        'cac',
      ),
    );
  }
}

