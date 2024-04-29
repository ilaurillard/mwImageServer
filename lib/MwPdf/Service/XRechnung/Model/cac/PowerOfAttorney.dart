import 'dart:convert';
import '../../Etc/Util.dart';
import '../cac/AgentParty.dart';
import '../cbc/ID.dart';
import '../cbc/IssueDate.dart';
import '../cbc/IssueTime.dart';
import '../cbc/Description.dart';
import '../cac/NotaryParty.dart';
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'issueDate': issueDate?.toJson(),
     'issueTime': issueTime?.toJson(),
     'description': description.map((e) => e.toJson()).toList(),
     'notaryParty': notaryParty?.toJson(),
     'agentParty': agentParty.toJson(),
     'witnessParty': witnessParty.map((e) => e.toJson()).toList(),
     'mandateDocumentReference': mandateDocumentReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  PowerOfAttorney fromJson(Map<String, dynamic> json) {
    return PowerOfAttorney (
    );
  }

}

