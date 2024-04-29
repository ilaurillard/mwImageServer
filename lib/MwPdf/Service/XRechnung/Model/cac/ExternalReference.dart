import '../cac/URI.dart';
import '../cac/DocumentHash.dart';
import '../cac/HashAlgorithmMethod.dart';
import '../cac/ExpiryDate.dart';
import '../cac/ExpiryTime.dart';
import '../cac/MimeCode.dart';
import '../cac/FormatCode.dart';
import '../cac/EncodingCode.dart';
import '../cac/CharacterSetCode.dart';
import '../cac/FileName.dart';
import '../cac/Description.dart';

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
}

