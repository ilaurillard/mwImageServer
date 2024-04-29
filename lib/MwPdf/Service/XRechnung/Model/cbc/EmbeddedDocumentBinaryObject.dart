import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A set of finite-length sequences of binary octets.
class EmbeddedDocumentBinaryObject {

  final String value; // (base64Binary)

  // The mime type of the binary object.
  final String mimeCode; // (normalizedString)

  // The format of the binary content.
  final String? format; // (string)

  // Specifies the decoding algorithm of the binary object.
  final String? encodingCode; // (normalizedString)

  // The character set of the binary object if the mime type is text.
  final String? characterSetCode; // (normalizedString)

  // The Uniform Resource Identifier that identifies where the binary object is located.
  final String? uri; // (anyURI)

  // The filename of the binary object.
  final String? filename; // (string)

  EmbeddedDocumentBinaryObject ({
    required this.value,
    required this.mimeCode,
    this.format,
    this.encodingCode,
    this.characterSetCode,
    this.uri,
    this.filename,
  }) {
    assert(value.isNotEmpty);
    assert(mimeCode.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
      'format': format,
      'mimeCode': mimeCode,
      'encodingCode': encodingCode,
      'characterSetCode': characterSetCode,
      'uri': uri,
      'filename': filename,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EmbeddedDocumentBinaryObject? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EmbeddedDocumentBinaryObject (
      value: json['value'] as String? ?? '',
      format: json['format'] as String?,
      mimeCode: json['mimeCode'] as String? ?? '',
      encodingCode: json['encodingCode'] as String?,
      characterSetCode: json['characterSetCode'] as String?,
      uri: json['uri'] as String?,
      filename: json['filename'] as String?,
    );
  }

  static EmbeddedDocumentBinaryObject? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return EmbeddedDocumentBinaryObject (
      value: null,
      format: null,
      mimeCode: null,
      encodingCode: null,
      characterSetCode: null,
      uri: null,
      filename: null,
    );
  }

}

