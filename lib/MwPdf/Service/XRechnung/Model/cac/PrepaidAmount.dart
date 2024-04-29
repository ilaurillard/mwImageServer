// A number of monetary units specified using a given unit of currency.
class PrepaidAmount {

  final String value; // (decimal)

  // The currency of the amount.
  final String currencyID; // (normalizedString)

  // The VersionID of the UN/ECE Rec9 code list.
  final String? currencyCodeListVersionID; // (normalizedString)

  PrepaidAmount ({
    required this.value,
    required this.currencyID,
    this.currencyCodeListVersionID,
  });
}

