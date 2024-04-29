import '../cac/ID.dart';
import '../cac/CertificateTypeCode.dart';
import '../cac/CertificateType.dart';
import '../cac/Remarks.dart';
import '../cac/IssuerParty.dart';
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
}

