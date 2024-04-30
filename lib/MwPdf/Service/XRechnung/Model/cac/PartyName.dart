import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Name.dart';
import '../ext/UBLExtensions.dart';

// A class for defining the name of a party.
class PartyName {


  // The name of the party.
  final Name name;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  PartyName ({
    required this.name,
    this.uBLExtensions,
  });

  static PartyName? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PartyName (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'name': name.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PartyName? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PartyName (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'PartyName',
        'cac',
      ),
    );
  }
}

