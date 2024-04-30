import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
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


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
  final List<CompanyLegalForm> companyLegalForm;

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
    this.uBLExtensions,
    this.registrationName,
    this.companyID,
    this.registrationDate,
    this.registrationExpirationDate,
    this.companyLegalFormCode,
    this.companyLegalForm = const [],
    this.soleProprietorshipIndicator,
    this.companyLiquidationStatusCode,
    this.corporateStockAmount,
    this.fullyPaidSharesIndicator,
    this.registrationAddress,
    this.corporateRegistrationScheme,
    this.headOfficeParty,
    this.shareholderParty = const [],
  });

  static PartyLegalEntity? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PartyLegalEntity (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      registrationName: RegistrationName.fromJson(json['registrationName'] as Map<String, dynamic>?),
      companyID: CompanyID.fromJson(json['companyID'] as Map<String, dynamic>?),
      registrationDate: RegistrationDate.fromJson(json['registrationDate'] as Map<String, dynamic>?),
      registrationExpirationDate: RegistrationExpirationDate.fromJson(json['registrationExpirationDate'] as Map<String, dynamic>?),
      companyLegalFormCode: CompanyLegalFormCode.fromJson(json['companyLegalFormCode'] as Map<String, dynamic>?),
      companyLegalForm: (json['companyLegalForm'] as List? ?? []).map((dynamic d) => CompanyLegalForm.fromJson(d as Map<String, dynamic>?)!).toList(),
      soleProprietorshipIndicator: SoleProprietorshipIndicator.fromJson(json['soleProprietorshipIndicator'] as Map<String, dynamic>?),
      companyLiquidationStatusCode: CompanyLiquidationStatusCode.fromJson(json['companyLiquidationStatusCode'] as Map<String, dynamic>?),
      corporateStockAmount: CorporateStockAmount.fromJson(json['corporateStockAmount'] as Map<String, dynamic>?),
      fullyPaidSharesIndicator: FullyPaidSharesIndicator.fromJson(json['fullyPaidSharesIndicator'] as Map<String, dynamic>?),
      registrationAddress: RegistrationAddress.fromJson(json['registrationAddress'] as Map<String, dynamic>?),
      corporateRegistrationScheme: CorporateRegistrationScheme.fromJson(json['corporateRegistrationScheme'] as Map<String, dynamic>?),
      headOfficeParty: HeadOfficeParty.fromJson(json['headOfficeParty'] as Map<String, dynamic>?),
      shareholderParty: (json['shareholderParty'] as List? ?? []).map((dynamic d) => ShareholderParty.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'registrationName': registrationName?.toJson(),
      'companyID': companyID?.toJson(),
      'registrationDate': registrationDate?.toJson(),
      'registrationExpirationDate': registrationExpirationDate?.toJson(),
      'companyLegalFormCode': companyLegalFormCode?.toJson(),
      'companyLegalForm': companyLegalForm.map((e) => e.toJson()).toList(),
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

  static PartyLegalEntity? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PartyLegalEntity (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      registrationName: RegistrationName.fromXml(xml.findElements('cbc:RegistrationName').singleOrNull),
      companyID: CompanyID.fromXml(xml.findElements('cbc:CompanyID').singleOrNull),
      registrationDate: RegistrationDate.fromXml(xml.findElements('cbc:RegistrationDate').singleOrNull),
      registrationExpirationDate: RegistrationExpirationDate.fromXml(xml.findElements('cbc:RegistrationExpirationDate').singleOrNull),
      companyLegalFormCode: CompanyLegalFormCode.fromXml(xml.findElements('cbc:CompanyLegalFormCode').singleOrNull),
      companyLegalForm: xml.findElements('cbc:CompanyLegalForm').map((XmlElement e) => CompanyLegalForm.fromXml(e)!).toList(),
      soleProprietorshipIndicator: SoleProprietorshipIndicator.fromXml(xml.findElements('cbc:SoleProprietorshipIndicator').singleOrNull),
      companyLiquidationStatusCode: CompanyLiquidationStatusCode.fromXml(xml.findElements('cbc:CompanyLiquidationStatusCode').singleOrNull),
      corporateStockAmount: CorporateStockAmount.fromXml(xml.findElements('cbc:CorporateStockAmount').singleOrNull),
      fullyPaidSharesIndicator: FullyPaidSharesIndicator.fromXml(xml.findElements('cbc:FullyPaidSharesIndicator').singleOrNull),
      registrationAddress: RegistrationAddress.fromXml(xml.findElements('cac:RegistrationAddress').singleOrNull),
      corporateRegistrationScheme: CorporateRegistrationScheme.fromXml(xml.findElements('cac:CorporateRegistrationScheme').singleOrNull),
      headOfficeParty: HeadOfficeParty.fromXml(xml.findElements('cac:HeadOfficeParty').singleOrNull),
      shareholderParty: xml.findElements('cac:ShareholderParty').map((XmlElement e) => ShareholderParty.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      registrationName?.toXml(),
      companyID?.toXml(),
      registrationDate?.toXml(),
      registrationExpirationDate?.toXml(),
      companyLegalFormCode?.toXml(),
      ...companyLegalForm.map((CompanyLegalForm e) => e.toXml()).toList(),
      soleProprietorshipIndicator?.toXml(),
      companyLiquidationStatusCode?.toXml(),
      corporateStockAmount?.toXml(),
      fullyPaidSharesIndicator?.toXml(),
      registrationAddress?.toXml(),
      corporateRegistrationScheme?.toXml(),
      headOfficeParty?.toXml(),
      ...shareholderParty.map((ShareholderParty e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PartyLegalEntity',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

