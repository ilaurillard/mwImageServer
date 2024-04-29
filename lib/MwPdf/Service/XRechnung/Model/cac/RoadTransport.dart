import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/LicensePlateID.dart';

// A class for identifying a vehicle used for road transport.
class RoadTransport {


  // The license plate identifier of this vehicle.
  final LicensePlateID licensePlateID;

  RoadTransport ({
    required this.licensePlateID,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'licensePlateID': licensePlateID.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  RoadTransport fromJson(Map<String, dynamic> json) {
    return RoadTransport (
    );
  }

}

