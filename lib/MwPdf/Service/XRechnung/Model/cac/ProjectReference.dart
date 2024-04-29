import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/UUID.dart';
import '../cbc/IssueDate.dart';
import '../cac/WorkPhaseReference.dart';

// A class to define a reference to a procurement project.
class ProjectReference {


  // An identifier for the referenced project.
  final ID iD;

  // A universally unique identifier for the referenced project.
  final UUID? uUID;

  // The date on which the referenced project was issued.
  final IssueDate? issueDate;

  // A specific phase of work in the referenced project.
  final List<WorkPhaseReference> workPhaseReference;

  ProjectReference ({
    required this.iD,
    this.uUID,
    this.issueDate,
    this.workPhaseReference = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
      'uUID': uUID?.toJson(),
      'issueDate': issueDate?.toJson(),
      'workPhaseReference': workPhaseReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ProjectReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ProjectReference (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      issueDate: IssueDate.fromJson(json['issueDate'] as Map<String, dynamic>?),
      workPhaseReference: (json['workPhaseReference'] as List? ?? []).map((dynamic d) => WorkPhaseReference.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static ProjectReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ProjectReference (
      iD: null,
      uUID: null,
      issueDate: null,
      workPhaseReference: null,
    );
  }

}

