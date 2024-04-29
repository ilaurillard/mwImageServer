import '../cac/PartecipationPercent.dart';
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
}

