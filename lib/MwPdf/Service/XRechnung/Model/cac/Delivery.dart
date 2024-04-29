import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
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

// A class to describe a delivery.
class Delivery {


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

  Delivery ({
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
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Delivery? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Delivery (
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
    );
  }

  static Delivery? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return Delivery (
      iD: null,
      quantity: null,
      minimumQuantity: null,
      maximumQuantity: null,
      actualDeliveryDate: null,
      actualDeliveryTime: null,
      latestDeliveryDate: null,
      latestDeliveryTime: null,
      releaseID: null,
      trackingID: null,
      deliveryAddress: null,
      deliveryLocation: null,
      alternativeDeliveryLocation: null,
      requestedDeliveryPeriod: null,
      promisedDeliveryPeriod: null,
      estimatedDeliveryPeriod: null,
      carrierParty: null,
      deliveryParty: null,
      notifyParty: null,
      despatch: null,
      deliveryTerms: null,
      minimumDeliveryUnit: null,
      maximumDeliveryUnit: null,
      shipment: null,
    );
  }

}

