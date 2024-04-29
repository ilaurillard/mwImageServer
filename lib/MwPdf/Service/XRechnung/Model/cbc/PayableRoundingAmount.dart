import 'dart:convert';

// A number of monetary units specified using a given unit of currency.
class PayableRoundingAmount {

  final double value; // (decimal)

  // The currency of the amount.
  final String currencyID; // (normalizedString)

  // The VersionID of the UN/ECE Rec9 code list.
  final String? currencyCodeListVersionID; // (normalizedString)

  PayableRoundingAmount ({
    required this.value,
    required this.currencyID,
    this.currencyCodeListVersionID,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
     'currencyID': currencyID,
     'currencyCodeListVersionID': currencyCodeListVersionID,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

