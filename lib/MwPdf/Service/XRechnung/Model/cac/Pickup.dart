import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/ActualPickupDate.dart';
import '../cbc/ActualPickupTime.dart';
import '../cbc/EarliestPickupDate.dart';
import '../cbc/EarliestPickupTime.dart';
import '../cbc/LatestPickupDate.dart';
import '../cbc/LatestPickupTime.dart';
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'actualPickupDate': actualPickupDate?.toJson(),
      'actualPickupTime': actualPickupTime?.toJson(),
      'earliestPickupDate': earliestPickupDate?.toJson(),
      'earliestPickupTime': earliestPickupTime?.toJson(),
      'latestPickupDate': latestPickupDate?.toJson(),
      'latestPickupTime': latestPickupTime?.toJson(),
      'pickupLocation': pickupLocation?.toJson(),
      'pickupParty': pickupParty?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Pickup? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Pickup (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      actualPickupDate: ActualPickupDate.fromJson(json['actualPickupDate'] as Map<String, dynamic>?),
      actualPickupTime: ActualPickupTime.fromJson(json['actualPickupTime'] as Map<String, dynamic>?),
      earliestPickupDate: EarliestPickupDate.fromJson(json['earliestPickupDate'] as Map<String, dynamic>?),
      earliestPickupTime: EarliestPickupTime.fromJson(json['earliestPickupTime'] as Map<String, dynamic>?),
      latestPickupDate: LatestPickupDate.fromJson(json['latestPickupDate'] as Map<String, dynamic>?),
      latestPickupTime: LatestPickupTime.fromJson(json['latestPickupTime'] as Map<String, dynamic>?),
      pickupLocation: PickupLocation.fromJson(json['pickupLocation'] as Map<String, dynamic>?),
      pickupParty: PickupParty.fromJson(json['pickupParty'] as Map<String, dynamic>?),
    );
  }

  static Pickup? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return Pickup (
      iD: null,
      actualPickupDate: null,
      actualPickupTime: null,
      earliestPickupDate: null,
      earliestPickupTime: null,
      latestPickupDate: null,
      latestPickupTime: null,
      pickupLocation: null,
      pickupParty: null,
    );
  }

}

