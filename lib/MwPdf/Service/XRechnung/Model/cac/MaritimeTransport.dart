import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/VesselID.dart';
import '../cbc/VesselName.dart';
import '../cbc/RadioCallSignID.dart';
import '../cbc/MMSIRegistrationID.dart';
import '../cbc/ShipsRequirements.dart';
import '../cbc/GrossTonnageMeasure.dart';
import '../cbc/NetTonnageMeasure.dart';
import '../cbc/SegregatedBallastMeasure.dart';
import '../cbc/ShipConfigurationCode.dart';
import '../cbc/INFShipClassCode.dart';
import '../cbc/AntennaLocus.dart';
import '../cac/RegistryCertificateDocumentReference.dart';
import '../cac/RegistryPortLocation.dart';
import '../cac/VesselDynamics.dart';

// A class to describe a vessel used for transport by water (including sea, river, and canal).
class MaritimeTransport {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for a specific vessel.
  final VesselID? vesselID;

  // The name of the vessel.
  final VesselName? vesselName;

  // The radio call sign of the vessel.
  final RadioCallSignID? radioCallSignID;

  // A Maritime Mobile Service Identity (MMSI) required for this vessel.
  final MMSIRegistrationID? mMSIRegistrationID;

  // Information about what services a vessel will require when it arrives at a port, such as refueling, maintenance, waste disposal etc.
  final List<ShipsRequirements> shipsRequirements;

  // Gross tonnage is calculated by measuring a ship's volume (from keel to funnel, to the outside of the hull framing) and applying a mathematical formula and is used to determine things such as a ship's manning regulations, safety rules, registration fees and port dues.
  final GrossTonnageMeasure? grossTonnageMeasure;

  // Net tonnage is calculated by measuring a ship's internal volume and applying a mathematical formula and is used to calculate the port duties.
  final NetTonnageMeasure? netTonnageMeasure;

  // The measure of the segregated ballast of the vessel.
  final SegregatedBallastMeasure? segregatedBallastMeasure;

  // A code specifying the ship configuration.
  final ShipConfigurationCode? shipConfigurationCode;

  // A code specifying the irradiated nuclear fuel (INF) ship class.
  final INFShipClassCode? iNFShipClassCode;

  // The locus or exact location of the antenna on the vessel
  final AntennaLocus? antennaLocus;

  // The certificate issued to the ship by the ships registry in a given flag state.
  final RegistryCertificateDocumentReference? registryCertificateDocumentReference;

  // The port in which a vessel is registered or permanently based.
  final RegistryPortLocation? registryPortLocation;

  // The vessel dynamics for this maritime transport.
  final VesselDynamics? vesselDynamics;

  MaritimeTransport ({
    this.uBLExtensions,
    this.vesselID,
    this.vesselName,
    this.radioCallSignID,
    this.mMSIRegistrationID,
    this.shipsRequirements = const [],
    this.grossTonnageMeasure,
    this.netTonnageMeasure,
    this.segregatedBallastMeasure,
    this.shipConfigurationCode,
    this.iNFShipClassCode,
    this.antennaLocus,
    this.registryCertificateDocumentReference,
    this.registryPortLocation,
    this.vesselDynamics,
  });

