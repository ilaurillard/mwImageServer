import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cac/TaxScheme.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/RegistrationName.dart';
import '../cbc/CompanyID.dart';
import '../cbc/TaxLevelCode.dart';
import '../cbc/ExemptionReasonCode.dart';
import '../cbc/ExemptionReason.dart';
import '../cac/RegistrationAddress.dart';

// A class to describe a taxation scheme applying to a party.
class PartyTaxScheme {


  // The taxation scheme applicable to the party.
  final TaxScheme taxScheme;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The name of the party as registered with the relevant fiscal authority.
  final RegistrationName? registrationName;

  // An identifier for the party assigned for tax purposes by the taxation authority.
  final CompanyID? companyID;

  // A code signifying the tax level applicable to the party within this taxation scheme.
  final TaxLevelCode? taxLevelCode;

  // A reason for the party's exemption from tax, expressed as a code.
  final ExemptionReasonCode? exemptionReasonCode;

  // A reason for the party's exemption from tax, expressed as text.
  final List<ExemptionReason> exemptionReason;

  // The address of the party as registered for tax purposes.
  final RegistrationAddress? registrationAddress;

  PartyTaxScheme ({
    required this.taxScheme,
    this.uBLExtensions,
    this.registrationName,
    this.companyID,
    this.taxLevelCode,
    this.exemptionReasonCode,
    this.exemptionReason = const [],
    this.registrationAddress,
  });

  static PartyTaxScheme? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PartyTaxScheme (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      registrationName: RegistrationName.fromJson(json['registrationName'] as Map<String, dynamic>?),
      companyID: CompanyID.fromJson(json['companyID'] as Map<String, dynamic>?),
      taxLevelCode: TaxLevelCode.fromJson(json['taxLevelCode'] as Map<String, dynamic>?),
      exemptionReasonCode: ExemptionReasonCode.fromJson(json['exemptionReasonCode'] as Map<String, dynamic>?),
      exemptionReason: (json['exemptionReason'] as List? ?? []).map((dynamic d) => ExemptionReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      registrationAddress: RegistrationAddress.fromJson(json['registrationAddress'] as Map<String, dynamic>?),
      taxScheme: TaxScheme.fromJson(json['taxScheme'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'registrationName': registrationName?.toJson(),
      'companyID': companyID?.toJson(),
      'taxLevelCode': taxLevelCode?.toJson(),
      'exemptionReasonCode': exemptionReasonCode?.toJson(),
      'exemptionReason': exemptionReason.map((e) => e.toJson()).toList(),
      'registrationAddress': registrationAddress?.toJson(),
      'taxScheme': taxScheme.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PartyTaxScheme? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PartyTaxScheme (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      registrationName: RegistrationName.fromXml(xml.findElements('cbc:RegistrationName').singleOrNull),
      companyID: CompanyID.fromXml(xml.findElements('cbc:CompanyID').singleOrNull),
      taxLevelCode: TaxLevelCode.fromXml(xml.findElements('cbc:TaxLevelCode').singleOrNull),
      exemptionReasonCode: ExemptionReasonCode.fromXml(xml.findElements('cbc:ExemptionReasonCode').singleOrNull),
      exemptionReason: xml.findElements('cbc:ExemptionReason').map((XmlElement e) => ExemptionReason.fromXml(e)!).toList(),
      registrationAddress: RegistrationAddress.fromXml(xml.findElements('cac:RegistrationAddress').singleOrNull),
      taxScheme: TaxScheme.fromXml(xml.findElements('cac:TaxScheme').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      registrationName?.toXml(),
      companyID?.toXml(),
      taxLevelCode?.toXml(),
      exemptionReasonCode?.toXml(),
      ...exemptionReason.map((ExemptionReason e) => e.toXml()).toList(),
      registrationAddress?.toXml(),
      taxScheme.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PartyTaxScheme',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

