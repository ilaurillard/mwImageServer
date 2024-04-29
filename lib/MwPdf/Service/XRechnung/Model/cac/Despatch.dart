import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
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

  static Despatch? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Despatch (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      requestedDespatchDate: RequestedDespatchDate.fromJson(json['requestedDespatchDate'] as Map<String, dynamic>?),
      requestedDespatchTime: RequestedDespatchTime.fromJson(json['requestedDespatchTime'] as Map<String, dynamic>?),
      estimatedDespatchDate: EstimatedDespatchDate.fromJson(json['estimatedDespatchDate'] as Map<String, dynamic>?),
      estimatedDespatchTime: EstimatedDespatchTime.fromJson(json['estimatedDespatchTime'] as Map<String, dynamic>?),
      actualDespatchDate: ActualDespatchDate.fromJson(json['actualDespatchDate'] as Map<String, dynamic>?),
      actualDespatchTime: ActualDespatchTime.fromJson(json['actualDespatchTime'] as Map<String, dynamic>?),
      guaranteedDespatchDate: GuaranteedDespatchDate.fromJson(json['guaranteedDespatchDate'] as Map<String, dynamic>?),
      guaranteedDespatchTime: GuaranteedDespatchTime.fromJson(json['guaranteedDespatchTime'] as Map<String, dynamic>?),
      releaseID: ReleaseID.fromJson(json['releaseID'] as Map<String, dynamic>?),
      instructions: (json['instructions'] as List? ?? []).map((dynamic d) => Instructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      despatchAddress: DespatchAddress.fromJson(json['despatchAddress'] as Map<String, dynamic>?),
      despatchLocation: DespatchLocation.fromJson(json['despatchLocation'] as Map<String, dynamic>?),
      despatchParty: DespatchParty.fromJson(json['despatchParty'] as Map<String, dynamic>?),
      carrierParty: CarrierParty.fromJson(json['carrierParty'] as Map<String, dynamic>?),
      notifyParty: (json['notifyParty'] as List? ?? []).map((dynamic d) => NotifyParty.fromJson(d as Map<String, dynamic>?)!).toList(),
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>?),
      estimatedDespatchPeriod: EstimatedDespatchPeriod.fromJson(json['estimatedDespatchPeriod'] as Map<String, dynamic>?),
      requestedDespatchPeriod: RequestedDespatchPeriod.fromJson(json['requestedDespatchPeriod'] as Map<String, dynamic>?),
    );
  }

  static Despatch? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return Despatch (
      iD: null,
      requestedDespatchDate: null,
      requestedDespatchTime: null,
      estimatedDespatchDate: null,
      estimatedDespatchTime: null,
      actualDespatchDate: null,
      actualDespatchTime: null,
      guaranteedDespatchDate: null,
      guaranteedDespatchTime: null,
      releaseID: null,
      instructions: null,
      despatchAddress: null,
      despatchLocation: null,
      despatchParty: null,
      carrierParty: null,
      notifyParty: null,
      contact: null,
      estimatedDespatchPeriod: null,
      requestedDespatchPeriod: null,
    );
  }

}

