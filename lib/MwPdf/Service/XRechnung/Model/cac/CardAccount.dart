import 'dart:convert';
import '../../Etc/Util.dart';
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


  CardAccount fromJson(Map<String, dynamic> json) {
    return CardAccount (
    );
  }

}

