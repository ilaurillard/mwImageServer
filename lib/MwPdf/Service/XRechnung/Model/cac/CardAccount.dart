import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/PrimaryAccountNumberID.dart';
import '../cbc/NetworkID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/CardTypeCode.dart';
import '../cbc/ValidityStartDate.dart';
import '../cbc/ExpiryDate.dart';
import '../cbc/IssuerID.dart';
import '../cbc/IssueNumberID.dart';
import '../cbc/CV2ID.dart';
import '../cbc/CardChipCode.dart';
import '../cbc/ChipApplicationID.dart';
import '../cbc/HolderName.dart';
import '../cbc/RoleCode.dart';

// A class to define a credit card, debit card, or charge card account.
class CardAccount {


  // An identifier of the card (e.g., the Primary Account Number (PAN)).
  final PrimaryAccountNumberID primaryAccountNumberID;

  // An identifier for the financial service network provider of the card.
  final NetworkID networkID;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A mutually agreed code signifying the type of card. Examples of types are "debit", "credit" and "purchasing"
  final CardTypeCode? cardTypeCode;

  // The date from which the card is valid.
  final ValidityStartDate? validityStartDate;

  // The date on which the card expires.
  final ExpiryDate? expiryDate;

  // An identifier for the institution issuing the card.
  final IssuerID? issuerID;

  // An identifier for the card, specified by the issuer.
  final IssueNumberID? issueNumberID;

  // An identifier for the Card Verification Value (often found on the reverse of the card itself).
  final CV2ID? cV2ID;

  // A mutually agreed code to distinguish between CHIP and MAG STRIPE cards.
  final CardChipCode? cardChipCode;

  // An identifier on the chip card for the application that provides the quoted information; an AID (application ID).
  final ChipApplicationID? chipApplicationID;

  // The name of the cardholder.
  final HolderName? holderName;

  // The role of this card or the card holder (e.g., the buyer, when the card is used as a payment means to pay for an item), expressed as a code.
  final RoleCode? roleCode;

  CardAccount ({
    required this.primaryAccountNumberID,
    required this.networkID,
    this.uBLExtensions,
    this.cardTypeCode,
    this.validityStartDate,
    this.expiryDate,
    this.issuerID,
    this.issueNumberID,
    this.cV2ID,
    this.cardChipCode,
    this.chipApplicationID,
    this.holderName,
    this.roleCode,
  });

  static CardAccount? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CardAccount (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      primaryAccountNumberID: PrimaryAccountNumberID.fromJson(json['primaryAccountNumberID'] as Map<String, dynamic>?)!,
      networkID: NetworkID.fromJson(json['networkID'] as Map<String, dynamic>?)!,
      cardTypeCode: CardTypeCode.fromJson(json['cardTypeCode'] as Map<String, dynamic>?),
      validityStartDate: ValidityStartDate.fromJson(json['validityStartDate'] as Map<String, dynamic>?),
      expiryDate: ExpiryDate.fromJson(json['expiryDate'] as Map<String, dynamic>?),
      issuerID: IssuerID.fromJson(json['issuerID'] as Map<String, dynamic>?),
      issueNumberID: IssueNumberID.fromJson(json['issueNumberID'] as Map<String, dynamic>?),
      cV2ID: CV2ID.fromJson(json['cV2ID'] as Map<String, dynamic>?),
      cardChipCode: CardChipCode.fromJson(json['cardChipCode'] as Map<String, dynamic>?),
      chipApplicationID: ChipApplicationID.fromJson(json['chipApplicationID'] as Map<String, dynamic>?),
      holderName: HolderName.fromJson(json['holderName'] as Map<String, dynamic>?),
      roleCode: RoleCode.fromJson(json['roleCode'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'primaryAccountNumberID': primaryAccountNumberID.toJson(),
      'networkID': networkID.toJson(),
      'cardTypeCode': cardTypeCode?.toJson(),
      'validityStartDate': validityStartDate?.toJson(),
      'expiryDate': expiryDate?.toJson(),
      'issuerID': issuerID?.toJson(),
      'issueNumberID': issueNumberID?.toJson(),
      'cV2ID': cV2ID?.toJson(),
      'cardChipCode': cardChipCode?.toJson(),
      'chipApplicationID': chipApplicationID?.toJson(),
      'holderName': holderName?.toJson(),
      'roleCode': roleCode?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CardAccount? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return CardAccount (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      primaryAccountNumberID: PrimaryAccountNumberID.fromXml(xml.findElements('cbc:PrimaryAccountNumberID').singleOrNull)!,
      networkID: NetworkID.fromXml(xml.findElements('cbc:NetworkID').singleOrNull)!,
      cardTypeCode: CardTypeCode.fromXml(xml.findElements('cbc:CardTypeCode').singleOrNull),
      validityStartDate: ValidityStartDate.fromXml(xml.findElements('cbc:ValidityStartDate').singleOrNull),
      expiryDate: ExpiryDate.fromXml(xml.findElements('cbc:ExpiryDate').singleOrNull),
      issuerID: IssuerID.fromXml(xml.findElements('cbc:IssuerID').singleOrNull),
      issueNumberID: IssueNumberID.fromXml(xml.findElements('cbc:IssueNumberID').singleOrNull),
      cV2ID: CV2ID.fromXml(xml.findElements('cbc:CV2ID').singleOrNull),
      cardChipCode: CardChipCode.fromXml(xml.findElements('cbc:CardChipCode').singleOrNull),
      chipApplicationID: ChipApplicationID.fromXml(xml.findElements('cbc:ChipApplicationID').singleOrNull),
      holderName: HolderName.fromXml(xml.findElements('cbc:HolderName').singleOrNull),
      roleCode: RoleCode.fromXml(xml.findElements('cbc:RoleCode').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      primaryAccountNumberID.toXml(),
      networkID.toXml(),
      cardTypeCode?.toXml(),
      validityStartDate?.toXml(),
      expiryDate?.toXml(),
      issuerID?.toXml(),
      issueNumberID?.toXml(),
      cV2ID?.toXml(),
      cardChipCode?.toXml(),
      chipApplicationID?.toXml(),
      holderName?.toXml(),
      roleCode?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'CardAccount',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

