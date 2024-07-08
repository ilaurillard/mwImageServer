import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Quantity.dart';
import '../cbc/ReturnableMaterialIndicator.dart';
import '../cbc/PackageLevelCode.dart';
import '../cbc/PackagingTypeCode.dart';
import '../cbc/PackagingType.dart';
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
import '../cac/Status.dart';

// A class to describe a package.
class ContainingPackage {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // The type of packaging, described as a text.
  final List<PackagingType> packagingType;

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

  // The status of this transport handling unit.
  final List<Status> status;

  ContainingPackage ({
    this.uBLExtensions,
    this.iD,
    this.quantity,
    this.returnableMaterialIndicator,
    this.packageLevelCode,
    this.packagingTypeCode,
    this.packagingType = const [],
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
    this.status = const [],
  });

  static ContainingPackage? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ContainingPackage (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      quantity: Quantity.fromJson(json['quantity'] as Map<String, dynamic>?),
      returnableMaterialIndicator: ReturnableMaterialIndicator.fromJson(json['returnableMaterialIndicator'] as Map<String, dynamic>?),
      packageLevelCode: PackageLevelCode.fromJson(json['packageLevelCode'] as Map<String, dynamic>?),
      packagingTypeCode: PackagingTypeCode.fromJson(json['packagingTypeCode'] as Map<String, dynamic>?),
      packagingType: (json['packagingType'] as List? ?? []).map((dynamic d) => PackagingType.fromJson(d as Map<String, dynamic>?)!).toList(),
      packingMaterial: (json['packingMaterial'] as List? ?? []).map((dynamic d) => PackingMaterial.fromJson(d as Map<String, dynamic>?)!).toList(),
      traceID: TraceID.fromJson(json['traceID'] as Map<String, dynamic>?),
      containedPackage: (json['containedPackage'] as List? ?? []).map((dynamic d) => ContainedPackage.fromJson(d as Map<String, dynamic>?)!).toList(),
      containingTransportEquipment: ContainingTransportEquipment.fromJson(json['containingTransportEquipment'] as Map<String, dynamic>?),
      goodsItem: (json['goodsItem'] as List? ?? []).map((dynamic d) => GoodsItem.fromJson(d as Map<String, dynamic>?)!).toList(),
      measurementDimension: (json['measurementDimension'] as List? ?? []).map((dynamic d) => MeasurementDimension.fromJson(d as Map<String, dynamic>?)!).toList(),
      deliveryUnit: (json['deliveryUnit'] as List? ?? []).map((dynamic d) => DeliveryUnit.fromJson(d as Map<String, dynamic>?)!).toList(),
      delivery: Delivery.fromJson(json['delivery'] as Map<String, dynamic>?),
      pickup: Pickup.fromJson(json['pickup'] as Map<String, dynamic>?),
      despatch: Despatch.fromJson(json['despatch'] as Map<String, dynamic>?),
      status: (json['status'] as List? ?? []).map((dynamic d) => Status.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'quantity': quantity?.toJson(),
      'returnableMaterialIndicator': returnableMaterialIndicator?.toJson(),
      'packageLevelCode': packageLevelCode?.toJson(),
      'packagingTypeCode': packagingTypeCode?.toJson(),
      'packagingType': packagingType.map((e) => e.toJson()).toList(),
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
      'status': status.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ContainingPackage? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ContainingPackage (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      quantity: Quantity.fromXml(xml.findElements('cbc:Quantity').singleOrNull),
      returnableMaterialIndicator: ReturnableMaterialIndicator.fromXml(xml.findElements('cbc:ReturnableMaterialIndicator').singleOrNull),
      packageLevelCode: PackageLevelCode.fromXml(xml.findElements('cbc:PackageLevelCode').singleOrNull),
      packagingTypeCode: PackagingTypeCode.fromXml(xml.findElements('cbc:PackagingTypeCode').singleOrNull),
      packagingType: xml.findElements('cbc:PackagingType').map((XmlElement e) => PackagingType.fromXml(e)!).toList(),
      packingMaterial: xml.findElements('cbc:PackingMaterial').map((XmlElement e) => PackingMaterial.fromXml(e)!).toList(),
      traceID: TraceID.fromXml(xml.findElements('cbc:TraceID').singleOrNull),
      containedPackage: xml.findElements('cac:ContainedPackage').map((XmlElement e) => ContainedPackage.fromXml(e)!).toList(),
      containingTransportEquipment: ContainingTransportEquipment.fromXml(xml.findElements('cac:ContainingTransportEquipment').singleOrNull),
      goodsItem: xml.findElements('cac:GoodsItem').map((XmlElement e) => GoodsItem.fromXml(e)!).toList(),
      measurementDimension: xml.findElements('cac:MeasurementDimension').map((XmlElement e) => MeasurementDimension.fromXml(e)!).toList(),
      deliveryUnit: xml.findElements('cac:DeliveryUnit').map((XmlElement e) => DeliveryUnit.fromXml(e)!).toList(),
      delivery: Delivery.fromXml(xml.findElements('cac:Delivery').singleOrNull),
      pickup: Pickup.fromXml(xml.findElements('cac:Pickup').singleOrNull),
      despatch: Despatch.fromXml(xml.findElements('cac:Despatch').singleOrNull),
      status: xml.findElements('cac:Status').map((XmlElement e) => Status.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      quantity?.toXml(),
      returnableMaterialIndicator?.toXml(),
      packageLevelCode?.toXml(),
      packagingTypeCode?.toXml(),
      ...packagingType.map((PackagingType e) => e.toXml()).toList(),
      ...packingMaterial.map((PackingMaterial e) => e.toXml()).toList(),
      traceID?.toXml(),
      ...containedPackage.map((ContainedPackage e) => e.toXml()).toList(),
      containingTransportEquipment?.toXml(),
      ...goodsItem.map((GoodsItem e) => e.toXml()).toList(),
      ...measurementDimension.map((MeasurementDimension e) => e.toXml()).toList(),
      ...deliveryUnit.map((DeliveryUnit e) => e.toXml()).toList(),
      delivery?.toXml(),
      pickup?.toXml(),
      despatch?.toXml(),
      ...status.map((Status e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ContainingPackage',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

