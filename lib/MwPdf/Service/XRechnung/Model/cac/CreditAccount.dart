import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/AccountID.dart';

// A class to identify a credit account for sales on account.
class CreditAccount {


  // An identifier for this credit account.
  final AccountID accountID;

  CreditAccount ({
    required this.accountID,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'accountID': accountID.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CreditAccount? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CreditAccount (
      accountID: AccountID.fromJson(json['accountID'] as Map<String, dynamic>?)!,
    );
  }

  static CreditAccount? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return CreditAccount (
      accountID: null,
    );
  }

}

