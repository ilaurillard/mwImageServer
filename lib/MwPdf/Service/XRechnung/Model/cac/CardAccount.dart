import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/PrimaryAccountNumberID.dart';
import '../cbc/NetworkID.dart';
import '../cbc/CardTypeCode.dart';
import '../cbc/ValidityStartDate.dart';
import '../cbc/ExpiryDate.dart';
import '../cbc/IssuerID.dart';
import '../cbc/IssueNumberID.dart';
import '../cbc/CV2ID.dart';
import '../cbc/CardChipCode.dart';
import '../cbc/ChipApplicationID.dart';
import '../cbc/HolderName.dart';

// A class to define a credit card, debit card, or charge card account.
class CardAccount {


  // An identifier of the card (e.g., the Primary Account Number (PAN)).
  final PrimaryAccountNumberID primaryAccountNumberID;

  // An identifier for the financial service network provider of the card.
  final NetworkID networkID;

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

  CardAccount ({
    required this.primaryAccountNumberID,
    required this.networkID,
    this.cardTypeCode,
    this.validityStartDate,
    this.expiryDate,
    this.issuerID,
    this.issueNumberID,
    this.cV2ID,
    this.cardChipCode,
    this.chipApplicationID,
    this.holderName,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CardAccount? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CardAccount (
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
    );
  }

  static CardAccount? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return CardAccount (
      primaryAccountNumberID: null,
      networkID: null,
      cardTypeCode: null,
      validityStartDate: null,
      expiryDate: null,
      issuerID: null,
      issueNumberID: null,
      cV2ID: null,
      cardChipCode: null,
      chipApplicationID: null,
      holderName: null,
    );
  }

}

