import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cac/IssuerParty.dart';

// A class describing identifiers or references relating to customs procedures.
class CustomsDeclaration {


  // An identifier associated with customs related procedures.
  final ID iD;

  // Describes the party issuing the customs declaration.
  final IssuerParty? issuerParty;

  CustomsDeclaration ({
    required this.iD,
    this.issuerParty,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
      'issuerParty': issuerParty?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CustomsDeclaration? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CustomsDeclaration (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      issuerParty: IssuerParty.fromJson(json['issuerParty'] as Map<String, dynamic>?),
    );
  }

  static CustomsDeclaration? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return CustomsDeclaration (
      iD: null,
      issuerParty: null,
    );
  }

}

