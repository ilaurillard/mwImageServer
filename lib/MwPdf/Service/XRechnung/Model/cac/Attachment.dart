import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/EmbeddedDocumentBinaryObject.dart';
import '../cbc/EmbeddedDocument.dart';
import '../cac/ExternalReference.dart';

// A class to describe an attached document. An attachment can refer to an external document or be included with the document being exchanged.
class Attachment {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A binary large object containing an attached document.
  final EmbeddedDocumentBinaryObject? embeddedDocumentBinaryObject;

  // A clear text object containing an attached document.
  final EmbeddedDocument? embeddedDocument;

  // A reference to an attached document that is external to the document(s) being exchanged.
  final ExternalReference? externalReference;

  Attachment ({
    this.uBLExtensions,
    this.embeddedDocumentBinaryObject,
    this.embeddedDocument,
    this.externalReference,
  });

  static Attachment? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Attachment (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      embeddedDocumentBinaryObject: EmbeddedDocumentBinaryObject.fromJson(json['embeddedDocumentBinaryObject'] as Map<String, dynamic>?),
      embeddedDocument: EmbeddedDocument.fromJson(json['embeddedDocument'] as Map<String, dynamic>?),
      externalReference: ExternalReference.fromJson(json['externalReference'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'embeddedDocumentBinaryObject': embeddedDocumentBinaryObject?.toJson(),
      'embeddedDocument': embeddedDocument?.toJson(),
      'externalReference': externalReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Attachment? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return Attachment (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      embeddedDocumentBinaryObject: EmbeddedDocumentBinaryObject.fromXml(xml.findElements('cbc:EmbeddedDocumentBinaryObject').singleOrNull),
      embeddedDocument: EmbeddedDocument.fromXml(xml.findElements('cbc:EmbeddedDocument').singleOrNull),
      externalReference: ExternalReference.fromXml(xml.findElements('cac:ExternalReference').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      embeddedDocumentBinaryObject?.toXml(),
      embeddedDocument?.toXml(),
      externalReference?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'Attachment',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

