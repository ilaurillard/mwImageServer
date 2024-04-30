import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ExtendedID.dart';
import '../cbc/BarcodeSymbologyID.dart';
import '../cbc/IssuerScopeID.dart';
import '../cac/PhysicalAttribute.dart';
import '../cac/MeasurementDimension.dart';
import '../cac/IssuerParty.dart';

// A class for assigning identifying information to an item.
class StandardItemIdentification {


  // An identifier for the item.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An extended identifier for the item that identifies the item with specific properties, e.g., Item 123 = Chair / Item 123 Ext 45 = brown chair. Two chairs can have the same item number, but one is brown. The other is white.
  final ExtendedID? extendedID;

  // An identifier for a system of barcodes.
  final BarcodeSymbologyID? barcodeSymbologyID;

  // A scope within which the issuer has assigned this identifier.
  final IssuerScopeID? issuerScopeID;

  // A physical attribute of the item.
  final List<PhysicalAttribute> physicalAttribute;

  // A measurable dimension (length, mass, weight, or volume) of the item.
  final List<MeasurementDimension> measurementDimension;

  // The party that issued this item identification.
  final IssuerParty? issuerParty;

  StandardItemIdentification ({
    required this.iD,
    this.uBLExtensions,
    this.extendedID,
    this.barcodeSymbologyID,
    this.issuerScopeID,
    this.physicalAttribute = const [],
    this.measurementDimension = const [],
    this.issuerParty,
  });

  static StandardItemIdentification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return StandardItemIdentification (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      extendedID: ExtendedID.fromJson(json['extendedID'] as Map<String, dynamic>?),
      barcodeSymbologyID: BarcodeSymbologyID.fromJson(json['barcodeSymbologyID'] as Map<String, dynamic>?),
      issuerScopeID: IssuerScopeID.fromJson(json['issuerScopeID'] as Map<String, dynamic>?),
      physicalAttribute: (json['physicalAttribute'] as List? ?? []).map((dynamic d) => PhysicalAttribute.fromJson(d as Map<String, dynamic>?)!).toList(),
      measurementDimension: (json['measurementDimension'] as List? ?? []).map((dynamic d) => MeasurementDimension.fromJson(d as Map<String, dynamic>?)!).toList(),
      issuerParty: IssuerParty.fromJson(json['issuerParty'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'extendedID': extendedID?.toJson(),
      'barcodeSymbologyID': barcodeSymbologyID?.toJson(),
      'issuerScopeID': issuerScopeID?.toJson(),
      'physicalAttribute': physicalAttribute.map((e) => e.toJson()).toList(),
      'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
      'issuerParty': issuerParty?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static StandardItemIdentification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return StandardItemIdentification (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      extendedID: ExtendedID.fromXml(xml.findElements('cbc:ExtendedID').singleOrNull),
      barcodeSymbologyID: BarcodeSymbologyID.fromXml(xml.findElements('cbc:BarcodeSymbologyID').singleOrNull),
      issuerScopeID: IssuerScopeID.fromXml(xml.findElements('cbc:IssuerScopeID').singleOrNull),
      physicalAttribute: xml.findElements('cac:PhysicalAttribute').map((XmlElement e) => PhysicalAttribute.fromXml(e)!).toList(),
      measurementDimension: xml.findElements('cac:MeasurementDimension').map((XmlElement e) => MeasurementDimension.fromXml(e)!).toList(),
      issuerParty: IssuerParty.fromXml(xml.findElements('cac:IssuerParty').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'StandardItemIdentification',
        'cac',
      ),
    );
  }
}

