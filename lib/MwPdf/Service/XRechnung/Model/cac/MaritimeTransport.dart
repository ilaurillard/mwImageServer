import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/VesselID.dart';
import '../cbc/VesselName.dart';
import '../cbc/RadioCallSignID.dart';
import '../cbc/ShipsRequirements.dart';
import '../cbc/GrossTonnageMeasure.dart';
import '../cbc/NetTonnageMeasure.dart';
import '../cac/RegistryCertificateDocumentReference.dart';
import '../cac/RegistryPortLocation.dart';

// A class to describe a vessel used for transport by water (including sea, river, and canal).
class MaritimeTransport {


  // An identifier for a specific vessel.
  final VesselID? vesselID;

  // The name of the vessel.
  final VesselName? vesselName;

  // The radio call sign of the vessel.
  final RadioCallSignID? radioCallSignID;

  // Information about what services a vessel will require when it arrives at a port, such as refueling, maintenance, waste disposal etc.
  final List<ShipsRequirements> shipsRequirements;

  // Gross tonnage is calculated by measuring a ship's volume (from keel to funnel, to the outside of the hull framing) and applying a mathematical formula and is used to determine things such as a ship's manning regulations, safety rules, registration fees and port dues.
  final GrossTonnageMeasure? grossTonnageMeasure;

  // Net tonnage is calculated by measuring a ship's internal volume and applying a mathematical formula and is used to calculate the port duties.
  final NetTonnageMeasure? netTonnageMeasure;

  // The certificate issued to the ship by the ships registry in a given flag state.
  final RegistryCertificateDocumentReference? registryCertificateDocumentReference;

  // The port in which a vessel is registered or permanently based.
  final RegistryPortLocation? registryPortLocation;

  MaritimeTransport ({
    this.vesselID,
    this.vesselName,
    this.radioCallSignID,
    this.shipsRequirements = const [],
    this.grossTonnageMeasure,
    this.netTonnageMeasure,
    this.registryCertificateDocumentReference,
    this.registryPortLocation,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'vesselID': vesselID?.toJson(),
      'vesselName': vesselName?.toJson(),
      'radioCallSignID': radioCallSignID?.toJson(),
      'shipsRequirements': shipsRequirements.map((e) => e.toJson()).toList(),
      'grossTonnageMeasure': grossTonnageMeasure?.toJson(),
      'netTonnageMeasure': netTonnageMeasure?.toJson(),
      'registryCertificateDocumentReference': registryCertificateDocumentReference?.toJson(),
      'registryPortLocation': registryPortLocation?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static MaritimeTransport? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return MaritimeTransport (
      vesselID: VesselID.fromJson(json['vesselID'] as Map<String, dynamic>?),
      vesselName: VesselName.fromJson(json['vesselName'] as Map<String, dynamic>?),
      radioCallSignID: RadioCallSignID.fromJson(json['radioCallSignID'] as Map<String, dynamic>?),
      shipsRequirements: (json['shipsRequirements'] as List? ?? []).map((dynamic d) => ShipsRequirements.fromJson(d as Map<String, dynamic>?)!).toList(),
      grossTonnageMeasure: GrossTonnageMeasure.fromJson(json['grossTonnageMeasure'] as Map<String, dynamic>?),
      netTonnageMeasure: NetTonnageMeasure.fromJson(json['netTonnageMeasure'] as Map<String, dynamic>?),
      registryCertificateDocumentReference: RegistryCertificateDocumentReference.fromJson(json['registryCertificateDocumentReference'] as Map<String, dynamic>?),
      registryPortLocation: RegistryPortLocation.fromJson(json['registryPortLocation'] as Map<String, dynamic>?),
    );
  }

  static MaritimeTransport? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return MaritimeTransport (
      vesselID: null,
      vesselName: null,
      radioCallSignID: null,
      shipsRequirements: null,
      grossTonnageMeasure: null,
      netTonnageMeasure: null,
      registryCertificateDocumentReference: null,
      registryPortLocation: null,
    );
  }

}

