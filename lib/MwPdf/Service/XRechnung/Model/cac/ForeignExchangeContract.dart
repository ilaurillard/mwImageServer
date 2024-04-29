import '../cac/ID.dart';
import '../cac/IssueDate.dart';
import '../cac/IssueTime.dart';
import '../cac/NominationDate.dart';
import '../cac/NominationTime.dart';
import '../cac/ContractTypeCode.dart';
import '../cac/ContractType.dart';
import '../cac/Note.dart';
import '../cac/VersionID.dart';
import '../cac/Description.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/ContractDocumentReference.dart';
import '../cac/NominationPeriod.dart';
import '../cac/ContractualDelivery.dart';

// A class to describe a contract.
class ForeignExchangeContract {


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

  ForeignExchangeContract ({
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
}

