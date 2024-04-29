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
  });
}

