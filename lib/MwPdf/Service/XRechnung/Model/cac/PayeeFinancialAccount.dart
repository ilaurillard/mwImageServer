import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/AliasName.dart';
import '../cbc/AccountTypeCode.dart';
import '../cbc/AccountFormatCode.dart';
import '../cbc/CurrencyCode.dart';
import '../cbc/PaymentNote.dart';
import '../cac/FinancialInstitutionBranch.dart';
import '../cac/Country.dart';

// A class to describe a financial account.
class PayeeFinancialAccount {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The identifier for this financial account; the bank account number.
  final ID? iD;

  // The name of this financial account.
  final Name? name;

  // An alias for the name of this financial account, to be used in place of the actual account name for security reasons.
  final AliasName? aliasName;

  // A code signifying the type of this financial account.
  final AccountTypeCode? accountTypeCode;

  // A code signifying the format of this financial account.
  final AccountFormatCode? accountFormatCode;

  // A code signifying the currency in which this financial account is held.
  final CurrencyCode? currencyCode;

  // Free-form text applying to the Payment for the owner of this account.
  final List<PaymentNote> paymentNote;

  // The branch of the financial institution associated with this financial account.
  final FinancialInstitutionBranch? financialInstitutionBranch;

  // The country in which the holder of the financial account is domiciled.
  final Country? country;

  PayeeFinancialAccount ({
    this.uBLExtensions,
    this.iD,
    this.name,
    this.aliasName,
    this.accountTypeCode,
    this.accountFormatCode,
    this.currencyCode,
    this.paymentNote = const [],
    this.financialInstitutionBranch,
    this.country,
  });

  static PayeeFinancialAccount? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PayeeFinancialAccount (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      aliasName: AliasName.fromJson(json['aliasName'] as Map<String, dynamic>?),
      accountTypeCode: AccountTypeCode.fromJson(json['accountTypeCode'] as Map<String, dynamic>?),
      accountFormatCode: AccountFormatCode.fromJson(json['accountFormatCode'] as Map<String, dynamic>?),
      currencyCode: CurrencyCode.fromJson(json['currencyCode'] as Map<String, dynamic>?),
      paymentNote: (json['paymentNote'] as List? ?? []).map((dynamic d) => PaymentNote.fromJson(d as Map<String, dynamic>?)!).toList(),
      financialInstitutionBranch: FinancialInstitutionBranch.fromJson(json['financialInstitutionBranch'] as Map<String, dynamic>?),
      country: Country.fromJson(json['country'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'aliasName': aliasName?.toJson(),
      'accountTypeCode': accountTypeCode?.toJson(),
      'accountFormatCode': accountFormatCode?.toJson(),
      'currencyCode': currencyCode?.toJson(),
      'paymentNote': paymentNote.map((e) => e.toJson()).toList(),
      'financialInstitutionBranch': financialInstitutionBranch?.toJson(),
      'country': country?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PayeeFinancialAccount? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PayeeFinancialAccount (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      aliasName: AliasName.fromXml(xml.findElements('cbc:AliasName').singleOrNull),
      accountTypeCode: AccountTypeCode.fromXml(xml.findElements('cbc:AccountTypeCode').singleOrNull),
      accountFormatCode: AccountFormatCode.fromXml(xml.findElements('cbc:AccountFormatCode').singleOrNull),
      currencyCode: CurrencyCode.fromXml(xml.findElements('cbc:CurrencyCode').singleOrNull),
      paymentNote: xml.findElements('cbc:PaymentNote').map((XmlElement e) => PaymentNote.fromXml(e)!).toList(),
      financialInstitutionBranch: FinancialInstitutionBranch.fromXml(xml.findElements('cac:FinancialInstitutionBranch').singleOrNull),
      country: Country.fromXml(xml.findElements('cac:Country').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'PayeeFinancialAccount',
        'cac',
      ),
    );
  }
}

