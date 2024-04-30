import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/NavigationStatusCode.dart';
import '../cbc/AtAnchorageIndicator.dart';
import '../cbc/CourseOverGroundDirection.dart';
import '../cbc/SpeedOverGroundMeasure.dart';
import '../cbc/RateOfTurnMeasure.dart';

// A class to describe the dynamics of a vesssel.
class VesselDynamics {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A code specifying the navigation status for the vessel.
  final NavigationStatusCode? navigationStatusCode;

  // Indicates whether the vessel is at anchor.
  final AtAnchorageIndicator? atAnchorageIndicator;

  // Text describing the actual direction of progress of a vessel, between two points, in relation to the surface of the earth.
  final CourseOverGroundDirection? courseOverGroundDirection;

  // Text describing the speed of the vessel relative to the surface of the earth.
  final SpeedOverGroundMeasure? speedOverGroundMeasure;

  // Text describing the rate at which the vessel is turning.
  final RateOfTurnMeasure? rateOfTurnMeasure;

  VesselDynamics ({
    this.uBLExtensions,
    this.navigationStatusCode,
    this.atAnchorageIndicator,
    this.courseOverGroundDirection,
    this.speedOverGroundMeasure,
    this.rateOfTurnMeasure,
  });

  static VesselDynamics? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return VesselDynamics (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      navigationStatusCode: NavigationStatusCode.fromJson(json['navigationStatusCode'] as Map<String, dynamic>?),
      atAnchorageIndicator: AtAnchorageIndicator.fromJson(json['atAnchorageIndicator'] as Map<String, dynamic>?),
      courseOverGroundDirection: CourseOverGroundDirection.fromJson(json['courseOverGroundDirection'] as Map<String, dynamic>?),
      speedOverGroundMeasure: SpeedOverGroundMeasure.fromJson(json['speedOverGroundMeasure'] as Map<String, dynamic>?),
      rateOfTurnMeasure: RateOfTurnMeasure.fromJson(json['rateOfTurnMeasure'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'navigationStatusCode': navigationStatusCode?.toJson(),
      'atAnchorageIndicator': atAnchorageIndicator?.toJson(),
      'courseOverGroundDirection': courseOverGroundDirection?.toJson(),
      'speedOverGroundMeasure': speedOverGroundMeasure?.toJson(),
      'rateOfTurnMeasure': rateOfTurnMeasure?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static VesselDynamics? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return VesselDynamics (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      navigationStatusCode: NavigationStatusCode.fromXml(xml.findElements('cbc:NavigationStatusCode').singleOrNull),
      atAnchorageIndicator: AtAnchorageIndicator.fromXml(xml.findElements('cbc:AtAnchorageIndicator').singleOrNull),
      courseOverGroundDirection: CourseOverGroundDirection.fromXml(xml.findElements('cbc:CourseOverGroundDirection').singleOrNull),
      speedOverGroundMeasure: SpeedOverGroundMeasure.fromXml(xml.findElements('cbc:SpeedOverGroundMeasure').singleOrNull),
      rateOfTurnMeasure: RateOfTurnMeasure.fromXml(xml.findElements('cbc:RateOfTurnMeasure').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      navigationStatusCode?.toXml(),
      atAnchorageIndicator?.toXml(),
      courseOverGroundDirection?.toXml(),
      speedOverGroundMeasure?.toXml(),
      rateOfTurnMeasure?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'VesselDynamics',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

