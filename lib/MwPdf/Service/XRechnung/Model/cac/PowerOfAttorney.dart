import '../cac/ID.dart';
import '../cac/IssueDate.dart';
import '../cac/IssueTime.dart';
import '../cac/Description.dart';
import '../cac/NotaryParty.dart';
import '../cac/AgentParty.dart';
import '../cac/WitnessParty.dart';
import '../cac/MandateDocumentReference.dart';

// A class to describe a power of attorney.
class PowerOfAttorney {


  // The party who acts as an agent or fiduciary for the principal and who holds this power of attorney on behalf of the principal.
  final AgentParty agentParty;

  // An identifier for this power of attorney.
  final ID? iD;

  // The date on which this power of attorney was issued.
  final IssueDate? issueDate;

  // The time at which this power of attorney was issued.
  final IssueTime? issueTime;

  // Text describing this power of attorney.
  final List<Description> description;

  // The party notarizing this power of attorney.
  final NotaryParty? notaryParty;

  // An association to a WitnessParty.
  final List<WitnessParty> witnessParty;

  // A reference to a mandate associated with this power of attorney.
  final List<MandateDocumentReference> mandateDocumentReference;

  PowerOfAttorney ({
    required this.agentParty,
    this.iD,
    this.issueDate,
    this.issueTime,
    this.description = const [],
    this.notaryParty,
    this.witnessParty = const [],
    this.mandateDocumentReference = const [],
  });
}

