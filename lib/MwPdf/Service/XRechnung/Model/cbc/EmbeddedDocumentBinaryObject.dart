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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
      'format': format.toString(),
      'mimeCode': mimeCode.toString(),
      'encodingCode': encodingCode.toString(),
      'characterSetCode': characterSetCode.toString(),
      'uri': uri.toString(),
      'filename': filename.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EmbeddedDocumentBinaryObject? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return EmbeddedDocumentBinaryObject (
      value: xml.innerText,
      format: xml.getAttribute('format'),
      mimeCode: xml.getAttribute('mimeCode') ?? '',
      encodingCode: xml.getAttribute('encodingCode'),
      characterSetCode: xml.getAttribute('characterSetCode'),
      uri: xml.getAttribute('uri'),
      filename: xml.getAttribute('filename'),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      XmlText(value.toString()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [

      format != null ? XmlAttribute(XmlName('format'), format.toString(),) : null,
      XmlAttribute(XmlName('mimeCode'), mimeCode.toString(),),
      encodingCode != null ? XmlAttribute(XmlName('encodingCode'), encodingCode.toString(),) : null,
      characterSetCode != null ? XmlAttribute(XmlName('characterSetCode'), characterSetCode.toString(),) : null,
      uri != null ? XmlAttribute(XmlName('uri'), uri.toString(),) : null,
      filename != null ? XmlAttribute(XmlName('filename'), filename.toString(),) : null,

    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'EmbeddedDocumentBinaryObject',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

