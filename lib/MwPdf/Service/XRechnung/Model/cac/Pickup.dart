import '../cac/ID.dart';
import '../cac/ActualPickupDate.dart';
import '../cac/ActualPickupTime.dart';
import '../cac/EarliestPickupDate.dart';
import '../cac/EarliestPickupTime.dart';
import '../cac/LatestPickupDate.dart';
import '../cac/LatestPickupTime.dart';
import '../cac/PickupLocation.dart';
import '../cac/PickupParty.dart';

// A class to describe a pickup for delivery.
class Pickup {


  // An identifier for this pickup.
  final ID? iD;

  // The actual pickup date.
  final ActualPickupDate? actualPickupDate;

  // The actual pickup time.
  final ActualPickupTime? actualPickupTime;

  // The earliest pickup date.
  final EarliestPickupDate? earliestPickupDate;

  // The earliest pickup time.
  final EarliestPickupTime? earliestPickupTime;

  // The latest pickup date.
  final LatestPickupDate? latestPickupDate;

  // The latest pickup time.
  final LatestPickupTime? latestPickupTime;

  // The pickup location.
  final PickupLocation? pickupLocation;

  // The party responsible for picking up a delivery.
  final PickupParty? pickupParty;

  Pickup ({
    this.iD,
    this.actualPickupDate,
    this.actualPickupTime,
    this.earliestPickupDate,
    this.earliestPickupTime,
    this.latestPickupDate,
    this.latestPickupTime,
    this.pickupLocation,
    this.pickupParty,
  });
}

