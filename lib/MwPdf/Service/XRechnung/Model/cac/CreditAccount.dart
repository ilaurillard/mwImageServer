import 'dart:convert';
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

}

