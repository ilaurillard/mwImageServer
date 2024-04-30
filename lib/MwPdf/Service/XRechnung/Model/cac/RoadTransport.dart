import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/LicensePlateID.dart';
import '../ext/UBLExtensions.dart';

// A class for identifying a vehicle used for road transport.
class RoadTransport {


  // The license plate identifier of this vehicle.
  final LicensePlateID licensePlateID;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  RoadTransport ({
    required this.licensePlateID,
    this.uBLExtensions,
  });

  static RoadTransport? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return RoadTransport (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      licensePlateID: LicensePlateID.fromJson(json['licensePlateID'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'licensePlateID': licensePlateID.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static RoadTransport? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return RoadTransport (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      licensePlateID: LicensePlateID.fromXml(xml.findElements('cbc:LicensePlateID').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      licensePlateID.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'RoadTransport',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

