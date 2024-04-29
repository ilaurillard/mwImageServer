import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/Note.dart';
import '../cbc/ValidationDate.dart';
import '../cbc/ValidationTime.dart';
import '../cbc/ValidatorID.dart';
import '../cbc/CanonicalizationMethod.dart';
import '../cbc/SignatureMethod.dart';
import '../cac/SignatoryParty.dart';
import '../cac/DigitalSignatureAttachment.dart';
import '../cac/OriginalDocumentReference.dart';

// A class to define a signature.
class Signature {


  // An identifier for this signature.
  final ID iD;

  // Free-form text conveying information that is not contained explicitly in other structures; in particular, information regarding the circumstances in which the signature is being used.
  final List<Note> note;

  // The date upon which this signature was verified.
  final ValidationDate? validationDate;

  // The time at which this signature was verified.
  final ValidationTime? validationTime;

  // An identifier for the organization, person, service, or server that verified this signature.
  final ValidatorID? validatorID;

  // The method used to perform XML canonicalization of this signature.
  final CanonicalizationMethod? canonicalizationMethod;

  // Text describing the method of signature.
  final SignatureMethod? signatureMethod;

  // The signing party.
  final SignatoryParty? signatoryParty;

  // The actual encoded signature (e.g., in XMLDsig format).
  final DigitalSignatureAttachment? digitalSignatureAttachment;

  // A reference to the document that the signature applies to. For evidentiary purposes, this may be the document image that the signatory party saw when applying their signature.
  final OriginalDocumentReference? originalDocumentReference;

  Signature ({
    required this.iD,
    this.note = const [],
    this.validationDate,
    this.validationTime,
    this.validatorID,
    this.canonicalizationMethod,
    this.signatureMethod,
    this.signatoryParty,
    this.digitalSignatureAttachment,
    this.originalDocumentReference,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD.toJson(),
     'note': note.map((e) => e.toJson()).toList(),
     'validationDate': validationDate?.toJson(),
     'validationTime': validationTime?.toJson(),
     'validatorID': validatorID?.toJson(),
     'canonicalizationMethod': canonicalizationMethod?.toJson(),
     'signatureMethod': signatureMethod?.toJson(),
     'signatoryParty': signatoryParty?.toJson(),
     'digitalSignatureAttachment': digitalSignatureAttachment?.toJson(),
     'originalDocumentReference': originalDocumentReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