  static MaritimeTransport? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return MaritimeTransport (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      vesselID: VesselID.fromJson(json['vesselID'] as Map<String, dynamic>?),
      vesselName: VesselName.fromJson(json['vesselName'] as Map<String, dynamic>?),
      radioCallSignID: RadioCallSignID.fromJson(json['radioCallSignID'] as Map<String, dynamic>?),
      mMSIRegistrationID: MMSIRegistrationID.fromJson(json['mMSIRegistrationID'] as Map<String, dynamic>?),
      shipsRequirements: (json['shipsRequirements'] as List? ?? []).map((dynamic d) => ShipsRequirements.fromJson(d as Map<String, dynamic>?)!).toList(),
      grossTonnageMeasure: GrossTonnageMeasure.fromJson(json['grossTonnageMeasure'] as Map<String, dynamic>?),
      netTonnageMeasure: NetTonnageMeasure.fromJson(json['netTonnageMeasure'] as Map<String, dynamic>?),
      segregatedBallastMeasure: SegregatedBallastMeasure.fromJson(json['segregatedBallastMeasure'] as Map<String, dynamic>?),
      shipConfigurationCode: ShipConfigurationCode.fromJson(json['shipConfigurationCode'] as Map<String, dynamic>?),
      iNFShipClassCode: INFShipClassCode.fromJson(json['iNFShipClassCode'] as Map<String, dynamic>?),
      antennaLocus: AntennaLocus.fromJson(json['antennaLocus'] as Map<String, dynamic>?),
      registryCertificateDocumentReference: RegistryCertificateDocumentReference.fromJson(json['registryCertificateDocumentReference'] as Map<String, dynamic>?),
      registryPortLocation: RegistryPortLocation.fromJson(json['registryPortLocation'] as Map<String, dynamic>?),
      vesselDynamics: VesselDynamics.fromJson(json['vesselDynamics'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'vesselID': vesselID?.toJson(),
      'vesselName': vesselName?.toJson(),
      'radioCallSignID': radioCallSignID?.toJson(),
      'mMSIRegistrationID': mMSIRegistrationID?.toJson(),
      'shipsRequirements': shipsRequirements.map((e) => e.toJson()).toList(),
      'grossTonnageMeasure': grossTonnageMeasure?.toJson(),
      'netTonnageMeasure': netTonnageMeasure?.toJson(),
      'segregatedBallastMeasure': segregatedBallastMeasure?.toJson(),
      'shipConfigurationCode': shipConfigurationCode?.toJson(),
      'iNFShipClassCode': iNFShipClassCode?.toJson(),
      'antennaLocus': antennaLocus?.toJson(),
      'registryCertificateDocumentReference': registryCertificateDocumentReference?.toJson(),
      'registryPortLocation': registryPortLocation?.toJson(),
      'vesselDynamics': vesselDynamics?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static MaritimeTransport? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return MaritimeTransport (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      vesselID: VesselID.fromXml(xml.findElements('cbc:VesselID').singleOrNull),
      vesselName: VesselName.fromXml(xml.findElements('cbc:VesselName').singleOrNull),
      radioCallSignID: RadioCallSignID.fromXml(xml.findElements('cbc:RadioCallSignID').singleOrNull),
      mMSIRegistrationID: MMSIRegistrationID.fromXml(xml.findElements('cbc:MMSIRegistrationID').singleOrNull),
      shipsRequirements: xml.findElements('cbc:ShipsRequirements').map((XmlElement e) => ShipsRequirements.fromXml(e)!).toList(),
      grossTonnageMeasure: GrossTonnageMeasure.fromXml(xml.findElements('cbc:GrossTonnageMeasure').singleOrNull),
      netTonnageMeasure: NetTonnageMeasure.fromXml(xml.findElements('cbc:NetTonnageMeasure').singleOrNull),
      segregatedBallastMeasure: SegregatedBallastMeasure.fromXml(xml.findElements('cbc:SegregatedBallastMeasure').singleOrNull),
      shipConfigurationCode: ShipConfigurationCode.fromXml(xml.findElements('cbc:ShipConfigurationCode').singleOrNull),
      iNFShipClassCode: INFShipClassCode.fromXml(xml.findElements('cbc:INFShipClassCode').singleOrNull),
      antennaLocus: AntennaLocus.fromXml(xml.findElements('cbc:AntennaLocus').singleOrNull),
      registryCertificateDocumentReference: RegistryCertificateDocumentReference.fromXml(xml.findElements('cac:RegistryCertificateDocumentReference').singleOrNull),
      registryPortLocation: RegistryPortLocation.fromXml(xml.findElements('cac:RegistryPortLocation').singleOrNull),
      vesselDynamics: VesselDynamics.fromXml(xml.findElements('cac:VesselDynamics').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      vesselID?.toXml(),
      vesselName?.toXml(),
      radioCallSignID?.toXml(),
      mMSIRegistrationID?.toXml(),
      ...shipsRequirements.map((ShipsRequirements e) => e.toXml()).toList(),
      grossTonnageMeasure?.toXml(),
      netTonnageMeasure?.toXml(),
      segregatedBallastMeasure?.toXml(),
      shipConfigurationCode?.toXml(),
      iNFShipClassCode?.toXml(),
      antennaLocus?.toXml(),
      registryCertificateDocumentReference?.toXml(),
      registryPortLocation?.toXml(),
      vesselDynamics?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'MaritimeTransport',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

