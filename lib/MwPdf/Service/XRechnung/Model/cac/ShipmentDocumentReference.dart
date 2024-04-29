import '../cac/ID.dart';
import '../cac/CopyIndicator.dart';
import '../cac/UUID.dart';
import '../cac/IssueDate.dart';
import '../cac/IssueTime.dart';
import '../cac/DocumentTypeCode.dart';
import '../cac/DocumentType.dart';
import '../cac/XPath.dart';
import '../cac/LanguageID.dart';
import '../cac/LocaleCode.dart';
import '../cac/VersionID.dart';
import '../cac/DocumentStatusCode.dart';
import '../cac/DocumentDescription.dart';
import '../cac/Attachment.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/IssuerParty.dart';
import '../cac/ResultOfVerification.dart';

// A class to define a reference to a document.
class ShipmentDocumentReference {


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

  ShipmentDocumentReference ({
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
}

