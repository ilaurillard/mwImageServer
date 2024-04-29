import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/LotNumberID.dart';
import '../cbc/ExpiryDate.dart';
import '../cac/AdditionalItemProperty.dart';

// A class for defining a lot identifier (the identifier of a set of item instances that would be used in case of a recall of that item).
class LotIdentification {


  // An identifier for the lot.
  final LotNumberID? lotNumberID;

  // The expiry date of the lot.
  final ExpiryDate? expiryDate;

  // An additional property of the lot.
  final List<AdditionalItemProperty> additionalItemProperty;

  LotIdentification ({
    this.lotNumberID,
    this.expiryDate,
    this.additionalItemProperty = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'lotNumberID': lotNumberID?.toJson(),
      'expiryDate': expiryDate?.toJson(),
      'additionalItemProperty': additionalItemProperty.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static LotIdentification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LotIdentification (
      lotNumberID: LotNumberID.fromJson(json['lotNumberID'] as Map<String, dynamic>?),
      expiryDate: ExpiryDate.fromJson(json['expiryDate'] as Map<String, dynamic>?),
      additionalItemProperty: (json['additionalItemProperty'] as List? ?? []).map((dynamic d) => AdditionalItemProperty.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static LotIdentification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return LotIdentification (
      lotNumberID: null,
      expiryDate: null,
      additionalItemProperty: null,
    );
  }

}

