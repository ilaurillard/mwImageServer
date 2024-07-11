// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/WorkPhaseCode.dart';
import '../cbc/WorkPhase.dart';
import '../cbc/ProgressPercent.dart';
import '../cbc/StartDate.dart';
import '../cbc/EndDate.dart';
import '../cac/WorkOrderDocumentReference.dart';

// A class that refers to a phase of work. Used for instance to specify what part of the contract the billing is referring to.
class WorkPhaseReference {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this phase of work.
  final ID? iD;

  // A code signifying this phase of work.
  final WorkPhaseCode? workPhaseCode;

  // Text describing this phase of work.
  final List<WorkPhase> workPhase;

  // The progress percentage of the work phase.
  final ProgressPercent? progressPercent;

  // The date on which this phase of work begins.
  final StartDate? startDate;

  // The date on which this phase of work ends.
  final EndDate? endDate;

  // A reference to a document regarding the work order for the project in which this phase of work takes place.
  final List<WorkOrderDocumentReference> workOrderDocumentReference;

  WorkPhaseReference ({
    this.uBLExtensions,
    this.iD,
    this.workPhaseCode,
    this.workPhase = const [],
    this.progressPercent,
    this.startDate,
    this.endDate,
    this.workOrderDocumentReference = const [],
  });

  static WorkPhaseReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return WorkPhaseReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      workPhaseCode: WorkPhaseCode.fromJson(json['workPhaseCode'] as Map<String, dynamic>?),
      workPhase: (json['workPhase'] as List? ?? []).map((dynamic d) => WorkPhase.fromJson(d as Map<String, dynamic>?)!).toList(),
      progressPercent: ProgressPercent.fromJson(json['progressPercent'] as Map<String, dynamic>?),
      startDate: StartDate.fromJson(json['startDate'] as Map<String, dynamic>?),
      endDate: EndDate.fromJson(json['endDate'] as Map<String, dynamic>?),
      workOrderDocumentReference: (json['workOrderDocumentReference'] as List? ?? []).map((dynamic d) => WorkOrderDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'workPhaseCode': workPhaseCode?.toJson(),
      'workPhase': workPhase.map((e) => e.toJson()).toList(),
      'progressPercent': progressPercent?.toJson(),
      'startDate': startDate?.toJson(),
      'endDate': endDate?.toJson(),
      'workOrderDocumentReference': workOrderDocumentReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static WorkPhaseReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return WorkPhaseReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      workPhaseCode: WorkPhaseCode.fromXml(xml.findElements('cbc:WorkPhaseCode').singleOrNull),
      workPhase: xml.findElements('cbc:WorkPhase').map((XmlElement e) => WorkPhase.fromXml(e)!).toList(),
      progressPercent: ProgressPercent.fromXml(xml.findElements('cbc:ProgressPercent').singleOrNull),
      startDate: StartDate.fromXml(xml.findElements('cbc:StartDate').singleOrNull),
      endDate: EndDate.fromXml(xml.findElements('cbc:EndDate').singleOrNull),
      workOrderDocumentReference: xml.findElements('cac:WorkOrderDocumentReference').map((XmlElement e) => WorkOrderDocumentReference.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      workPhaseCode?.toXml(),
      ...workPhase.map((WorkPhase e) => e.toXml()),
      progressPercent?.toXml(),
      startDate?.toXml(),
      endDate?.toXml(),
      ...workOrderDocumentReference.map((WorkOrderDocumentReference e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'WorkPhaseReference',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

