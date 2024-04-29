import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';

// A class to define an identifier for a party.
class PartyIdentification {


  // An identifier for the party.
  final ID iD;

  PartyIdentification ({
    required this.iD,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PartyIdentification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PartyIdentification (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
    );
  }

  static PartyIdentification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return PartyIdentification (
      iD: null,
    );
  }

}

