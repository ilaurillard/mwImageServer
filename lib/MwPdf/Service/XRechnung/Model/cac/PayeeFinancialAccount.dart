import '../cac/ID.dart';
import '../cac/Name.dart';
import '../cac/AliasName.dart';
import '../cac/AccountTypeCode.dart';
import '../cac/AccountFormatCode.dart';
import '../cac/CurrencyCode.dart';
import '../cac/PaymentNote.dart';
import '../cac/FinancialInstitutionBranch.dart';
import '../cac/Country.dart';

// A class to describe a financial account.
class PayeeFinancialAccount {


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
}

