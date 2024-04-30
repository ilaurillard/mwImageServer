import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/IssuerScopeID.dart';
import '../cac/IssuerParty.dart';

// A class for assigning identifying information for a property
class StandardPropertyIdentification {


  // An Identifier for the property.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A scope within which the issuer has assigned this identifier.
  final IssuerScopeID? issuerScopeID;

  // The party that issued this property identifier.
  final IssuerParty? issuerParty;

  StandardPropertyIdentification ({
    required this.iD,
    this.uBLExtensions,
    this.issuerScopeID,
    this.issuerParty,
  });

  static StandardPropertyIdentification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return StandardPropertyIdentification (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      issuerScopeID: IssuerScopeID.fromJson(json['issuerScopeID'] as Map<String, dynamic>?),
      issuerParty: IssuerParty.fromJson(json['issuerParty'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'issuerScopeID': issuerScopeID?.toJson(),
      'issuerParty': issuerParty?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static StandardPropertyIdentification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return StandardPropertyIdentification (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      issuerScopeID: IssuerScopeID.fromXml(xml.findElements('cbc:IssuerScopeID').singleOrNull),
      issuerParty: IssuerParty.fromXml(xml.findElements('cac:IssuerParty').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'StandardPropertyIdentification',
        'cac',
      ),
    );
  }
}

