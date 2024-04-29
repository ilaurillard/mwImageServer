import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/RegistrationName.dart';
import '../cbc/CompanyID.dart';
import '../cbc/RegistrationDate.dart';
import '../cbc/RegistrationExpirationDate.dart';
import '../cbc/CompanyLegalFormCode.dart';
import '../cbc/CompanyLegalForm.dart';
import '../cbc/SoleProprietorshipIndicator.dart';
import '../cbc/CompanyLiquidationStatusCode.dart';
import '../cbc/CorporateStockAmount.dart';
import '../cbc/FullyPaidSharesIndicator.dart';
import '../cac/RegistrationAddress.dart';
import '../cac/CorporateRegistrationScheme.dart';
import '../cac/HeadOfficeParty.dart';
import '../cac/ShareholderParty.dart';

// A class to describe a party as a legal entity.
class PartyLegalEntity {


  // The name of the party as registered with the relevant legal authority.
  final RegistrationName? registrationName;

  // An identifier for the party as registered within a company registration scheme.
  final CompanyID? companyID;

  // The registration date of the CompanyID.
  final RegistrationDate? registrationDate;

  // The date upon which a registration expires (e.g., registration for an import/export license).
  final RegistrationExpirationDate? registrationExpirationDate;

  // A code signifying the party's legal status.
  final CompanyLegalFormCode? companyLegalFormCode;

  // The company legal status, expressed as a text.
  final CompanyLegalForm? companyLegalForm;

  // An indicator that the company is owned and controlled by one person (true) or not (false).
  final SoleProprietorshipIndicator? soleProprietorshipIndicator;

  // A code signifying the party's liquidation status.
  final CompanyLiquidationStatusCode? companyLiquidationStatusCode;

  // The number of shares in the capital stock of a corporation.
  final CorporateStockAmount? corporateStockAmount;

  // An indicator that all shares of corporate stock have been paid by shareholders (true) or not (false).
  final FullyPaidSharesIndicator? fullyPaidSharesIndicator;

  // The registered address of the party within a corporate registration scheme.
  final RegistrationAddress? registrationAddress;

  // The corporate registration scheme used to register the party.
  final CorporateRegistrationScheme? corporateRegistrationScheme;

  // The head office of the legal entity
  final HeadOfficeParty? headOfficeParty;

  // A party owning shares in this legal entity.
  final List<ShareholderParty> shareholderParty;

  PartyLegalEntity ({
    this.registrationName,
    this.companyID,
    this.registrationDate,
    this.registrationExpirationDate,
    this.companyLegalFormCode,
    this.companyLegalForm,
    this.soleProprietorshipIndicator,
    this.companyLiquidationStatusCode,
    this.corporateStockAmount,
    this.fullyPaidSharesIndicator,
    this.registrationAddress,
    this.corporateRegistrationScheme,
    this.headOfficeParty,
    this.shareholderParty = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'registrationName': registrationName?.toJson(),
     'companyID': companyID?.toJson(),
     'registrationDate': registrationDate?.toJson(),
     'registrationExpirationDate': registrationExpirationDate?.toJson(),
     'companyLegalFormCode': companyLegalFormCode?.toJson(),
     'companyLegalForm': companyLegalForm?.toJson(),
     'soleProprietorshipIndicator': soleProprietorshipIndicator?.toJson(),
     'companyLiquidationStatusCode': companyLiquidationStatusCode?.toJson(),
     'corporateStockAmount': corporateStockAmount?.toJson(),
     'fullyPaidSharesIndicator': fullyPaidSharesIndicator?.toJson(),
     'registrationAddress': registrationAddress?.toJson(),
     'corporateRegistrationScheme': corporateRegistrationScheme?.toJson(),
     'headOfficeParty': headOfficeParty?.toJson(),
     'shareholderParty': shareholderParty.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  PartyLegalEntity fromJson(Map<String, dynamic> json) {
    return PartyLegalEntity (
    );
  }

}

