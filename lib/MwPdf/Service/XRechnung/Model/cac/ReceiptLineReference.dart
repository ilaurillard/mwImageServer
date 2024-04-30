import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/LineID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/UUID.dart';
import '../cbc/LineStatusCode.dart';
import '../cac/DocumentReference.dart';

// A class to define a reference to a line in a document.
class ReceiptLineReference {


  // Identifies the referenced line in the document.
  final LineID lineID;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A universally unique identifier for this line reference.
  final UUID? uUID;

  // A code signifying the status of the referenced line with respect to its original state.
  final LineStatusCode? lineStatusCode;

  // A reference to the document containing the referenced line.
  final DocumentReference? documentReference;

  ReceiptLineReference ({
    required this.lineID,
    this.uBLExtensions,
    this.uUID,
    this.lineStatusCode,
    this.documentReference,
  });

  static ReceiptLineReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ReceiptLineReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      lineID: LineID.fromJson(json['lineID'] as Map<String, dynamic>?)!,
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      lineStatusCode: LineStatusCode.fromJson(json['lineStatusCode'] as Map<String, dynamic>?),
      documentReference: DocumentReference.fromJson(json['documentReference'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'lineID': lineID.toJson(),
      'uUID': uUID?.toJson(),
      'lineStatusCode': lineStatusCode?.toJson(),
      'documentReference': documentReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ReceiptLineReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ReceiptLineReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      lineID: LineID.fromXml(xml.findElements('cbc:LineID').singleOrNull)!,
      uUID: UUID.fromXml(xml.findElements('cbc:UUID').singleOrNull),
      lineStatusCode: LineStatusCode.fromXml(xml.findElements('cbc:LineStatusCode').singleOrNull),
      documentReference: DocumentReference.fromXml(xml.findElements('cac:DocumentReference').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      lineID.toXml(),
      uUID?.toXml(),
      lineStatusCode?.toXml(),
      documentReference?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ReceiptLineReference',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

