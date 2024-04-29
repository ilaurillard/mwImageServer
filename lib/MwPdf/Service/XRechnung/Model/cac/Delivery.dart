import '../cac/ID.dart';
import '../cac/Quantity.dart';
import '../cac/MinimumQuantity.dart';
import '../cac/MaximumQuantity.dart';
import '../cac/ActualDeliveryDate.dart';
import '../cac/ActualDeliveryTime.dart';
import '../cac/LatestDeliveryDate.dart';
import '../cac/LatestDeliveryTime.dart';
import '../cac/ReleaseID.dart';
import '../cac/TrackingID.dart';
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
}

