import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/CopyIndicator.dart';
import '../cbc/UUID.dart';
import '../cbc/IssueDate.dart';
import '../cbc/IssueTime.dart';
import '../cbc/DocumentTypeCode.dart';
import '../cbc/DocumentType.dart';
import '../cbc/XPath.dart';
import '../cbc/ReferencedDocumentInternalAddress.dart';
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
class DespatchDocumentReference {


  // An identifier for the referenced document.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
  final List<DocumentType> documentType;

  // An unambiguous location within the bounding document or the document referenced by the parent DocumentReference, expressed as an XPath
  final List<XPath> xPath;

  // A pointer to a location within the document being referenced
  final ReferencedDocumentInternalAddress? referencedDocumentInternalAddress;

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

  DespatchDocumentReference ({
    required this.iD,
    this.uBLExtensions,
    this.copyIndicator,
    this.uUID,
    this.issueDate,
    this.issueTime,
    this.documentTypeCode,
    this.documentType = const [],
    this.xPath = const [],
    this.referencedDocumentInternalAddress,
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

  static DespatchDocumentReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DespatchDocumentReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      copyIndicator: CopyIndicator.fromJson(json['copyIndicator'] as Map<String, dynamic>?),
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      issueDate: IssueDate.fromJson(json['issueDate'] as Map<String, dynamic>?),
      issueTime: IssueTime.fromJson(json['issueTime'] as Map<String, dynamic>?),
      documentTypeCode: DocumentTypeCode.fromJson(json['documentTypeCode'] as Map<String, dynamic>?),
      documentType: (json['documentType'] as List? ?? []).map((dynamic d) => DocumentType.fromJson(d as Map<String, dynamic>?)!).toList(),
      xPath: (json['xPath'] as List? ?? []).map((dynamic d) => XPath.fromJson(d as Map<String, dynamic>?)!).toList(),
      referencedDocumentInternalAddress: ReferencedDocumentInternalAddress.fromJson(json['referencedDocumentInternalAddress'] as Map<String, dynamic>?),
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'copyIndicator': copyIndicator?.toJson(),
      'uUID': uUID?.toJson(),
      'issueDate': issueDate?.toJson(),
      'issueTime': issueTime?.toJson(),
      'documentTypeCode': documentTypeCode?.toJson(),
      'documentType': documentType.map((e) => e.toJson()).toList(),
      'xPath': xPath.map((e) => e.toJson()).toList(),
      'referencedDocumentInternalAddress': referencedDocumentInternalAddress?.toJson(),
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

  static DespatchDocumentReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return DespatchDocumentReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      copyIndicator: CopyIndicator.fromXml(xml.findElements('cbc:CopyIndicator').singleOrNull),
      uUID: UUID.fromXml(xml.findElements('cbc:UUID').singleOrNull),
      issueDate: IssueDate.fromXml(xml.findElements('cbc:IssueDate').singleOrNull),
      issueTime: IssueTime.fromXml(xml.findElements('cbc:IssueTime').singleOrNull),
      documentTypeCode: DocumentTypeCode.fromXml(xml.findElements('cbc:DocumentTypeCode').singleOrNull),
      documentType: xml.findElements('cbc:DocumentType').map((XmlElement e) => DocumentType.fromXml(e)!).toList(),
      xPath: xml.findElements('cbc:XPath').map((XmlElement e) => XPath.fromXml(e)!).toList(),
      referencedDocumentInternalAddress: ReferencedDocumentInternalAddress.fromXml(xml.findElements('cbc:ReferencedDocumentInternalAddress').singleOrNull),
      languageID: LanguageID.fromXml(xml.findElements('cbc:LanguageID').singleOrNull),
      localeCode: LocaleCode.fromXml(xml.findElements('cbc:LocaleCode').singleOrNull),
      versionID: VersionID.fromXml(xml.findElements('cbc:VersionID').singleOrNull),
      documentStatusCode: DocumentStatusCode.fromXml(xml.findElements('cbc:DocumentStatusCode').singleOrNull),
      documentDescription: xml.findElements('cbc:DocumentDescription').map((XmlElement e) => DocumentDescription.fromXml(e)!).toList(),
      attachment: Attachment.fromXml(xml.findElements('cac:Attachment').singleOrNull),
      validityPeriod: ValidityPeriod.fromXml(xml.findElements('cac:ValidityPeriod').singleOrNull),
      issuerParty: IssuerParty.fromXml(xml.findElements('cac:IssuerParty').singleOrNull),
      resultOfVerification: ResultOfVerification.fromXml(xml.findElements('cac:ResultOfVerification').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      copyIndicator?.toXml(),
      uUID?.toXml(),
      issueDate?.toXml(),
      issueTime?.toXml(),
      documentTypeCode?.toXml(),
      ...documentType.map((DocumentType e) => e.toXml()).toList(),
      ...xPath.map((XPath e) => e.toXml()).toList(),
      referencedDocumentInternalAddress?.toXml(),
      languageID?.toXml(),
      localeCode?.toXml(),
      versionID?.toXml(),
      documentStatusCode?.toXml(),
      ...documentDescription.map((DocumentDescription e) => e.toXml()).toList(),
      attachment?.toXml(),
      validityPeriod?.toXml(),
      issuerParty?.toXml(),
      resultOfVerification?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'DespatchDocumentReference',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

