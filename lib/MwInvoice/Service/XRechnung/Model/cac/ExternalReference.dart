// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/URI.dart';
import '../cbc/DocumentHash.dart';
import '../cbc/HashAlgorithmMethod.dart';
import '../cbc/ExpiryDate.dart';
import '../cbc/ExpiryTime.dart';
import '../cbc/MimeCode.dart';
import '../cbc/FormatCode.dart';
import '../cbc/EncodingCode.dart';
import '../cbc/CharacterSetCode.dart';
import '../cbc/FileName.dart';
import '../cbc/Description.dart';

// A class to describe an external object, such as a document stored at a remote location.
class ExternalReference {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The Uniform Resource Identifier (URI) that identifies the external object as an Internet resource.
  final URI? uRI;

  // A hash value for the externally stored object.
  final DocumentHash? documentHash;

  // A hash algorithm used to calculate the hash value of the externally stored object.
  final HashAlgorithmMethod? hashAlgorithmMethod;

  // The date on which availability of the resource can no longer be relied upon.
  final ExpiryDate? expiryDate;

  // The time after which availability of the resource can no longer be relied upon.
  final ExpiryTime? expiryTime;

  // A code signifying the mime type of the external object.
  final MimeCode? mimeCode;

  // A code signifying the format of the external object.
  final FormatCode? formatCode;

  // A code signifying the encoding/decoding algorithm used with the external object.
  final EncodingCode? encodingCode;

  // A code signifying the character set of an external document.
  final CharacterSetCode? characterSetCode;

  // The file name of the external object.
  final FileName? fileName;

  // Text describing the external object.
  final List<Description> description;

  ExternalReference ({
    this.uBLExtensions,
    this.uRI,
    this.documentHash,
    this.hashAlgorithmMethod,
    this.expiryDate,
    this.expiryTime,
    this.mimeCode,
    this.formatCode,
    this.encodingCode,
    this.characterSetCode,
    this.fileName,
    this.description = const [],
  });

  static ExternalReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ExternalReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      uRI: URI.fromJson(json['uRI'] as Map<String, dynamic>?),
      documentHash: DocumentHash.fromJson(json['documentHash'] as Map<String, dynamic>?),
      hashAlgorithmMethod: HashAlgorithmMethod.fromJson(json['hashAlgorithmMethod'] as Map<String, dynamic>?),
      expiryDate: ExpiryDate.fromJson(json['expiryDate'] as Map<String, dynamic>?),
      expiryTime: ExpiryTime.fromJson(json['expiryTime'] as Map<String, dynamic>?),
      mimeCode: MimeCode.fromJson(json['mimeCode'] as Map<String, dynamic>?),
      formatCode: FormatCode.fromJson(json['formatCode'] as Map<String, dynamic>?),
      encodingCode: EncodingCode.fromJson(json['encodingCode'] as Map<String, dynamic>?),
      characterSetCode: CharacterSetCode.fromJson(json['characterSetCode'] as Map<String, dynamic>?),
      fileName: FileName.fromJson(json['fileName'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'uRI': uRI?.toJson(),
      'documentHash': documentHash?.toJson(),
      'hashAlgorithmMethod': hashAlgorithmMethod?.toJson(),
      'expiryDate': expiryDate?.toJson(),
      'expiryTime': expiryTime?.toJson(),
      'mimeCode': mimeCode?.toJson(),
      'formatCode': formatCode?.toJson(),
      'encodingCode': encodingCode?.toJson(),
      'characterSetCode': characterSetCode?.toJson(),
      'fileName': fileName?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ExternalReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ExternalReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      uRI: URI.fromXml(xml.findElements('cbc:URI').singleOrNull),
      documentHash: DocumentHash.fromXml(xml.findElements('cbc:DocumentHash').singleOrNull),
      hashAlgorithmMethod: HashAlgorithmMethod.fromXml(xml.findElements('cbc:HashAlgorithmMethod').singleOrNull),
      expiryDate: ExpiryDate.fromXml(xml.findElements('cbc:ExpiryDate').singleOrNull),
      expiryTime: ExpiryTime.fromXml(xml.findElements('cbc:ExpiryTime').singleOrNull),
      mimeCode: MimeCode.fromXml(xml.findElements('cbc:MimeCode').singleOrNull),
      formatCode: FormatCode.fromXml(xml.findElements('cbc:FormatCode').singleOrNull),
      encodingCode: EncodingCode.fromXml(xml.findElements('cbc:EncodingCode').singleOrNull),
      characterSetCode: CharacterSetCode.fromXml(xml.findElements('cbc:CharacterSetCode').singleOrNull),
      fileName: FileName.fromXml(xml.findElements('cbc:FileName').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      uRI?.toXml(),
      documentHash?.toXml(),
      hashAlgorithmMethod?.toXml(),
      expiryDate?.toXml(),
      expiryTime?.toXml(),
      mimeCode?.toXml(),
      formatCode?.toXml(),
      encodingCode?.toXml(),
      characterSetCode?.toXml(),
      fileName?.toXml(),
      ...description.map((Description e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ExternalReference',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

