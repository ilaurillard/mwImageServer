import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/ExtendedID.dart';
import '../cbc/BarcodeSymbologyID.dart';
import '../cac/PhysicalAttribute.dart';
import '../cac/MeasurementDimension.dart';
import '../cac/IssuerParty.dart';

// A class for assigning identifying information to an item.
class SellersItemIdentification {


  // An identifier for the item.
  final ID iD;

  // An extended identifier for the item that identifies the item with specific properties, e.g., Item 123 = Chair / Item 123 Ext 45 = brown chair. Two chairs can have the same item number, but one is brown. The other is white.
  final ExtendedID? extendedID;

  // An identifier for a system of barcodes.
  final BarcodeSymbologyID? barcodeSymbologyID;

  // A physical attribute of the item.
  final List<PhysicalAttribute> physicalAttribute;

  // A measurable dimension (length, mass, weight, or volume) of the item.
  final List<MeasurementDimension> measurementDimension;

  // The party that issued this item identification.
  final IssuerParty? issuerParty;

  SellersItemIdentification ({
    required this.iD,
    this.extendedID,
    this.barcodeSymbologyID,
    this.physicalAttribute = const [],
    this.measurementDimension = const [],
    this.issuerParty,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
      'extendedID': extendedID?.toJson(),
      'barcodeSymbologyID': barcodeSymbologyID?.toJson(),
      'physicalAttribute': physicalAttribute.map((e) => e.toJson()).toList(),
      'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
      'issuerParty': issuerParty?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static SellersItemIdentification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SellersItemIdentification (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      extendedID: ExtendedID.fromJson(json['extendedID'] as Map<String, dynamic>?),
      barcodeSymbologyID: BarcodeSymbologyID.fromJson(json['barcodeSymbologyID'] as Map<String, dynamic>?),
      physicalAttribute: (json['physicalAttribute'] as List? ?? []).map((dynamic d) => PhysicalAttribute.fromJson(d as Map<String, dynamic>?)!).toList(),
      measurementDimension: (json['measurementDimension'] as List? ?? []).map((dynamic d) => MeasurementDimension.fromJson(d as Map<String, dynamic>?)!).toList(),
      issuerParty: IssuerParty.fromJson(json['issuerParty'] as Map<String, dynamic>?),
    );
  }

  static SellersItemIdentification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return SellersItemIdentification (
      iD: null,
      extendedID: null,
      barcodeSymbologyID: null,
      physicalAttribute: null,
      measurementDimension: null,
      issuerParty: null,
    );
  }

}

