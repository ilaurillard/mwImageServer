import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/LineID.dart';
import '../cbc/UUID.dart';
import '../cbc/LineStatusCode.dart';
import '../cac/DocumentReference.dart';

// A class to define a reference to a line in a document.
class DespatchLineReference {


  // Identifies the referenced line in the document.
  final LineID lineID;

  // A universally unique identifier for this line reference.
  final UUID? uUID;

  // A code signifying the status of the referenced line with respect to its original state.
  final LineStatusCode? lineStatusCode;

  // A reference to the document containing the referenced line.
  final DocumentReference? documentReference;

  DespatchLineReference ({
    required this.lineID,
    this.uUID,
    this.lineStatusCode,
    this.documentReference,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'lineID': lineID.toJson(),
      'uUID': uUID?.toJson(),
      'lineStatusCode': lineStatusCode?.toJson(),
      'documentReference': documentReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DespatchLineReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DespatchLineReference (
      lineID: LineID.fromJson(json['lineID'] as Map<String, dynamic>?)!,
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      lineStatusCode: LineStatusCode.fromJson(json['lineStatusCode'] as Map<String, dynamic>?),
      documentReference: DocumentReference.fromJson(json['documentReference'] as Map<String, dynamic>?),
    );
  }

  static DespatchLineReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return DespatchLineReference (
      lineID: null,
      uUID: null,
      lineStatusCode: null,
      documentReference: null,
    );
  }

}

