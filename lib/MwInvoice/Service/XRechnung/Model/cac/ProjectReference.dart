// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/UUID.dart';
import '../cbc/IssueDate.dart';
import '../cac/WorkPhaseReference.dart';

// A class to define a reference to a procurement project.
class ProjectReference {


  // An identifier for the referenced project.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A universally unique identifier for the referenced project.
  final UUID? uUID;

  // The date on which the referenced project was issued.
  final IssueDate? issueDate;

  // A specific phase of work in the referenced project.
  final List<WorkPhaseReference> workPhaseReference;

  ProjectReference ({
    required this.iD,
    this.uBLExtensions,
    this.uUID,
    this.issueDate,
    this.workPhaseReference = const [],
  });

  static ProjectReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ProjectReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      issueDate: IssueDate.fromJson(json['issueDate'] as Map<String, dynamic>?),
      workPhaseReference: (json['workPhaseReference'] as List? ?? []).map((dynamic d) => WorkPhaseReference.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'uUID': uUID?.toJson(),
      'issueDate': issueDate?.toJson(),
      'workPhaseReference': workPhaseReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ProjectReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ProjectReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      uUID: UUID.fromXml(xml.findElements('cbc:UUID').singleOrNull),
      issueDate: IssueDate.fromXml(xml.findElements('cbc:IssueDate').singleOrNull),
      workPhaseReference: xml.findElements('cac:WorkPhaseReference').map((XmlElement e) => WorkPhaseReference.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      uUID?.toXml(),
      issueDate?.toXml(),
      ...workPhaseReference.map((WorkPhaseReference e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ProjectReference',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

