import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/Quantity.dart';
import '../cbc/ReturnableMaterialIndicator.dart';
import '../cbc/PackageLevelCode.dart';
import '../cbc/PackagingTypeCode.dart';
import '../cbc/PackingMaterial.dart';
import '../cbc/TraceID.dart';
import '../cac/ContainedPackage.dart';
import '../cac/ContainingTransportEquipment.dart';
import '../cac/GoodsItem.dart';
import '../cac/MeasurementDimension.dart';
import '../cac/DeliveryUnit.dart';
import '../cac/Delivery.dart';
import '../cac/Pickup.dart';
import '../cac/Despatch.dart';

// A class to describe a package.
class ActualPackage {


  // An identifier for this package.
  final ID? iD;

  // The quantity of items contained in this package.
  final Quantity? quantity;

  // An indicator that the packaging material is returnable (true) or not (false).
  final ReturnableMaterialIndicator? returnableMaterialIndicator;

  // A code signifying a level of packaging.
  final PackageLevelCode? packageLevelCode;

  // A code signifying a type of packaging.
  final PackagingTypeCode? packagingTypeCode;

  // Text describing the packaging material.
  final List<PackingMaterial> packingMaterial;

  // An identifier for use in tracing this package, such as the EPC number used in RFID.
  final TraceID? traceID;

  // A package contained within this package.
  final List<ContainedPackage> containedPackage;

  // The piece of transport equipment containing this package.
  final ContainingTransportEquipment? containingTransportEquipment;

  // A goods item included in this package.
  final List<GoodsItem> goodsItem;

  // A measurable dimension (length, mass, weight, or volume) of this package.
  final List<MeasurementDimension> measurementDimension;

  // A delivery unit within this package.
  final List<DeliveryUnit> deliveryUnit;

  // The delivery of this package.
  final Delivery? delivery;

  // The pickup of this package.
  final Pickup? pickup;

  // The despatch of this package.
  final Despatch? despatch;

  ActualPackage ({
    this.iD,
    this.quantity,
    this.returnableMaterialIndicator,
    this.packageLevelCode,
    this.packagingTypeCode,
    this.packingMaterial = const [],
    this.traceID,
    this.containedPackage = const [],
    this.containingTransportEquipment,
    this.goodsItem = const [],
    this.measurementDimension = const [],
    this.deliveryUnit = const [],
    this.delivery,
    this.pickup,
    this.despatch,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'quantity': quantity?.toJson(),
     'returnableMaterialIndicator': returnableMaterialIndicator?.toJson(),
     'packageLevelCode': packageLevelCode?.toJson(),
     'packagingTypeCode': packagingTypeCode?.toJson(),
     'packingMaterial': packingMaterial.map((e) => e.toJson()).toList(),
     'traceID': traceID?.toJson(),
     'containedPackage': containedPackage.map((e) => e.toJson()).toList(),
     'containingTransportEquipment': containingTransportEquipment?.toJson(),
     'goodsItem': goodsItem.map((e) => e.toJson()).toList(),
     'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
     'deliveryUnit': deliveryUnit.map((e) => e.toJson()).toList(),
     'delivery': delivery?.toJson(),
     'pickup': pickup?.toJson(),
     'despatch': despatch?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

