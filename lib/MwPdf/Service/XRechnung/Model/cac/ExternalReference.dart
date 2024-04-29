import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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

  static ExternalReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ExternalReference (
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

  static ExternalReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ExternalReference (
      uRI: null,
      documentHash: null,
      hashAlgorithmMethod: null,
      expiryDate: null,
      expiryTime: null,
      mimeCode: null,
      formatCode: null,
      encodingCode: null,
      characterSetCode: null,
      fileName: null,
      description: null,
    );
  }

}

