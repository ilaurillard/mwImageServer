import '../cac/ID.dart';
import '../cac/ExtendedID.dart';
import '../cac/BarcodeSymbologyID.dart';
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
}

