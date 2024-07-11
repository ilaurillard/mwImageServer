// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Quantity.dart';
import '../cbc/MinimumQuantity.dart';
import '../cbc/MaximumQuantity.dart';
import '../cbc/ActualDeliveryDate.dart';
import '../cbc/ActualDeliveryTime.dart';
import '../cbc/LatestDeliveryDate.dart';
import '../cbc/LatestDeliveryTime.dart';
import '../cbc/ReleaseID.dart';
import '../cbc/TrackingID.dart';
import '../cac/DeliveryAddress.dart';
import '../cac/DeliveryLocation.dart';
import '../cac/AlternativeDeliveryLocation.dart';
import '../cac/RequestedDeliveryPeriod.dart';
import '../cac/PromisedDeliveryPeriod.dart';
import '../cac/EstimatedDeliveryPeriod.dart';
import '../cac/CarrierParty.dart';
import '../cac/DeliveryParty.dart';
import '../cac/NotifyParty.dart';
import '../cac/Despatch.dart';
import '../cac/DeliveryTerms.dart';
import '../cac/MinimumDeliveryUnit.dart';
import '../cac/MaximumDeliveryUnit.dart';
import '../cac/Shipment.dart';
import '../cac/FuelConsumption.dart';

// A class to describe a delivery.
class ContractualDelivery {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this delivery.
  final ID? iD;

  // The quantity of items, child consignments, shipments in this delivery.
  final Quantity? quantity;

  // The minimum quantity of items, child consignments, shipments in this delivery.
  final MinimumQuantity? minimumQuantity;

  // The maximum quantity of items, child consignments, shipments in this delivery.
  final MaximumQuantity? maximumQuantity;

  // The actual date of delivery.
  final ActualDeliveryDate? actualDeliveryDate;

  // The actual time of delivery.
  final ActualDeliveryTime? actualDeliveryTime;

  // The latest date of delivery allowed by the buyer.
  final LatestDeliveryDate? latestDeliveryDate;

  // The latest time of delivery allowed by the buyer.
  final LatestDeliveryTime? latestDeliveryTime;

  // An identifier used for approval of access to delivery locations (e.g., port terminals).
  final ReleaseID? releaseID;

  // The delivery Tracking ID (for transport tracking).
  final TrackingID? trackingID;

  // The delivery address.
  final DeliveryAddress? deliveryAddress;

  // The delivery location.
  final DeliveryLocation? deliveryLocation;

  // An alternative delivery location.
  final AlternativeDeliveryLocation? alternativeDeliveryLocation;

  // The period requested for delivery.
  final RequestedDeliveryPeriod? requestedDeliveryPeriod;

  // The period promised for delivery.
  final PromisedDeliveryPeriod? promisedDeliveryPeriod;

  // The period estimated for delivery.
  final EstimatedDeliveryPeriod? estimatedDeliveryPeriod;

  // The party responsible for delivering the goods.
  final CarrierParty? carrierParty;

  // The party to whom the goods are delivered.
  final DeliveryParty? deliveryParty;

  // A party to be notified of this delivery.
  final List<NotifyParty> notifyParty;

  // The despatch (pickup) associated with this delivery.
  final Despatch? despatch;

  // Terms and conditions relating to the delivery.
  final List<DeliveryTerms> deliveryTerms;

  // The minimum delivery unit for this delivery.
  final MinimumDeliveryUnit? minimumDeliveryUnit;

  // The maximum delivery unit for this delivery.
  final MaximumDeliveryUnit? maximumDeliveryUnit;

  // The shipment being delivered.
  final Shipment? shipment;

  // One or more fuel consumptions of this delivery.
  final List<FuelConsumption> fuelConsumption;

  ContractualDelivery ({
    this.uBLExtensions,
    this.iD,
    this.quantity,
    this.minimumQuantity,
    this.maximumQuantity,
    this.actualDeliveryDate,
    this.actualDeliveryTime,
    this.latestDeliveryDate,
    this.latestDeliveryTime,
    this.releaseID,
    this.trackingID,
    this.deliveryAddress,
    this.deliveryLocation,
    this.alternativeDeliveryLocation,
    this.requestedDeliveryPeriod,
    this.promisedDeliveryPeriod,
    this.estimatedDeliveryPeriod,
    this.carrierParty,
    this.deliveryParty,
    this.notifyParty = const [],
    this.despatch,
    this.deliveryTerms = const [],
    this.minimumDeliveryUnit,
    this.maximumDeliveryUnit,
    this.shipment,
    this.fuelConsumption = const [],
  });

