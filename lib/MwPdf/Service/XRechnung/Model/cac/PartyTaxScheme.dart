import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cac/TaxScheme.dart';
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
    this.registrationName,
    this.companyID,
    this.taxLevelCode,
    this.exemptionReasonCode,
    this.exemptionReason = const [],
    this.registrationAddress,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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

  static PartyTaxScheme? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PartyTaxScheme (
      registrationName: RegistrationName.fromJson(json['registrationName'] as Map<String, dynamic>?),
      companyID: CompanyID.fromJson(json['companyID'] as Map<String, dynamic>?),
      taxLevelCode: TaxLevelCode.fromJson(json['taxLevelCode'] as Map<String, dynamic>?),
      exemptionReasonCode: ExemptionReasonCode.fromJson(json['exemptionReasonCode'] as Map<String, dynamic>?),
      exemptionReason: (json['exemptionReason'] as List? ?? []).map((dynamic d) => ExemptionReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      registrationAddress: RegistrationAddress.fromJson(json['registrationAddress'] as Map<String, dynamic>?),
      taxScheme: TaxScheme.fromJson(json['taxScheme'] as Map<String, dynamic>?)!,
    );
  }

  static PartyTaxScheme? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return PartyTaxScheme (
      registrationName: null,
      companyID: null,
      taxLevelCode: null,
      exemptionReasonCode: null,
      exemptionReason: null,
      registrationAddress: null,
      taxScheme: null,
    );
  }

}

