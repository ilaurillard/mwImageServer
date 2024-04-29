import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/CertificateTypeCode.dart';
import '../cbc/CertificateType.dart';
import '../cac/IssuerParty.dart';
import '../cbc/Remarks.dart';
import '../cac/DocumentReference.dart';
import '../cac/Signature.dart';

// A class to define a certificate applied to the item. Certificated can be a requirement to sell goods or services in a jurisdiction.
class Certificate {


  // An identifier for this certificate.
  final ID iD;

  // The type of this certificate, expressed as a code. The type specifies what array it belongs to, e.g.. Environmental, security, health improvement etc.
  final CertificateTypeCode certificateTypeCode;

  // The type of this certificate, expressed as a code. The type specifies what array it belongs to, e.g.. Environmental, security, health improvement etc.
  final CertificateType certificateType;

  // The authorized organization that issued this certificate, the provider of the certificate.
  final IssuerParty issuerParty;

  // Remarks by the applicant for this certificate.
  final List<Remarks> remarks;

  // A reference to a document relevant to this certificate or an application for this certificate.
  final List<DocumentReference> documentReference;

  // A signature applied to this certificate.
  final List<Signature> signature;

  Certificate ({
    required this.iD,
    required this.certificateTypeCode,
    required this.certificateType,
    required this.issuerParty,
    this.remarks = const [],
    this.documentReference = const [],
    this.signature = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
      'certificateTypeCode': certificateTypeCode.toJson(),
      'certificateType': certificateType.toJson(),
      'remarks': remarks.map((e) => e.toJson()).toList(),
      'issuerParty': issuerParty.toJson(),
      'documentReference': documentReference.map((e) => e.toJson()).toList(),
      'signature': signature.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Certificate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Certificate (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      certificateTypeCode: CertificateTypeCode.fromJson(json['certificateTypeCode'] as Map<String, dynamic>?)!,
      certificateType: CertificateType.fromJson(json['certificateType'] as Map<String, dynamic>?)!,
      remarks: (json['remarks'] as List? ?? []).map((dynamic d) => Remarks.fromJson(d as Map<String, dynamic>?)!).toList(),
      issuerParty: IssuerParty.fromJson(json['issuerParty'] as Map<String, dynamic>?)!,
      documentReference: (json['documentReference'] as List? ?? []).map((dynamic d) => DocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      signature: (json['signature'] as List? ?? []).map((dynamic d) => Signature.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static Certificate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return Certificate (
      iD: null,
      certificateTypeCode: null,
      certificateType: null,
      remarks: null,
      issuerParty: null,
      documentReference: null,
      signature: null,
    );
  }

}

