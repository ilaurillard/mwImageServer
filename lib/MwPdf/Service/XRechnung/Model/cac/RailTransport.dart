import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/TrainID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/RailCarID.dart';

// A class defining details about a train wagon used as a means of transport.
class RailTransport {


  // An identifier for the train used as the means of transport.
  final TrainID trainID;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for the rail car on the train used as the means of transport.
  final RailCarID? railCarID;

  RailTransport ({
    required this.trainID,
    this.uBLExtensions,
    this.railCarID,
  });

  static RailTransport? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return RailTransport (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      trainID: TrainID.fromJson(json['trainID'] as Map<String, dynamic>?)!,
      railCarID: RailCarID.fromJson(json['railCarID'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'trainID': trainID.toJson(),
      'railCarID': railCarID?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static RailTransport? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return RailTransport (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      trainID: TrainID.fromXml(xml.findElements('cbc:TrainID').singleOrNull)!,
      railCarID: RailCarID.fromXml(xml.findElements('cbc:RailCarID').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'RailTransport',
        'cac',
      ),
    );
  }
}

