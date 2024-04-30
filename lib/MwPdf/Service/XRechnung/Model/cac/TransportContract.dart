import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/IssueDate.dart';
import '../cbc/IssueTime.dart';
import '../cbc/NominationDate.dart';
import '../cbc/NominationTime.dart';
import '../cbc/ContractTypeCode.dart';
import '../cbc/ContractType.dart';
import '../cbc/Note.dart';
import '../cbc/VersionID.dart';
import '../cbc/ModificationReasonCode.dart';
import '../cbc/ModificationReasonDescription.dart';
import '../cbc/Description.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/ContractDocumentReference.dart';
import '../cac/NominationPeriod.dart';
import '../cac/ContractualDelivery.dart';

// A class to describe a contract.
class TransportContract {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // The main reason for modifying the contract expressed as a code.
  final ModificationReasonCode? modificationReasonCode;

  // Text describing the main reason for modifying the contract
  final List<ModificationReasonDescription> modificationReasonDescription;

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
    this.uBLExtensions,
    this.iD,
    this.issueDate,
    this.issueTime,
    this.nominationDate,
    this.nominationTime,
    this.contractTypeCode,
    this.contractType,
    this.note = const [],
    this.versionID,
    this.modificationReasonCode,
    this.modificationReasonDescription = const [],
    this.description = const [],
    this.validityPeriod,
    this.contractDocumentReference = const [],
    this.nominationPeriod,
    this.contractualDelivery,
  });

  static TransportContract? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TransportContract (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      issueDate: IssueDate.fromJson(json['issueDate'] as Map<String, dynamic>?),
      issueTime: IssueTime.fromJson(json['issueTime'] as Map<String, dynamic>?),
      nominationDate: NominationDate.fromJson(json['nominationDate'] as Map<String, dynamic>?),
      nominationTime: NominationTime.fromJson(json['nominationTime'] as Map<String, dynamic>?),
      contractTypeCode: ContractTypeCode.fromJson(json['contractTypeCode'] as Map<String, dynamic>?),
      contractType: ContractType.fromJson(json['contractType'] as Map<String, dynamic>?),
      note: (json['note'] as List? ?? []).map((dynamic d) => Note.fromJson(d as Map<String, dynamic>?)!).toList(),
      versionID: VersionID.fromJson(json['versionID'] as Map<String, dynamic>?),
      modificationReasonCode: ModificationReasonCode.fromJson(json['modificationReasonCode'] as Map<String, dynamic>?),
      modificationReasonDescription: (json['modificationReasonDescription'] as List? ?? []).map((dynamic d) => ModificationReasonDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      validityPeriod: ValidityPeriod.fromJson(json['validityPeriod'] as Map<String, dynamic>?),
      contractDocumentReference: (json['contractDocumentReference'] as List? ?? []).map((dynamic d) => ContractDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      nominationPeriod: NominationPeriod.fromJson(json['nominationPeriod'] as Map<String, dynamic>?),
      contractualDelivery: ContractualDelivery.fromJson(json['contractualDelivery'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'issueDate': issueDate?.toJson(),
      'issueTime': issueTime?.toJson(),
      'nominationDate': nominationDate?.toJson(),
      'nominationTime': nominationTime?.toJson(),
      'contractTypeCode': contractTypeCode?.toJson(),
      'contractType': contractType?.toJson(),
      'note': note.map((e) => e.toJson()).toList(),
      'versionID': versionID?.toJson(),
      'modificationReasonCode': modificationReasonCode?.toJson(),
      'modificationReasonDescription': modificationReasonDescription.map((e) => e.toJson()).toList(),
      'description': description.map((e) => e.toJson()).toList(),
      'validityPeriod': validityPeriod?.toJson(),
      'contractDocumentReference': contractDocumentReference.map((e) => e.toJson()).toList(),
      'nominationPeriod': nominationPeriod?.toJson(),
      'contractualDelivery': contractualDelivery?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TransportContract? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TransportContract (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      issueDate: IssueDate.fromXml(xml.findElements('cbc:IssueDate').singleOrNull),
      issueTime: IssueTime.fromXml(xml.findElements('cbc:IssueTime').singleOrNull),
      nominationDate: NominationDate.fromXml(xml.findElements('cbc:NominationDate').singleOrNull),
      nominationTime: NominationTime.fromXml(xml.findElements('cbc:NominationTime').singleOrNull),
      contractTypeCode: ContractTypeCode.fromXml(xml.findElements('cbc:ContractTypeCode').singleOrNull),
      contractType: ContractType.fromXml(xml.findElements('cbc:ContractType').singleOrNull),
      note: xml.findElements('cbc:Note').map((XmlElement e) => Note.fromXml(e)!).toList(),
      versionID: VersionID.fromXml(xml.findElements('cbc:VersionID').singleOrNull),
      modificationReasonCode: ModificationReasonCode.fromXml(xml.findElements('cbc:ModificationReasonCode').singleOrNull),
      modificationReasonDescription: xml.findElements('cbc:ModificationReasonDescription').map((XmlElement e) => ModificationReasonDescription.fromXml(e)!).toList(),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      validityPeriod: ValidityPeriod.fromXml(xml.findElements('cac:ValidityPeriod').singleOrNull),
      contractDocumentReference: xml.findElements('cac:ContractDocumentReference').map((XmlElement e) => ContractDocumentReference.fromXml(e)!).toList(),
      nominationPeriod: NominationPeriod.fromXml(xml.findElements('cac:NominationPeriod').singleOrNull),
      contractualDelivery: ContractualDelivery.fromXml(xml.findElements('cac:ContractualDelivery').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      issueDate?.toXml(),
      issueTime?.toXml(),
      nominationDate?.toXml(),
      nominationTime?.toXml(),
      contractTypeCode?.toXml(),
      contractType?.toXml(),
      ...note.map((Note e) => e.toXml()).toList(),
      versionID?.toXml(),
      modificationReasonCode?.toXml(),
      ...modificationReasonDescription.map((ModificationReasonDescription e) => e.toXml()).toList(),
      ...description.map((Description e) => e.toXml()).toList(),
      validityPeriod?.toXml(),
      ...contractDocumentReference.map((ContractDocumentReference e) => e.toXml()).toList(),
      nominationPeriod?.toXml(),
      contractualDelivery?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'TransportContract',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

