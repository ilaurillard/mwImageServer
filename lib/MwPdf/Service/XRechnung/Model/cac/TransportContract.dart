import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
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

  static TransportContract? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TransportContract (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      issueDate: IssueDate.fromJson(json['issueDate'] as Map<String, dynamic>?),
      issueTime: IssueTime.fromJson(json['issueTime'] as Map<String, dynamic>?),
      nominationDate: NominationDate.fromJson(json['nominationDate'] as Map<String, dynamic>?),
      nominationTime: NominationTime.fromJson(json['nominationTime'] as Map<String, dynamic>?),
      contractTypeCode: ContractTypeCode.fromJson(json['contractTypeCode'] as Map<String, dynamic>?),
      contractType: ContractType.fromJson(json['contractType'] as Map<String, dynamic>?),
      note: (json['note'] as List? ?? []).map((dynamic d) => Note.fromJson(d as Map<String, dynamic>?)!).toList(),
      versionID: VersionID.fromJson(json['versionID'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      validityPeriod: ValidityPeriod.fromJson(json['validityPeriod'] as Map<String, dynamic>?),
      contractDocumentReference: (json['contractDocumentReference'] as List? ?? []).map((dynamic d) => ContractDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      nominationPeriod: NominationPeriod.fromJson(json['nominationPeriod'] as Map<String, dynamic>?),
      contractualDelivery: ContractualDelivery.fromJson(json['contractualDelivery'] as Map<String, dynamic>?),
    );
  }

  static TransportContract? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return TransportContract (
      iD: null,
      issueDate: null,
      issueTime: null,
      nominationDate: null,
      nominationTime: null,
      contractTypeCode: null,
      contractType: null,
      note: null,
      versionID: null,
      description: null,
      validityPeriod: null,
      contractDocumentReference: null,
      nominationPeriod: null,
      contractualDelivery: null,
    );
  }

}

