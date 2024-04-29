import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/EmbeddedDocumentBinaryObject.dart';
import '../cac/ExternalReference.dart';

// A class to describe an attached document. An attachment can refer to an external document or be included with the document being exchanged.
class DigitalSignatureAttachment {


  // A binary large object containing an attached document.
  final EmbeddedDocumentBinaryObject? embeddedDocumentBinaryObject;

  // A reference to an attached document that is external to the document(s) being exchanged.
  final ExternalReference? externalReference;

  DigitalSignatureAttachment ({
    this.embeddedDocumentBinaryObject,
    this.externalReference,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'embeddedDocumentBinaryObject': embeddedDocumentBinaryObject?.toJson(),
      'externalReference': externalReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DigitalSignatureAttachment? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DigitalSignatureAttachment (
      embeddedDocumentBinaryObject: EmbeddedDocumentBinaryObject.fromJson(json['embeddedDocumentBinaryObject'] as Map<String, dynamic>?),
      externalReference: ExternalReference.fromJson(json['externalReference'] as Map<String, dynamic>?),
    );
  }

  static DigitalSignatureAttachment? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return DigitalSignatureAttachment (
      embeddedDocumentBinaryObject: null,
      externalReference: null,
    );
  }

}

