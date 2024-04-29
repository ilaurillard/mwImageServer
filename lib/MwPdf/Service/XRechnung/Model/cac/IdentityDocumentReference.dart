import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/CopyIndicator.dart';
import '../cbc/UUID.dart';
import '../cbc/IssueDate.dart';
import '../cbc/IssueTime.dart';
import '../cbc/DocumentTypeCode.dart';
import '../cbc/DocumentType.dart';
import '../cbc/XPath.dart';
import '../cbc/LanguageID.dart';
import '../cbc/LocaleCode.dart';
import '../cbc/VersionID.dart';
import '../cbc/DocumentStatusCode.dart';
import '../cbc/DocumentDescription.dart';
import '../cac/Attachment.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/IssuerParty.dart';
import '../cac/ResultOfVerification.dart';

// A class to define a reference to a document.
class IdentityDocumentReference {


  // An identifier for the referenced document.
  final ID iD;

  // An indicator that the referenced document is a copy (true) or the original (false).
  final CopyIndicator? copyIndicator;

  // A universally unique identifier for this document reference.
  final UUID? uUID;

  // The date, assigned by the sender of the referenced document, on which the document was issued.
  final IssueDate? issueDate;

  // The time, assigned by the sender of the referenced document, at which the document was issued.
  final IssueTime? issueTime;

  // The type of document being referenced, expressed as a code.
  final DocumentTypeCode? documentTypeCode;

  // The type of document being referenced, expressed as text.
  final DocumentType? documentType;

  // A reference to another place in the same XML document instance in which DocumentReference appears.
  final List<XPath> xPath;

  // An identifier for the language used in the referenced document.
  final LanguageID? languageID;

  // A code signifying the locale in which the language in the referenced document is used.
  final LocaleCode? localeCode;

  // An identifier for the current version of the referenced document.
  final VersionID? versionID;

  // A code signifying the status of the reference document with respect to its original state.
  final DocumentStatusCode? documentStatusCode;

  // Text describing the referenced document.
  final List<DocumentDescription> documentDescription;

  // The referenced document as an attachment to the document from which it is referenced.
  final Attachment? attachment;

  // The period for which this document reference is valid.
  final ValidityPeriod? validityPeriod;

  // The party who issued the referenced document.
  final IssuerParty? issuerParty;

  // The result of an attempt to verify a signature associated with the referenced document.
  final ResultOfVerification? resultOfVerification;

  IdentityDocumentReference ({
    required this.iD,
    this.copyIndicator,
    this.uUID,
    this.issueDate,
    this.issueTime,
    this.documentTypeCode,
    this.documentType,
    this.xPath = const [],
    this.languageID,
    this.localeCode,
    this.versionID,
    this.documentStatusCode,
    this.documentDescription = const [],
    this.attachment,
    this.validityPeriod,
    this.issuerParty,
    this.resultOfVerification,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
      'copyIndicator': copyIndicator?.toJson(),
      'uUID': uUID?.toJson(),
      'issueDate': issueDate?.toJson(),
      'issueTime': issueTime?.toJson(),
      'documentTypeCode': documentTypeCode?.toJson(),
      'documentType': documentType?.toJson(),
      'xPath': xPath.map((e) => e.toJson()).toList(),
      'languageID': languageID?.toJson(),
      'localeCode': localeCode?.toJson(),
      'versionID': versionID?.toJson(),
      'documentStatusCode': documentStatusCode?.toJson(),
      'documentDescription': documentDescription.map((e) => e.toJson()).toList(),
      'attachment': attachment?.toJson(),
      'validityPeriod': validityPeriod?.toJson(),
      'issuerParty': issuerParty?.toJson(),
      'resultOfVerification': resultOfVerification?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static IdentityDocumentReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return IdentityDocumentReference (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      copyIndicator: CopyIndicator.fromJson(json['copyIndicator'] as Map<String, dynamic>?),
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      issueDate: IssueDate.fromJson(json['issueDate'] as Map<String, dynamic>?),
      issueTime: IssueTime.fromJson(json['issueTime'] as Map<String, dynamic>?),
      documentTypeCode: DocumentTypeCode.fromJson(json['documentTypeCode'] as Map<String, dynamic>?),
      documentType: DocumentType.fromJson(json['documentType'] as Map<String, dynamic>?),
      xPath: (json['xPath'] as List? ?? []).map((dynamic d) => XPath.fromJson(d as Map<String, dynamic>?)!).toList(),
      languageID: LanguageID.fromJson(json['languageID'] as Map<String, dynamic>?),
      localeCode: LocaleCode.fromJson(json['localeCode'] as Map<String, dynamic>?),
      versionID: VersionID.fromJson(json['versionID'] as Map<String, dynamic>?),
      documentStatusCode: DocumentStatusCode.fromJson(json['documentStatusCode'] as Map<String, dynamic>?),
      documentDescription: (json['documentDescription'] as List? ?? []).map((dynamic d) => DocumentDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      attachment: Attachment.fromJson(json['attachment'] as Map<String, dynamic>?),
      validityPeriod: ValidityPeriod.fromJson(json['validityPeriod'] as Map<String, dynamic>?),
      issuerParty: IssuerParty.fromJson(json['issuerParty'] as Map<String, dynamic>?),
      resultOfVerification: ResultOfVerification.fromJson(json['resultOfVerification'] as Map<String, dynamic>?),
    );
  }

  static IdentityDocumentReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return IdentityDocumentReference (
      iD: null,
      copyIndicator: null,
      uUID: null,
      issueDate: null,
      issueTime: null,
      documentTypeCode: null,
      documentType: null,
      xPath: null,
      languageID: null,
      localeCode: null,
      versionID: null,
      documentStatusCode: null,
      documentDescription: null,
      attachment: null,
      validityPeriod: null,
      issuerParty: null,
      resultOfVerification: null,
    );
  }

}

