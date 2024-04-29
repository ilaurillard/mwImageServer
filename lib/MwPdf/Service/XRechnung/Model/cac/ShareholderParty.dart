import 'dart:convert';
import '../../Etc/Util.dart';
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


  ShareholderParty fromJson(Map<String, dynamic> json) {
    return ShareholderParty (
    );
  }

}

