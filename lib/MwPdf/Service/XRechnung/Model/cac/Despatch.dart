import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/RequestedDespatchDate.dart';
import '../cbc/RequestedDespatchTime.dart';
import '../cbc/EstimatedDespatchDate.dart';
import '../cbc/EstimatedDespatchTime.dart';
import '../cbc/ActualDespatchDate.dart';
import '../cbc/ActualDespatchTime.dart';
import '../cbc/GuaranteedDespatchDate.dart';
import '../cbc/GuaranteedDespatchTime.dart';
import '../cbc/ReleaseID.dart';
import '../cbc/Instructions.dart';
import '../cac/DespatchAddress.dart';
import '../cac/DespatchLocation.dart';
import '../cac/DespatchParty.dart';
import '../cac/CarrierParty.dart';
import '../cac/NotifyParty.dart';
import '../cac/Contact.dart';
import '../cac/EstimatedDespatchPeriod.dart';
import '../cac/RequestedDespatchPeriod.dart';

// A class to describe the despatching of goods (their pickup for delivery).
class Despatch {


  // An identifier for this despatch event.
  final ID? iD;

  // The despatch (pickup) date requested, normally by the buyer.
  final RequestedDespatchDate? requestedDespatchDate;

  // The despatch (pickup) time requested, normally by the buyer.
  final RequestedDespatchTime? requestedDespatchTime;

  // The estimated despatch (pickup) date.
  final EstimatedDespatchDate? estimatedDespatchDate;

  // The estimated despatch (pickup) time.
  final EstimatedDespatchTime? estimatedDespatchTime;

  // The actual despatch (pickup) date.
  final ActualDespatchDate? actualDespatchDate;

  // The actual despatch (pickup) time.
  final ActualDespatchTime? actualDespatchTime;

  // The date guaranteed for the despatch (pickup).
  final GuaranteedDespatchDate? guaranteedDespatchDate;

  // The time guaranteed for the despatch (pickup).
  final GuaranteedDespatchTime? guaranteedDespatchTime;

  // An identifier for the release of the despatch used as security control or cargo control (pick-up).
  final ReleaseID? releaseID;

  // Text describing any special instructions applying to the despatch (pickup).
  final List<Instructions> instructions;

  // The address of the despatch (pickup).
  final DespatchAddress? despatchAddress;

  // The location of the despatch (pickup).
  final DespatchLocation? despatchLocation;

  // The party despatching the goods.
  final DespatchParty? despatchParty;

  // The party carrying the goods.
  final CarrierParty? carrierParty;

  // A party to be notified of this despatch (pickup).
  final List<NotifyParty> notifyParty;

  // The primary contact for this despatch (pickup).
  final Contact? contact;

  // The period estimated for the despatch (pickup) of goods.
  final EstimatedDespatchPeriod? estimatedDespatchPeriod;

  // The period requested for the despatch (pickup) of goods.
  final RequestedDespatchPeriod? requestedDespatchPeriod;

  Despatch ({
    this.iD,
    this.requestedDespatchDate,
    this.requestedDespatchTime,
    this.estimatedDespatchDate,
    this.estimatedDespatchTime,
    this.actualDespatchDate,
    this.actualDespatchTime,
    this.guaranteedDespatchDate,
    this.guaranteedDespatchTime,
    this.releaseID,
    this.instructions = const [],
    this.despatchAddress,
    this.despatchLocation,
    this.despatchParty,
    this.carrierParty,
    this.notifyParty = const [],
    this.contact,
    this.estimatedDespatchPeriod,
    this.requestedDespatchPeriod,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'requestedDespatchDate': requestedDespatchDate?.toJson(),
     'requestedDespatchTime': requestedDespatchTime?.toJson(),
     'estimatedDespatchDate': estimatedDespatchDate?.toJson(),
     'estimatedDespatchTime': estimatedDespatchTime?.toJson(),
     'actualDespatchDate': actualDespatchDate?.toJson(),
     'actualDespatchTime': actualDespatchTime?.toJson(),
     'guaranteedDespatchDate': guaranteedDespatchDate?.toJson(),
     'guaranteedDespatchTime': guaranteedDespatchTime?.toJson(),
     'releaseID': releaseID?.toJson(),
     'instructions': instructions.map((e) => e.toJson()).toList(),
     'despatchAddress': despatchAddress?.toJson(),
     'despatchLocation': despatchLocation?.toJson(),
     'despatchParty': despatchParty?.toJson(),
     'carrierParty': carrierParty?.toJson(),
     'notifyParty': notifyParty.map((e) => e.toJson()).toList(),
     'contact': contact?.toJson(),
     'estimatedDespatchPeriod': estimatedDespatchPeriod?.toJson(),
     'requestedDespatchPeriod': requestedDespatchPeriod?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

