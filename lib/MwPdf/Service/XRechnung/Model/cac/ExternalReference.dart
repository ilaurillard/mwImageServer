import 'dart:convert';
import '../../Etc/Util.dart';
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


  ExternalReference fromJson(Map<String, dynamic> json) {
    return ExternalReference (
    );
  }

}

