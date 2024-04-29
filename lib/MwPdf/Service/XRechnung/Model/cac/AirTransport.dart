import 'dart:convert';
import '../../Etc/Util.dart';
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


  AirTransport fromJson(Map<String, dynamic> json) {
    return AirTransport (
    );
  }

}

