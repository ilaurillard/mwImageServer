import '../cac/ID.dart';
import '../cac/RequestedDespatchDate.dart';
import '../cac/RequestedDespatchTime.dart';
import '../cac/EstimatedDespatchDate.dart';
import '../cac/EstimatedDespatchTime.dart';
import '../cac/ActualDespatchDate.dart';
import '../cac/ActualDespatchTime.dart';
import '../cac/GuaranteedDespatchDate.dart';
import '../cac/GuaranteedDespatchTime.dart';
import '../cac/ReleaseID.dart';
import '../cac/Instructions.dart';
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
}

