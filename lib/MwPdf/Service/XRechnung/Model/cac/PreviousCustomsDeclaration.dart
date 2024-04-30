import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/ApplicableTerritoryAddress.dart';
import '../cac/Shipment.dart';
import '../cac/CustomsExitOfficeLocation.dart';
import '../cac/IssuerParty.dart';
import '../cac/ConsignorParty.dart';
import '../cac/ConsigneeParty.dart';
import '../cac/FreightForwarderParty.dart';
import '../cac/CustomsParty.dart';
import '../cac/AdditionalDocumentReference.dart';

// A class describing identifiers or references relating to customs procedures.
class PreviousCustomsDeclaration {


  // An identifier associated with customs related procedures.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The period during which this customs declaration is valid
  final ValidityPeriod? validityPeriod;

  // The area or region where this customs declaration applies
  final ApplicableTerritoryAddress? applicableTerritoryAddress;

  // A reference to the shipment of goods being declared
  final Shipment? shipment;

  // The location of the exit office from where the goods will leave or have left the customs territory
  final CustomsExitOfficeLocation? customsExitOfficeLocation;

  // Describes the party issuing the customs declaration.
  final IssuerParty? issuerParty;

  // The party, usually the seller, who is responsible for the consignment
  final ConsignorParty? consignorParty;

  // The party, usually the buyer, who will receive the goods
  final ConsigneeParty? consigneeParty;

  // The freight forwarder or the forwarding agent responsible for the transportation of the goods
  final FreightForwarderParty? freightForwarderParty;

  // The authority responsible for processing this customs declaration
  final CustomsParty? customsParty;

  // A reference to a previous version of this customs declaration
  final PreviousCustomsDeclaration? previousCustomsDeclaration;

  // A reference to additional documents relevant or related to this customs declaration
  final List<AdditionalDocumentReference> additionalDocumentReference;

  PreviousCustomsDeclaration ({
    required this.iD,
    this.uBLExtensions,
    this.validityPeriod,
    this.applicableTerritoryAddress,
    this.shipment,
    this.customsExitOfficeLocation,
    this.issuerParty,
    this.consignorParty,
    this.consigneeParty,
    this.freightForwarderParty,
    this.customsParty,
    this.previousCustomsDeclaration,
    this.additionalDocumentReference = const [],
  });

  static PreviousCustomsDeclaration? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PreviousCustomsDeclaration (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      validityPeriod: ValidityPeriod.fromJson(json['validityPeriod'] as Map<String, dynamic>?),
      applicableTerritoryAddress: ApplicableTerritoryAddress.fromJson(json['applicableTerritoryAddress'] as Map<String, dynamic>?),
      shipment: Shipment.fromJson(json['shipment'] as Map<String, dynamic>?),
      customsExitOfficeLocation: CustomsExitOfficeLocation.fromJson(json['customsExitOfficeLocation'] as Map<String, dynamic>?),
      issuerParty: IssuerParty.fromJson(json['issuerParty'] as Map<String, dynamic>?),
      consignorParty: ConsignorParty.fromJson(json['consignorParty'] as Map<String, dynamic>?),
      consigneeParty: ConsigneeParty.fromJson(json['consigneeParty'] as Map<String, dynamic>?),
      freightForwarderParty: FreightForwarderParty.fromJson(json['freightForwarderParty'] as Map<String, dynamic>?),
      customsParty: CustomsParty.fromJson(json['customsParty'] as Map<String, dynamic>?),
      previousCustomsDeclaration: PreviousCustomsDeclaration.fromJson(json['previousCustomsDeclaration'] as Map<String, dynamic>?),
      additionalDocumentReference: (json['additionalDocumentReference'] as List? ?? []).map((dynamic d) => AdditionalDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'validityPeriod': validityPeriod?.toJson(),
      'applicableTerritoryAddress': applicableTerritoryAddress?.toJson(),
      'shipment': shipment?.toJson(),
      'customsExitOfficeLocation': customsExitOfficeLocation?.toJson(),
      'issuerParty': issuerParty?.toJson(),
      'consignorParty': consignorParty?.toJson(),
      'consigneeParty': consigneeParty?.toJson(),
      'freightForwarderParty': freightForwarderParty?.toJson(),
      'customsParty': customsParty?.toJson(),
      'previousCustomsDeclaration': previousCustomsDeclaration?.toJson(),
      'additionalDocumentReference': additionalDocumentReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PreviousCustomsDeclaration? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PreviousCustomsDeclaration (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      validityPeriod: ValidityPeriod.fromXml(xml.findElements('cac:ValidityPeriod').singleOrNull),
      applicableTerritoryAddress: ApplicableTerritoryAddress.fromXml(xml.findElements('cac:ApplicableTerritoryAddress').singleOrNull),
      shipment: Shipment.fromXml(xml.findElements('cac:Shipment').singleOrNull),
      customsExitOfficeLocation: CustomsExitOfficeLocation.fromXml(xml.findElements('cac:CustomsExitOfficeLocation').singleOrNull),
      issuerParty: IssuerParty.fromXml(xml.findElements('cac:IssuerParty').singleOrNull),
      consignorParty: ConsignorParty.fromXml(xml.findElements('cac:ConsignorParty').singleOrNull),
      consigneeParty: ConsigneeParty.fromXml(xml.findElements('cac:ConsigneeParty').singleOrNull),
      freightForwarderParty: FreightForwarderParty.fromXml(xml.findElements('cac:FreightForwarderParty').singleOrNull),
      customsParty: CustomsParty.fromXml(xml.findElements('cac:CustomsParty').singleOrNull),
      previousCustomsDeclaration: PreviousCustomsDeclaration.fromXml(xml.findElements('cac:PreviousCustomsDeclaration').singleOrNull),
      additionalDocumentReference: xml.findElements('cac:AdditionalDocumentReference').map((XmlElement e) => AdditionalDocumentReference.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'PreviousCustomsDeclaration',
        'cac',
      ),
    );
  }
}

