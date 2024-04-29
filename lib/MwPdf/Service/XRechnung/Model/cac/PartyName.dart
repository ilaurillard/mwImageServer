import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Name.dart';

// A class for defining the name of a party.
class PartyName {


  // The name of the party.
  final Name name;

  PartyName ({
    required this.name,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PartyName? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PartyName (
      name: Name.fromJson(json['name'] as Map<String, dynamic>?)!,
    );
  }

  static PartyName? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return PartyName (
      name: null,
    );
  }

}