  static ContractualDelivery? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ContractualDelivery (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      quantity: Quantity.fromJson(json['quantity'] as Map<String, dynamic>?),
      minimumQuantity: MinimumQuantity.fromJson(json['minimumQuantity'] as Map<String, dynamic>?),
      maximumQuantity: MaximumQuantity.fromJson(json['maximumQuantity'] as Map<String, dynamic>?),
      actualDeliveryDate: ActualDeliveryDate.fromJson(json['actualDeliveryDate'] as Map<String, dynamic>?),
      actualDeliveryTime: ActualDeliveryTime.fromJson(json['actualDeliveryTime'] as Map<String, dynamic>?),
      latestDeliveryDate: LatestDeliveryDate.fromJson(json['latestDeliveryDate'] as Map<String, dynamic>?),
      latestDeliveryTime: LatestDeliveryTime.fromJson(json['latestDeliveryTime'] as Map<String, dynamic>?),
      releaseID: ReleaseID.fromJson(json['releaseID'] as Map<String, dynamic>?),
      trackingID: TrackingID.fromJson(json['trackingID'] as Map<String, dynamic>?),
      deliveryAddress: DeliveryAddress.fromJson(json['deliveryAddress'] as Map<String, dynamic>?),
      deliveryLocation: DeliveryLocation.fromJson(json['deliveryLocation'] as Map<String, dynamic>?),
      alternativeDeliveryLocation: AlternativeDeliveryLocation.fromJson(json['alternativeDeliveryLocation'] as Map<String, dynamic>?),
      requestedDeliveryPeriod: RequestedDeliveryPeriod.fromJson(json['requestedDeliveryPeriod'] as Map<String, dynamic>?),
      promisedDeliveryPeriod: PromisedDeliveryPeriod.fromJson(json['promisedDeliveryPeriod'] as Map<String, dynamic>?),
      estimatedDeliveryPeriod: EstimatedDeliveryPeriod.fromJson(json['estimatedDeliveryPeriod'] as Map<String, dynamic>?),
      carrierParty: CarrierParty.fromJson(json['carrierParty'] as Map<String, dynamic>?),
      deliveryParty: DeliveryParty.fromJson(json['deliveryParty'] as Map<String, dynamic>?),
      notifyParty: (json['notifyParty'] as List? ?? []).map((dynamic d) => NotifyParty.fromJson(d as Map<String, dynamic>?)!).toList(),
      despatch: Despatch.fromJson(json['despatch'] as Map<String, dynamic>?),
      deliveryTerms: (json['deliveryTerms'] as List? ?? []).map((dynamic d) => DeliveryTerms.fromJson(d as Map<String, dynamic>?)!).toList(),
      minimumDeliveryUnit: MinimumDeliveryUnit.fromJson(json['minimumDeliveryUnit'] as Map<String, dynamic>?),
      maximumDeliveryUnit: MaximumDeliveryUnit.fromJson(json['maximumDeliveryUnit'] as Map<String, dynamic>?),
      shipment: Shipment.fromJson(json['shipment'] as Map<String, dynamic>?),
      fuelConsumption: (json['fuelConsumption'] as List? ?? []).map((dynamic d) => FuelConsumption.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'quantity': quantity?.toJson(),
      'minimumQuantity': minimumQuantity?.toJson(),
      'maximumQuantity': maximumQuantity?.toJson(),
      'actualDeliveryDate': actualDeliveryDate?.toJson(),
      'actualDeliveryTime': actualDeliveryTime?.toJson(),
      'latestDeliveryDate': latestDeliveryDate?.toJson(),
      'latestDeliveryTime': latestDeliveryTime?.toJson(),
      'releaseID': releaseID?.toJson(),
      'trackingID': trackingID?.toJson(),
      'deliveryAddress': deliveryAddress?.toJson(),
      'deliveryLocation': deliveryLocation?.toJson(),
      'alternativeDeliveryLocation': alternativeDeliveryLocation?.toJson(),
      'requestedDeliveryPeriod': requestedDeliveryPeriod?.toJson(),
      'promisedDeliveryPeriod': promisedDeliveryPeriod?.toJson(),
      'estimatedDeliveryPeriod': estimatedDeliveryPeriod?.toJson(),
      'carrierParty': carrierParty?.toJson(),
      'deliveryParty': deliveryParty?.toJson(),
      'notifyParty': notifyParty.map((e) => e.toJson()).toList(),
      'despatch': despatch?.toJson(),
      'deliveryTerms': deliveryTerms.map((e) => e.toJson()).toList(),
      'minimumDeliveryUnit': minimumDeliveryUnit?.toJson(),
      'maximumDeliveryUnit': maximumDeliveryUnit?.toJson(),
      'shipment': shipment?.toJson(),
      'fuelConsumption': fuelConsumption.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ContractualDelivery? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ContractualDelivery (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      quantity: Quantity.fromXml(xml.findElements('cbc:Quantity').singleOrNull),
      minimumQuantity: MinimumQuantity.fromXml(xml.findElements('cbc:MinimumQuantity').singleOrNull),
      maximumQuantity: MaximumQuantity.fromXml(xml.findElements('cbc:MaximumQuantity').singleOrNull),
      actualDeliveryDate: ActualDeliveryDate.fromXml(xml.findElements('cbc:ActualDeliveryDate').singleOrNull),
      actualDeliveryTime: ActualDeliveryTime.fromXml(xml.findElements('cbc:ActualDeliveryTime').singleOrNull),
      latestDeliveryDate: LatestDeliveryDate.fromXml(xml.findElements('cbc:LatestDeliveryDate').singleOrNull),
      latestDeliveryTime: LatestDeliveryTime.fromXml(xml.findElements('cbc:LatestDeliveryTime').singleOrNull),
      releaseID: ReleaseID.fromXml(xml.findElements('cbc:ReleaseID').singleOrNull),
      trackingID: TrackingID.fromXml(xml.findElements('cbc:TrackingID').singleOrNull),
      deliveryAddress: DeliveryAddress.fromXml(xml.findElements('cac:DeliveryAddress').singleOrNull),
      deliveryLocation: DeliveryLocation.fromXml(xml.findElements('cac:DeliveryLocation').singleOrNull),
      alternativeDeliveryLocation: AlternativeDeliveryLocation.fromXml(xml.findElements('cac:AlternativeDeliveryLocation').singleOrNull),
      requestedDeliveryPeriod: RequestedDeliveryPeriod.fromXml(xml.findElements('cac:RequestedDeliveryPeriod').singleOrNull),
      promisedDeliveryPeriod: PromisedDeliveryPeriod.fromXml(xml.findElements('cac:PromisedDeliveryPeriod').singleOrNull),
      estimatedDeliveryPeriod: EstimatedDeliveryPeriod.fromXml(xml.findElements('cac:EstimatedDeliveryPeriod').singleOrNull),
      carrierParty: CarrierParty.fromXml(xml.findElements('cac:CarrierParty').singleOrNull),
      deliveryParty: DeliveryParty.fromXml(xml.findElements('cac:DeliveryParty').singleOrNull),
      notifyParty: xml.findElements('cac:NotifyParty').map((XmlElement e) => NotifyParty.fromXml(e)!).toList(),
      despatch: Despatch.fromXml(xml.findElements('cac:Despatch').singleOrNull),
      deliveryTerms: xml.findElements('cac:DeliveryTerms').map((XmlElement e) => DeliveryTerms.fromXml(e)!).toList(),
      minimumDeliveryUnit: MinimumDeliveryUnit.fromXml(xml.findElements('cac:MinimumDeliveryUnit').singleOrNull),
      maximumDeliveryUnit: MaximumDeliveryUnit.fromXml(xml.findElements('cac:MaximumDeliveryUnit').singleOrNull),
      shipment: Shipment.fromXml(xml.findElements('cac:Shipment').singleOrNull),
      fuelConsumption: xml.findElements('cac:FuelConsumption').map((XmlElement e) => FuelConsumption.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      quantity?.toXml(),
      minimumQuantity?.toXml(),
      maximumQuantity?.toXml(),
      actualDeliveryDate?.toXml(),
      actualDeliveryTime?.toXml(),
      latestDeliveryDate?.toXml(),
      latestDeliveryTime?.toXml(),
      releaseID?.toXml(),
      trackingID?.toXml(),
      deliveryAddress?.toXml(),
      deliveryLocation?.toXml(),
      alternativeDeliveryLocation?.toXml(),
      requestedDeliveryPeriod?.toXml(),
      promisedDeliveryPeriod?.toXml(),
      estimatedDeliveryPeriod?.toXml(),
      carrierParty?.toXml(),
      deliveryParty?.toXml(),
      ...notifyParty.map((NotifyParty e) => e.toXml()),
      despatch?.toXml(),
      ...deliveryTerms.map((DeliveryTerms e) => e.toXml()),
      minimumDeliveryUnit?.toXml(),
      maximumDeliveryUnit?.toXml(),
      shipment?.toXml(),
      ...fuelConsumption.map((FuelConsumption e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ContractualDelivery',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

