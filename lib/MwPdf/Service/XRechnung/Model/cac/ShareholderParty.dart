import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/PartecipationPercent.dart';
import '../cac/Party.dart';

// A class to describe a shareholder party.
class ShareholderParty {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The shareholder participation, expressed as a percentage.
  final PartecipationPercent? partecipationPercent;

  // The shareholder party.
  final Party? party;

  ShareholderParty ({
    this.uBLExtensions,
    this.partecipationPercent,
    this.party,
  });

  static ShareholderParty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ShareholderParty (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      partecipationPercent: PartecipationPercent.fromJson(json['partecipationPercent'] as Map<String, dynamic>?),
      party: Party.fromJson(json['party'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'partecipationPercent': partecipationPercent?.toJson(),
      'party': party?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ShareholderParty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ShareholderParty (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      partecipationPercent: PartecipationPercent.fromXml(xml.findElements('cbc:PartecipationPercent').singleOrNull),
      party: Party.fromXml(xml.findElements('cac:Party').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'ShareholderParty',
        'cac',
      ),
    );
  }
}

