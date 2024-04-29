import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/ExtendedID.dart';
import '../cbc/BarcodeSymbologyID.dart';
import '../cac/PhysicalAttribute.dart';
import '../cac/MeasurementDimension.dart';
import '../cac/IssuerParty.dart';

// A class for assigning identifying information to an item.
class ManufacturersItemIdentification {


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

  ManufacturersItemIdentification ({
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

}

