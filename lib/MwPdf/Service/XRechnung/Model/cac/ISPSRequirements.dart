import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ValidISSCIndicator.dart';
import '../cbc/ISSCAbsenceReason.dart';
import '../cbc/ISSCExpiryDate.dart';
import '../cbc/SSPOnBoardIndicator.dart';
import '../cbc/SSPSecurityMeasuresAppliedIndicator.dart';
import '../cbc/CurrentOperatingSecurityLevelCode.dart';
import '../cbc/AdditionalMattersDescription.dart';
import '../cac/AdditionalSecurityMeasure.dart';
import '../cac/PortCallRecord.dart';
import '../cac/ShipToShipActivityRecord.dart';
import '../cac/ReportLocation.dart';
import '../cac/ISSCIssuerParty.dart';
import '../cac/SecurityOfficerPerson.dart';

// A class to describe a set of ISPS Requirements.
class ISPSRequirements {


  // An identifier for these ISPS requirements.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An indicator of whether the International Ship Security Certificate (ISSC) is valid (true) or not (false).
  final ValidISSCIndicator? validISSCIndicator;

  // A text describing the reason if not having a International Ship Security Certificate (ISSC).
  final List<ISSCAbsenceReason> iSSCAbsenceReason;

  // The expiration date of the International Ship Security Certificate (ISSC).
  final ISSCExpiryDate? iSSCExpiryDate;

  // An indicator of whether the vessel has a Ship Security Plan (SSP) on board (true) or not (false).
  final SSPOnBoardIndicator? sSPOnBoardIndicator;

  // An indication of whether the Ship Security Plan (SSP) meassures are applied (true) or not (false).
  final SSPSecurityMeasuresAppliedIndicator? sSPSecurityMeasuresAppliedIndicator;

  // A code describing the current operating security level.
  final CurrentOperatingSecurityLevelCode? currentOperatingSecurityLevelCode;

  // A textual description of any addidtional matters concerning these ISPS requirements.
  final List<AdditionalMattersDescription> additionalMattersDescription;

  // Security measures for these ISPS requirements in addition to those in the ship security plan, such as special measures taken in response to unforeseen events.
  final List<AdditionalSecurityMeasure> additionalSecurityMeasure;

  // The port call records for these ISPS requirements.
  final List<PortCallRecord> portCallRecord;

  // The recordded ship to ship activities for these ISPS requirements.
  final List<ShipToShipActivityRecord> shipToShipActivityRecord;

  // The location where these ISPC requirements are reported.
  final ReportLocation? reportLocation;

  // The party issuing the International Ship Security Cetificate (ISSC).
  final ISSCIssuerParty? iSSCIssuerParty;

  // The security officer reponsible for these ISPC requirements.
  final SecurityOfficerPerson? securityOfficerPerson;

  ISPSRequirements ({
    required this.iD,
    this.uBLExtensions,
    this.validISSCIndicator,
    this.iSSCAbsenceReason = const [],
    this.iSSCExpiryDate,
    this.sSPOnBoardIndicator,
    this.sSPSecurityMeasuresAppliedIndicator,
    this.currentOperatingSecurityLevelCode,
    this.additionalMattersDescription = const [],
    this.additionalSecurityMeasure = const [],
    this.portCallRecord = const [],
    this.shipToShipActivityRecord = const [],
    this.reportLocation,
    this.iSSCIssuerParty,
    this.securityOfficerPerson,
  });

