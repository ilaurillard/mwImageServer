import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/CertificateTypeCode.dart';
import '../cbc/CertificateType.dart';
import '../cbc/Remarks.dart';
import '../cac/IssuerParty.dart';
import '../cac/DocumentReference.dart';
import '../cac/Signature.dart';

// A class to define a certificate applied to the item. Certificated can be a requirement to sell goods or services in a jurisdiction.
class MedicalCertificate {


  // An identifier for this certificate.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The type of this certificate, expressed as a code. The type specifies what array it belongs to, e.g.. Environmental, security, health improvement etc.
  final CertificateTypeCode? certificateTypeCode;

  // The type of this certificate, expressed as a text.
  final List<CertificateType> certificateType;

  // Remarks by the applicant for this certificate.
  final List<Remarks> remarks;

  // The authorized organization that issued this certificate, the provider of the certificate.
  final IssuerParty? issuerParty;

  // A reference to a document relevant to this certificate or an application for this certificate.
  final List<DocumentReference> documentReference;

  // A signature applied to this certificate.
  final List<Signature> signature;

  MedicalCertificate ({
    required this.iD,
    this.uBLExtensions,
    this.certificateTypeCode,
    this.certificateType = const [],
    this.remarks = const [],
    this.issuerParty,
    this.documentReference = const [],
    this.signature = const [],
  });

  static MedicalCertificate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return MedicalCertificate (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      certificateTypeCode: CertificateTypeCode.fromJson(json['certificateTypeCode'] as Map<String, dynamic>?),
      certificateType: (json['certificateType'] as List? ?? []).map((dynamic d) => CertificateType.fromJson(d as Map<String, dynamic>?)!).toList(),
      remarks: (json['remarks'] as List? ?? []).map((dynamic d) => Remarks.fromJson(d as Map<String, dynamic>?)!).toList(),
      issuerParty: IssuerParty.fromJson(json['issuerParty'] as Map<String, dynamic>?),
      documentReference: (json['documentReference'] as List? ?? []).map((dynamic d) => DocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      signature: (json['signature'] as List? ?? []).map((dynamic d) => Signature.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'certificateTypeCode': certificateTypeCode?.toJson(),
      'certificateType': certificateType.map((e) => e.toJson()).toList(),
      'remarks': remarks.map((e) => e.toJson()).toList(),
      'issuerParty': issuerParty?.toJson(),
      'documentReference': documentReference.map((e) => e.toJson()).toList(),
      'signature': signature.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static MedicalCertificate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return MedicalCertificate (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      certificateTypeCode: CertificateTypeCode.fromXml(xml.findElements('cbc:CertificateTypeCode').singleOrNull),
      certificateType: xml.findElements('cbc:CertificateType').map((XmlElement e) => CertificateType.fromXml(e)!).toList(),
      remarks: xml.findElements('cbc:Remarks').map((XmlElement e) => Remarks.fromXml(e)!).toList(),
      issuerParty: IssuerParty.fromXml(xml.findElements('cac:IssuerParty').singleOrNull),
      documentReference: xml.findElements('cac:DocumentReference').map((XmlElement e) => DocumentReference.fromXml(e)!).toList(),
      signature: xml.findElements('cac:Signature').map((XmlElement e) => Signature.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      certificateTypeCode?.toXml(),
      ...certificateType.map((CertificateType e) => e.toXml()).toList(),
      ...remarks.map((Remarks e) => e.toXml()).toList(),
      issuerParty?.toXml(),
      ...documentReference.map((DocumentReference e) => e.toXml()).toList(),
      ...signature.map((Signature e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'MedicalCertificate',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

