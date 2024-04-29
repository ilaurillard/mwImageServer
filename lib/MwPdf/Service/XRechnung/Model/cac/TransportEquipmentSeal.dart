import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/SealIssuerTypeCode.dart';
import '../cbc/Condition.dart';
import '../cbc/SealStatusCode.dart';
import '../cbc/SealingPartyType.dart';

// A class to describe a device (a transport equipment seal) for securing the doors of a shipping container.
class TransportEquipmentSeal {


  // An identifier for this transport equipment seal.
  final ID iD;

  // A code signifying the type of party that issues and is responsible for this transport equipment seal.
  final SealIssuerTypeCode? sealIssuerTypeCode;

  // The condition of this transport equipment seal.
  final Condition? condition;

  // A code signifying the condition of this transport equipment seal.
  final SealStatusCode? sealStatusCode;

  // The role of the sealing party.
  final SealingPartyType? sealingPartyType;

  TransportEquipmentSeal ({
    required this.iD,
    this.sealIssuerTypeCode,
    this.condition,
    this.sealStatusCode,
    this.sealingPartyType,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
      'sealIssuerTypeCode': sealIssuerTypeCode?.toJson(),
      'condition': condition?.toJson(),
      'sealStatusCode': sealStatusCode?.toJson(),
      'sealingPartyType': sealingPartyType?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TransportEquipmentSeal? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TransportEquipmentSeal (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      sealIssuerTypeCode: SealIssuerTypeCode.fromJson(json['sealIssuerTypeCode'] as Map<String, dynamic>?),
      condition: Condition.fromJson(json['condition'] as Map<String, dynamic>?),
      sealStatusCode: SealStatusCode.fromJson(json['sealStatusCode'] as Map<String, dynamic>?),
      sealingPartyType: SealingPartyType.fromJson(json['sealingPartyType'] as Map<String, dynamic>?),
    );
  }

  static TransportEquipmentSeal? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return TransportEquipmentSeal (
      iD: null,
      sealIssuerTypeCode: null,
      condition: null,
      sealStatusCode: null,
      sealingPartyType: null,
    );
  }

}

