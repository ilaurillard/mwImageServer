import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
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

  static RoadTransport? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return RoadTransport (
      licensePlateID: LicensePlateID.fromJson(json['licensePlateID'] as Map<String, dynamic>?)!,
    );
  }

  static RoadTransport? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return RoadTransport (
      licensePlateID: null,
    );
  }

}

