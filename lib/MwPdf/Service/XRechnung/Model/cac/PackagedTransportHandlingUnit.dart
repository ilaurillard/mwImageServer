import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cbc/TransportHandlingUnitTypeCode.dart';
import '../cbc/HandlingCode.dart';
import '../cbc/HandlingInstructions.dart';
import '../cbc/HazardousRiskIndicator.dart';
import '../cbc/TotalGoodsItemQuantity.dart';
import '../cbc/TotalPackageQuantity.dart';
import '../cbc/DamageRemarks.dart';
import '../cbc/ShippingMarks.dart';
import '../cbc/TraceID.dart';
import '../cac/HandlingUnitDespatchLine.dart';
import '../cac/ActualPackage.dart';
import '../cac/ReceivedHandlingUnitReceiptLine.dart';
import '../cac/TransportEquipment.dart';
import '../cac/TransportMeans.dart';
import '../cac/HazardousGoodsTransit.dart';
import '../cac/MeasurementDimension.dart';
import '../cac/MinimumTemperature.dart';
import '../cac/MaximumTemperature.dart';
import '../cac/GoodsItem.dart';
import '../cac/FloorSpaceMeasurementDimension.dart';
import '../cac/PalletSpaceMeasurementDimension.dart';
import '../cac/ShipmentDocumentReference.dart';
import '../cac/Status.dart';
import '../cac/CustomsDeclaration.dart';
import '../cac/ReferencedShipment.dart';
import '../cac/Package.dart';

// A class to describe a uniquely identifiable unit consisting of one or more packages, goods items, or pieces of transport equipment.
class PackagedTransportHandlingUnit {


  // An identifier for this transport handling unit.
  final ID? iD;

  // A code signifying the type of this transport handling unit.
  final TransportHandlingUnitTypeCode? transportHandlingUnitTypeCode;

  // The handling required for this transport handling unit, expressed as a code.
  final HandlingCode? handlingCode;

  // The handling required for this transport handling unit, expressed as text.
  final List<HandlingInstructions> handlingInstructions;

  // An indicator that the materials contained in this transport handling unit are subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  // The total number of goods items in this transport handling unit.
  final TotalGoodsItemQuantity? totalGoodsItemQuantity;

  // The total number of packages in this transport handling unit.
  final TotalPackageQuantity? totalPackageQuantity;

  // Text describing damage associated with this transport handling unit.
  final List<DamageRemarks> damageRemarks;

  // Text describing the marks and numbers on this transport handling unit.
  final List<ShippingMarks> shippingMarks;

  // An identifier for use in tracing this transport handling unit, such as the EPC number used in RFID.
  final TraceID? traceID;

  // A despatch line associated with this transport handling unit.
  final List<HandlingUnitDespatchLine> handlingUnitDespatchLine;

  // A package contained in this transport handling unit.
  final List<ActualPackage> actualPackage;

  // A receipt line associated with this transport handling unit.
  final List<ReceivedHandlingUnitReceiptLine> receivedHandlingUnitReceiptLine;

  // A piece of transport equipment associated with this transport handling unit.
  final List<TransportEquipment> transportEquipment;

  // A means of transport associated with this transport handling unit.
  final List<TransportMeans> transportMeans;

  // Transit-related information regarding a type of hazardous goods contained in this transport handling unit.
  final List<HazardousGoodsTransit> hazardousGoodsTransit;

  // A measurable dimension (length, mass, weight, or volume) of this transport handling unit.
  final List<MeasurementDimension> measurementDimension;

  // The minimum required operating temperature of this transport handling unit.
  final MinimumTemperature? minimumTemperature;

  // The maximum allowable operating temperature of this transport handling unit.
  final MaximumTemperature? maximumTemperature;

  // A goods item contained in this transport handling unit.
  final List<GoodsItem> goodsItem;

  // The floor space measurement dimension associated with this transport handling unit.
  final FloorSpaceMeasurementDimension? floorSpaceMeasurementDimension;

  // The pallet space measurement dimension associated to this transport handling unit.
  final PalletSpaceMeasurementDimension? palletSpaceMeasurementDimension;

  // A reference to a shipping document associated with this transport handling unit.
  final List<ShipmentDocumentReference> shipmentDocumentReference;

  // The status of this transport handling unit.
  final List<Status> status;

  // Describes identifiers or references relating to customs procedures.
  final List<CustomsDeclaration> customsDeclaration;

  // A shipment associated with this transport handling unit.
  final List<ReferencedShipment> referencedShipment;

  // A package contained in this transport handling unit.
  final List<Package> package;

  PackagedTransportHandlingUnit ({
    this.iD,
    this.transportHandlingUnitTypeCode,
    this.handlingCode,
    this.handlingInstructions = const [],
    this.hazardousRiskIndicator,
    this.totalGoodsItemQuantity,
    this.totalPackageQuantity,
    this.damageRemarks = const [],
    this.shippingMarks = const [],
    this.traceID,
    this.handlingUnitDespatchLine = const [],
    this.actualPackage = const [],
    this.receivedHandlingUnitReceiptLine = const [],
    this.transportEquipment = const [],
    this.transportMeans = const [],
    this.hazardousGoodsTransit = const [],
    this.measurementDimension = const [],
    this.minimumTemperature,
    this.maximumTemperature,
    this.goodsItem = const [],
    this.floorSpaceMeasurementDimension,
    this.palletSpaceMeasurementDimension,
    this.shipmentDocumentReference = const [],
    this.status = const [],
    this.customsDeclaration = const [],
    this.referencedShipment = const [],
    this.package = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'transportHandlingUnitTypeCode': transportHandlingUnitTypeCode?.toJson(),
     'handlingCode': handlingCode?.toJson(),
     'handlingInstructions': handlingInstructions.map((e) => e.toJson()).toList(),
     'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
     'totalGoodsItemQuantity': totalGoodsItemQuantity?.toJson(),
     'totalPackageQuantity': totalPackageQuantity?.toJson(),
     'damageRemarks': damageRemarks.map((e) => e.toJson()).toList(),
     'shippingMarks': shippingMarks.map((e) => e.toJson()).toList(),
     'traceID': traceID?.toJson(),
     'handlingUnitDespatchLine': handlingUnitDespatchLine.map((e) => e.toJson()).toList(),
     'actualPackage': actualPackage.map((e) => e.toJson()).toList(),
     'receivedHandlingUnitReceiptLine': receivedHandlingUnitReceiptLine.map((e) => e.toJson()).toList(),
     'transportEquipment': transportEquipment.map((e) => e.toJson()).toList(),
     'transportMeans': transportMeans.map((e) => e.toJson()).toList(),
     'hazardousGoodsTransit': hazardousGoodsTransit.map((e) => e.toJson()).toList(),
     'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
     'minimumTemperature': minimumTemperature?.toJson(),
     'maximumTemperature': maximumTemperature?.toJson(),
     'goodsItem': goodsItem.map((e) => e.toJson()).toList(),
     'floorSpaceMeasurementDimension': floorSpaceMeasurementDimension?.toJson(),
     'palletSpaceMeasurementDimension': palletSpaceMeasurementDimension?.toJson(),
     'shipmentDocumentReference': shipmentDocumentReference.map((e) => e.toJson()).toList(),
     'status': status.map((e) => e.toJson()).toList(),
     'customsDeclaration': customsDeclaration.map((e) => e.toJson()).toList(),
     'referencedShipment': referencedShipment.map((e) => e.toJson()).toList(),
     'package': package.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  PackagedTransportHandlingUnit fromJson(Map<String, dynamic> json) {
    return PackagedTransportHandlingUnit (
    );
  }

}

