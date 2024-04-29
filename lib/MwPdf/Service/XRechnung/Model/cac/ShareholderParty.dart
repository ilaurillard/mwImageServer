import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/PartecipationPercent.dart';
import '../cac/Party.dart';

// A class to describe a shareholder party.
class ShareholderParty {


  // The shareholder participation, expressed as a percentage.
  final PartecipationPercent? partecipationPercent;

  // The shareholder party.
  final Party? party;

  ShareholderParty ({
    this.partecipationPercent,
    this.party,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'partecipationPercent': partecipationPercent?.toJson(),
      'party': party?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ShareholderParty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ShareholderParty (
      partecipationPercent: PartecipationPercent.fromJson(json['partecipationPercent'] as Map<String, dynamic>?),
      party: Party.fromJson(json['party'] as Map<String, dynamic>?),
    );
  }

  static ShareholderParty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ShareholderParty (
      partecipationPercent: null,
      party: null,
    );
  }

}

