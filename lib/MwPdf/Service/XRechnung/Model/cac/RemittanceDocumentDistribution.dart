import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cac/Party.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/DocumentTypeCode.dart';
import '../cbc/DistributionTypeCode.dart';
import '../cbc/DistributionType.dart';
import '../cbc/PrintQualifier.dart';
import '../cbc/CopyIndicator.dart';
import '../cbc/MaximumCopiesNumeric.dart';
import '../cbc/MaximumOriginalsNumeric.dart';
import '../cac/Communication.dart';

// A class to describe the distribution of a document to an interested party.
class RemittanceDocumentDistribution {


  // The interested party to which the document should be distributed.
  final Party party;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this document distribution.
  final ID? iD;

  // The type of document, expressed as a code.
  final DocumentTypeCode? documentTypeCode;

  // The type of distribution, expressed as a code.
  final DistributionTypeCode? distributionTypeCode;

  // The type of distribution, expressed as text.
  final List<DistributionType> distributionType;

  // Text describing the interested partyâs rights and limitations for distributing originals and copies of this document.
  final PrintQualifier? printQualifier;

  // An indicator that the document in this ditribution is a copy (true) or the original (false).
  final CopyIndicator? copyIndicator;

  // The maximum number of printed copies of the document that the interested party is allowed to make.
  final MaximumCopiesNumeric? maximumCopiesNumeric;

  // The maximum number of printed originals of the document that the interested party is allowed to make.
  final MaximumOriginalsNumeric? maximumOriginalsNumeric;

  // A Communication used for this document distribution.
  final Communication? communication;

  RemittanceDocumentDistribution ({
    required this.party,
    this.uBLExtensions,
    this.iD,
    this.documentTypeCode,
    this.distributionTypeCode,
    this.distributionType = const [],
    this.printQualifier,
    this.copyIndicator,
    this.maximumCopiesNumeric,
    this.maximumOriginalsNumeric,
    this.communication,
  });

  static RemittanceDocumentDistribution? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return RemittanceDocumentDistribution (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      documentTypeCode: DocumentTypeCode.fromJson(json['documentTypeCode'] as Map<String, dynamic>?),
      distributionTypeCode: DistributionTypeCode.fromJson(json['distributionTypeCode'] as Map<String, dynamic>?),
      distributionType: (json['distributionType'] as List? ?? []).map((dynamic d) => DistributionType.fromJson(d as Map<String, dynamic>?)!).toList(),
      printQualifier: PrintQualifier.fromJson(json['printQualifier'] as Map<String, dynamic>?),
      copyIndicator: CopyIndicator.fromJson(json['copyIndicator'] as Map<String, dynamic>?),
      maximumCopiesNumeric: MaximumCopiesNumeric.fromJson(json['maximumCopiesNumeric'] as Map<String, dynamic>?),
      maximumOriginalsNumeric: MaximumOriginalsNumeric.fromJson(json['maximumOriginalsNumeric'] as Map<String, dynamic>?),
      communication: Communication.fromJson(json['communication'] as Map<String, dynamic>?),
      party: Party.fromJson(json['party'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'documentTypeCode': documentTypeCode?.toJson(),
      'distributionTypeCode': distributionTypeCode?.toJson(),
      'distributionType': distributionType.map((e) => e.toJson()).toList(),
      'printQualifier': printQualifier?.toJson(),
      'copyIndicator': copyIndicator?.toJson(),
      'maximumCopiesNumeric': maximumCopiesNumeric?.toJson(),
      'maximumOriginalsNumeric': maximumOriginalsNumeric?.toJson(),
      'communication': communication?.toJson(),
      'party': party.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static RemittanceDocumentDistribution? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return RemittanceDocumentDistribution (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      documentTypeCode: DocumentTypeCode.fromXml(xml.findElements('cbc:DocumentTypeCode').singleOrNull),
      distributionTypeCode: DistributionTypeCode.fromXml(xml.findElements('cbc:DistributionTypeCode').singleOrNull),
      distributionType: xml.findElements('cbc:DistributionType').map((XmlElement e) => DistributionType.fromXml(e)!).toList(),
      printQualifier: PrintQualifier.fromXml(xml.findElements('cbc:PrintQualifier').singleOrNull),
      copyIndicator: CopyIndicator.fromXml(xml.findElements('cbc:CopyIndicator').singleOrNull),
      maximumCopiesNumeric: MaximumCopiesNumeric.fromXml(xml.findElements('cbc:MaximumCopiesNumeric').singleOrNull),
      maximumOriginalsNumeric: MaximumOriginalsNumeric.fromXml(xml.findElements('cbc:MaximumOriginalsNumeric').singleOrNull),
      communication: Communication.fromXml(xml.findElements('cac:Communication').singleOrNull),
      party: Party.fromXml(xml.findElements('cac:Party').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      documentTypeCode?.toXml(),
      distributionTypeCode?.toXml(),
      ...distributionType.map((DistributionType e) => e.toXml()).toList(),
      printQualifier?.toXml(),
      copyIndicator?.toXml(),
      maximumCopiesNumeric?.toXml(),
      maximumOriginalsNumeric?.toXml(),
      communication?.toXml(),
      party.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'RemittanceDocumentDistribution',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

