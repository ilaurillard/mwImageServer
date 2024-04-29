import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/AircraftID.dart';

// A class to identify a specific aircraft used for transportation.
class AirTransport {


  // An identifer for a specific aircraft.
  final AircraftID aircraftID;

  AirTransport ({
    required this.aircraftID,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'aircraftID': aircraftID.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AirTransport? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AirTransport (
      aircraftID: AircraftID.fromJson(json['aircraftID'] as Map<String, dynamic>?)!,
    );
  }

  static AirTransport? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return AirTransport (
      aircraftID: null,
    );
  }

}

