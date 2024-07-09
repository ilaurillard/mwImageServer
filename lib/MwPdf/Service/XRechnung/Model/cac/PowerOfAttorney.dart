// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cac/AgentParty.dart';
import '../ext/UBLExtensions.dart';
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

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
    this.uBLExtensions,
    this.iD,
    this.issueDate,
    this.issueTime,
    this.description = const [],
    this.notaryParty,
    this.witnessParty = const [],
    this.mandateDocumentReference = const [],
  });

  static PowerOfAttorney? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PowerOfAttorney (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      issueDate: IssueDate.fromJson(json['issueDate'] as Map<String, dynamic>?),
      issueTime: IssueTime.fromJson(json['issueTime'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      notaryParty: NotaryParty.fromJson(json['notaryParty'] as Map<String, dynamic>?),
      agentParty: AgentParty.fromJson(json['agentParty'] as Map<String, dynamic>?)!,
      witnessParty: (json['witnessParty'] as List? ?? []).map((dynamic d) => WitnessParty.fromJson(d as Map<String, dynamic>?)!).toList(),
      mandateDocumentReference: (json['mandateDocumentReference'] as List? ?? []).map((dynamic d) => MandateDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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

  static PowerOfAttorney? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PowerOfAttorney (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      issueDate: IssueDate.fromXml(xml.findElements('cbc:IssueDate').singleOrNull),
      issueTime: IssueTime.fromXml(xml.findElements('cbc:IssueTime').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      notaryParty: NotaryParty.fromXml(xml.findElements('cac:NotaryParty').singleOrNull),
      agentParty: AgentParty.fromXml(xml.findElements('cac:AgentParty').singleOrNull)!,
      witnessParty: xml.findElements('cac:WitnessParty').map((XmlElement e) => WitnessParty.fromXml(e)!).toList(),
      mandateDocumentReference: xml.findElements('cac:MandateDocumentReference').map((XmlElement e) => MandateDocumentReference.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      issueDate?.toXml(),
      issueTime?.toXml(),
      ...description.map((Description e) => e.toXml()),
      notaryParty?.toXml(),
      agentParty.toXml(),
      ...witnessParty.map((WitnessParty e) => e.toXml()),
      ...mandateDocumentReference.map((MandateDocumentReference e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PowerOfAttorney',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