  static ISPSRequirements? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ISPSRequirements (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      validISSCIndicator: ValidISSCIndicator.fromJson(json['validISSCIndicator'] as Map<String, dynamic>?),
      iSSCAbsenceReason: (json['iSSCAbsenceReason'] as List? ?? []).map((dynamic d) => ISSCAbsenceReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      iSSCExpiryDate: ISSCExpiryDate.fromJson(json['iSSCExpiryDate'] as Map<String, dynamic>?),
      sSPOnBoardIndicator: SSPOnBoardIndicator.fromJson(json['sSPOnBoardIndicator'] as Map<String, dynamic>?),
      sSPSecurityMeasuresAppliedIndicator: SSPSecurityMeasuresAppliedIndicator.fromJson(json['sSPSecurityMeasuresAppliedIndicator'] as Map<String, dynamic>?),
      currentOperatingSecurityLevelCode: CurrentOperatingSecurityLevelCode.fromJson(json['currentOperatingSecurityLevelCode'] as Map<String, dynamic>?),
      additionalMattersDescription: (json['additionalMattersDescription'] as List? ?? []).map((dynamic d) => AdditionalMattersDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      additionalSecurityMeasure: (json['additionalSecurityMeasure'] as List? ?? []).map((dynamic d) => AdditionalSecurityMeasure.fromJson(d as Map<String, dynamic>?)!).toList(),
      portCallRecord: (json['portCallRecord'] as List? ?? []).map((dynamic d) => PortCallRecord.fromJson(d as Map<String, dynamic>?)!).toList(),
      shipToShipActivityRecord: (json['shipToShipActivityRecord'] as List? ?? []).map((dynamic d) => ShipToShipActivityRecord.fromJson(d as Map<String, dynamic>?)!).toList(),
      reportLocation: ReportLocation.fromJson(json['reportLocation'] as Map<String, dynamic>?),
      iSSCIssuerParty: ISSCIssuerParty.fromJson(json['iSSCIssuerParty'] as Map<String, dynamic>?),
      securityOfficerPerson: SecurityOfficerPerson.fromJson(json['securityOfficerPerson'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'validISSCIndicator': validISSCIndicator?.toJson(),
      'iSSCAbsenceReason': iSSCAbsenceReason.map((e) => e.toJson()).toList(),
      'iSSCExpiryDate': iSSCExpiryDate?.toJson(),
      'sSPOnBoardIndicator': sSPOnBoardIndicator?.toJson(),
      'sSPSecurityMeasuresAppliedIndicator': sSPSecurityMeasuresAppliedIndicator?.toJson(),
      'currentOperatingSecurityLevelCode': currentOperatingSecurityLevelCode?.toJson(),
      'additionalMattersDescription': additionalMattersDescription.map((e) => e.toJson()).toList(),
      'additionalSecurityMeasure': additionalSecurityMeasure.map((e) => e.toJson()).toList(),
      'portCallRecord': portCallRecord.map((e) => e.toJson()).toList(),
      'shipToShipActivityRecord': shipToShipActivityRecord.map((e) => e.toJson()).toList(),
      'reportLocation': reportLocation?.toJson(),
      'iSSCIssuerParty': iSSCIssuerParty?.toJson(),
      'securityOfficerPerson': securityOfficerPerson?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ISPSRequirements? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ISPSRequirements (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      validISSCIndicator: ValidISSCIndicator.fromXml(xml.findElements('cbc:ValidISSCIndicator').singleOrNull),
      iSSCAbsenceReason: xml.findElements('cbc:ISSCAbsenceReason').map((XmlElement e) => ISSCAbsenceReason.fromXml(e)!).toList(),
      iSSCExpiryDate: ISSCExpiryDate.fromXml(xml.findElements('cbc:ISSCExpiryDate').singleOrNull),
      sSPOnBoardIndicator: SSPOnBoardIndicator.fromXml(xml.findElements('cbc:SSPOnBoardIndicator').singleOrNull),
      sSPSecurityMeasuresAppliedIndicator: SSPSecurityMeasuresAppliedIndicator.fromXml(xml.findElements('cbc:SSPSecurityMeasuresAppliedIndicator').singleOrNull),
      currentOperatingSecurityLevelCode: CurrentOperatingSecurityLevelCode.fromXml(xml.findElements('cbc:CurrentOperatingSecurityLevelCode').singleOrNull),
      additionalMattersDescription: xml.findElements('cbc:AdditionalMattersDescription').map((XmlElement e) => AdditionalMattersDescription.fromXml(e)!).toList(),
      additionalSecurityMeasure: xml.findElements('cac:AdditionalSecurityMeasure').map((XmlElement e) => AdditionalSecurityMeasure.fromXml(e)!).toList(),
      portCallRecord: xml.findElements('cac:PortCallRecord').map((XmlElement e) => PortCallRecord.fromXml(e)!).toList(),
      shipToShipActivityRecord: xml.findElements('cac:ShipToShipActivityRecord').map((XmlElement e) => ShipToShipActivityRecord.fromXml(e)!).toList(),
      reportLocation: ReportLocation.fromXml(xml.findElements('cac:ReportLocation').singleOrNull),
      iSSCIssuerParty: ISSCIssuerParty.fromXml(xml.findElements('cac:ISSCIssuerParty').singleOrNull),
      securityOfficerPerson: SecurityOfficerPerson.fromXml(xml.findElements('cac:SecurityOfficerPerson').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      validISSCIndicator?.toXml(),
      ...iSSCAbsenceReason.map((ISSCAbsenceReason e) => e.toXml()).toList(),
      iSSCExpiryDate?.toXml(),
      sSPOnBoardIndicator?.toXml(),
      sSPSecurityMeasuresAppliedIndicator?.toXml(),
      currentOperatingSecurityLevelCode?.toXml(),
      ...additionalMattersDescription.map((AdditionalMattersDescription e) => e.toXml()).toList(),
      ...additionalSecurityMeasure.map((AdditionalSecurityMeasure e) => e.toXml()).toList(),
      ...portCallRecord.map((PortCallRecord e) => e.toXml()).toList(),
      ...shipToShipActivityRecord.map((ShipToShipActivityRecord e) => e.toXml()).toList(),
      reportLocation?.toXml(),
      iSSCIssuerParty?.toXml(),
      securityOfficerPerson?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ISPSRequirements',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

