// A number of monetary units specified using a given unit of currency.
class TotalInvoiceAmount {

  final String value; // (decimal)

  // The currency of the amount.
  final String currencyID; // (normalizedString)

  // The VersionID of the UN/ECE Rec9 code list.
  final String? currencyCodeListVersionID; // (normalizedString)

  TotalInvoiceAmount ({
    required this.value,
    required this.currencyID,
    this.currencyCodeListVersionID,
  });
}

