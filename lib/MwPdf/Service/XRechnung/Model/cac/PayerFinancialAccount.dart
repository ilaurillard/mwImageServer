import 'dart:convert';
import '../../Etc/Util.dart';
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
class PayerFinancialAccount {


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

  PayerFinancialAccount ({
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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


  PayerFinancialAccount fromJson(Map<String, dynamic> json) {
    return PayerFinancialAccount (
    );
  }

}

