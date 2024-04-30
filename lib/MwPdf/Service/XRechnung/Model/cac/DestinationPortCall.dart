import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/PlannedOperationsDescription.dart';
import '../cbc/PlannedWorksDescription.dart';
import '../cbc/PlannedInspectionsDescription.dart';
import '../cbc/ExpectedAnchorageIndicator.dart';
import '../cbc/PositionInPortID.dart';
import '../cbc/CargoAndBallastTankConditionDescription.dart';
import '../cac/ShipRequirement.dart';
import '../cac/PrimaryPortCallPurpose.dart';
import '../cac/AdditionalPortCallPurpose.dart';
import '../cac/RequestedArrivalEvent.dart';

// A class to describe a call to a port.
class DestinationPortCall {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this Port Call.
  final ID? iD;

  // Description of the planned operations in this Port Call.
  final List<PlannedOperationsDescription> plannedOperationsDescription;

  // Description of the planned works in this Port Call.
  final List<PlannedWorksDescription> plannedWorksDescription;

  // Description of the planned inspections in this Port Call.
  final List<PlannedInspectionsDescription> plannedInspectionsDescription;

  // An indicator of whether the ship is expected to stay at an anchorage upon arrival at the port of call (true) or not (false).
  final ExpectedAnchorageIndicator? expectedAnchorageIndicator;

  // An identifier for the position in the port for this Port Call
  final PositionInPortID? positionInPortID;

  // Description about the condition of the cargo and ballast tank.
  final List<CargoAndBallastTankConditionDescription> cargoAndBallastTankConditionDescription;

  // Ship requirements for this port call.
  final List<ShipRequirement> shipRequirement;

  // The primary purpose of this port call.
  final PrimaryPortCallPurpose? primaryPortCallPurpose;

  // Any additional or secondary purposes of this port call.
  final List<AdditionalPortCallPurpose> additionalPortCallPurpose;

  // The requested arrival event.
  final RequestedArrivalEvent? requestedArrivalEvent;

  DestinationPortCall ({
    this.uBLExtensions,
    this.iD,
    this.plannedOperationsDescription = const [],
    this.plannedWorksDescription = const [],
    this.plannedInspectionsDescription = const [],
    this.expectedAnchorageIndicator,
    this.positionInPortID,
    this.cargoAndBallastTankConditionDescription = const [],
    this.shipRequirement = const [],
    this.primaryPortCallPurpose,
    this.additionalPortCallPurpose = const [],
    this.requestedArrivalEvent,
  });

  static DestinationPortCall? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DestinationPortCall (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      plannedOperationsDescription: (json['plannedOperationsDescription'] as List? ?? []).map((dynamic d) => PlannedOperationsDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      plannedWorksDescription: (json['plannedWorksDescription'] as List? ?? []).map((dynamic d) => PlannedWorksDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      plannedInspectionsDescription: (json['plannedInspectionsDescription'] as List? ?? []).map((dynamic d) => PlannedInspectionsDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      expectedAnchorageIndicator: ExpectedAnchorageIndicator.fromJson(json['expectedAnchorageIndicator'] as Map<String, dynamic>?),
      positionInPortID: PositionInPortID.fromJson(json['positionInPortID'] as Map<String, dynamic>?),
      cargoAndBallastTankConditionDescription: (json['cargoAndBallastTankConditionDescription'] as List? ?? []).map((dynamic d) => CargoAndBallastTankConditionDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      shipRequirement: (json['shipRequirement'] as List? ?? []).map((dynamic d) => ShipRequirement.fromJson(d as Map<String, dynamic>?)!).toList(),
      primaryPortCallPurpose: PrimaryPortCallPurpose.fromJson(json['primaryPortCallPurpose'] as Map<String, dynamic>?),
      additionalPortCallPurpose: (json['additionalPortCallPurpose'] as List? ?? []).map((dynamic d) => AdditionalPortCallPurpose.fromJson(d as Map<String, dynamic>?)!).toList(),
      requestedArrivalEvent: RequestedArrivalEvent.fromJson(json['requestedArrivalEvent'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'plannedOperationsDescription': plannedOperationsDescription.map((e) => e.toJson()).toList(),
      'plannedWorksDescription': plannedWorksDescription.map((e) => e.toJson()).toList(),
      'plannedInspectionsDescription': plannedInspectionsDescription.map((e) => e.toJson()).toList(),
      'expectedAnchorageIndicator': expectedAnchorageIndicator?.toJson(),
      'positionInPortID': positionInPortID?.toJson(),
      'cargoAndBallastTankConditionDescription': cargoAndBallastTankConditionDescription.map((e) => e.toJson()).toList(),
      'shipRequirement': shipRequirement.map((e) => e.toJson()).toList(),
      'primaryPortCallPurpose': primaryPortCallPurpose?.toJson(),
      'additionalPortCallPurpose': additionalPortCallPurpose.map((e) => e.toJson()).toList(),
      'requestedArrivalEvent': requestedArrivalEvent?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DestinationPortCall? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return DestinationPortCall (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      plannedOperationsDescription: xml.findElements('cbc:PlannedOperationsDescription').map((XmlElement e) => PlannedOperationsDescription.fromXml(e)!).toList(),
      plannedWorksDescription: xml.findElements('cbc:PlannedWorksDescription').map((XmlElement e) => PlannedWorksDescription.fromXml(e)!).toList(),
      plannedInspectionsDescription: xml.findElements('cbc:PlannedInspectionsDescription').map((XmlElement e) => PlannedInspectionsDescription.fromXml(e)!).toList(),
      expectedAnchorageIndicator: ExpectedAnchorageIndicator.fromXml(xml.findElements('cbc:ExpectedAnchorageIndicator').singleOrNull),
      positionInPortID: PositionInPortID.fromXml(xml.findElements('cbc:PositionInPortID').singleOrNull),
      cargoAndBallastTankConditionDescription: xml.findElements('cbc:CargoAndBallastTankConditionDescription').map((XmlElement e) => CargoAndBallastTankConditionDescription.fromXml(e)!).toList(),
      shipRequirement: xml.findElements('cac:ShipRequirement').map((XmlElement e) => ShipRequirement.fromXml(e)!).toList(),
      primaryPortCallPurpose: PrimaryPortCallPurpose.fromXml(xml.findElements('cac:PrimaryPortCallPurpose').singleOrNull),
      additionalPortCallPurpose: xml.findElements('cac:AdditionalPortCallPurpose').map((XmlElement e) => AdditionalPortCallPurpose.fromXml(e)!).toList(),
      requestedArrivalEvent: RequestedArrivalEvent.fromXml(xml.findElements('cac:RequestedArrivalEvent').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      ...plannedOperationsDescription.map((PlannedOperationsDescription e) => e.toXml()).toList(),
      ...plannedWorksDescription.map((PlannedWorksDescription e) => e.toXml()).toList(),
      ...plannedInspectionsDescription.map((PlannedInspectionsDescription e) => e.toXml()).toList(),
      expectedAnchorageIndicator?.toXml(),
      positionInPortID?.toXml(),
      ...cargoAndBallastTankConditionDescription.map((CargoAndBallastTankConditionDescription e) => e.toXml()).toList(),
      ...shipRequirement.map((ShipRequirement e) => e.toXml()).toList(),
      primaryPortCallPurpose?.toXml(),
      ...additionalPortCallPurpose.map((AdditionalPortCallPurpose e) => e.toXml()).toList(),
      requestedArrivalEvent?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'DestinationPortCall',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

