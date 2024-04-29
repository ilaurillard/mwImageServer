import '../cac/RegistrationName.dart';
import '../cac/CompanyID.dart';
import '../cac/TaxLevelCode.dart';
import '../cac/ExemptionReasonCode.dart';
import '../cac/ExemptionReason.dart';
import '../cac/RegistrationAddress.dart';
import '../cac/TaxScheme.dart';

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
}

