import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/SealIssuerTypeCode.dart';
import '../cbc/Condition.dart';
import '../cbc/SealStatusCode.dart';
import '../cbc/SealingPartyType.dart';

// A class to describe a device (a transport equipment seal) for securing the doors of a shipping container.
class TransportEquipmentSeal {


  // An identifier for this transport equipment seal.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
    this.uBLExtensions,
    this.sealIssuerTypeCode,
    this.condition,
    this.sealStatusCode,
    this.sealingPartyType,
  });

  static TransportEquipmentSeal? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TransportEquipmentSeal (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      sealIssuerTypeCode: SealIssuerTypeCode.fromJson(json['sealIssuerTypeCode'] as Map<String, dynamic>?),
      condition: Condition.fromJson(json['condition'] as Map<String, dynamic>?),
      sealStatusCode: SealStatusCode.fromJson(json['sealStatusCode'] as Map<String, dynamic>?),
      sealingPartyType: SealingPartyType.fromJson(json['sealingPartyType'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'sealIssuerTypeCode': sealIssuerTypeCode?.toJson(),
      'condition': condition?.toJson(),
      'sealStatusCode': sealStatusCode?.toJson(),
      'sealingPartyType': sealingPartyType?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TransportEquipmentSeal? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TransportEquipmentSeal (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      sealIssuerTypeCode: SealIssuerTypeCode.fromXml(xml.findElements('cbc:SealIssuerTypeCode').singleOrNull),
      condition: Condition.fromXml(xml.findElements('cbc:Condition').singleOrNull),
      sealStatusCode: SealStatusCode.fromXml(xml.findElements('cbc:SealStatusCode').singleOrNull),
      sealingPartyType: SealingPartyType.fromXml(xml.findElements('cbc:SealingPartyType').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      sealIssuerTypeCode?.toXml(),
      condition?.toXml(),
      sealStatusCode?.toXml(),
      sealingPartyType?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'TransportEquipmentSeal',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

