import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cbc/IssueDate.dart';
import '../cbc/IssueTime.dart';
import '../cbc/NominationDate.dart';
import '../cbc/NominationTime.dart';
import '../cbc/ContractTypeCode.dart';
import '../cbc/ContractType.dart';
import '../cbc/Note.dart';
import '../cbc/VersionID.dart';
import '../cbc/Description.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/ContractDocumentReference.dart';
import '../cac/NominationPeriod.dart';
import '../cac/ContractualDelivery.dart';

// A class to describe a contract.
class TransportContract {


  // An identifier for this contract.
  final ID? iD;

  // The date on which this contract was issued.
  final IssueDate? issueDate;

  // The time at which this contract was issued.
  final IssueTime? issueTime;

  // In a transportation contract, the deadline date by which the services referred to in the transport execution plan have to be booked. For example, if this service is a carrier service scheduled for Wednesday 16 February 2011 at 10 a.m. CET, the nomination date might be Tuesday15 February 2011.
  final NominationDate? nominationDate;

  // In a transportation contract, the deadline time by which the services referred to in the transport execution plan have to be booked. For example, if this service is a carrier service scheduled for Wednesday 16 February 2011 at 10 a.m. CET, the nomination date might be Tuesday15 February 2011 and the nomination time 4 p.m. at the latest.
  final NominationTime? nominationTime;

  // The type of this contract, expressed as a code, such as "Cost plus award fee" and "Cost plus fixed fee" from UNCEFACT Contract Type code list.
  final ContractTypeCode? contractTypeCode;

  // The type of this contract, expressed as text, such as "Cost plus award fee" and "Cost plus fixed fee" from UNCEFACT Contract Type code list.
  final ContractType? contractType;

  // Free-form text conveying information that is not contained explicitly in other structures.
  final List<Note> note;

  // An identifier for the current version of this contract.
  final VersionID? versionID;

  // Text describing this contract.
  final List<Description> description;

  // The period during which this contract is valid.
  final ValidityPeriod? validityPeriod;

  // A reference to a contract document.
  final List<ContractDocumentReference> contractDocumentReference;

  // In a transportation contract, the period required to book the services specified in the contract before the services can begin.
  final NominationPeriod? nominationPeriod;

  // In a transportation contract, the delivery of the services required to book the services specified in the contract.
  final ContractualDelivery? contractualDelivery;

  TransportContract ({
    this.iD,
    this.issueDate,
    this.issueTime,
    this.nominationDate,
    this.nominationTime,
    this.contractTypeCode,
    this.contractType,
    this.note = const [],
    this.versionID,
    this.description = const [],
    this.validityPeriod,
    this.contractDocumentReference = const [],
    this.nominationPeriod,
    this.contractualDelivery,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'issueDate': issueDate?.toJson(),
     'issueTime': issueTime?.toJson(),
     'nominationDate': nominationDate?.toJson(),
     'nominationTime': nominationTime?.toJson(),
     'contractTypeCode': contractTypeCode?.toJson(),
     'contractType': contractType?.toJson(),
     'note': note.map((e) => e.toJson()).toList(),
     'versionID': versionID?.toJson(),
     'description': description.map((e) => e.toJson()).toList(),
     'validityPeriod': validityPeriod?.toJson(),
     'contractDocumentReference': contractDocumentReference.map((e) => e.toJson()).toList(),
     'nominationPeriod': nominationPeriod?.toJson(),
     'contractualDelivery': contractualDelivery?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  TransportContract fromJson(Map<String, dynamic> json) {
    return TransportContract (
    );
  }

}

