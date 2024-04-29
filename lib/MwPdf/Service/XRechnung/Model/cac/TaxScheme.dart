import '../cac/ID.dart';
import '../cac/Name.dart';
import '../cac/TaxTypeCode.dart';
import '../cac/CurrencyCode.dart';
import '../cac/JurisdictionRegionAddress.dart';

// A class to describe a taxation scheme (e.g., VAT, State tax, County tax).
class TaxScheme {


  // An identifier for this taxation scheme.
  final ID? iD;

  // The name of this taxation scheme.
  final Name? name;

  // A code signifying the type of tax.
  final TaxTypeCode? taxTypeCode;

  // A code signifying the currency in which the tax is collected and reported.
  final CurrencyCode? currencyCode;

  // A geographic area in which this taxation scheme applies.
  final List<JurisdictionRegionAddress> jurisdictionRegionAddress;

  TaxScheme ({
    this.iD,
    this.name,
    this.taxTypeCode,
    this.currencyCode,
    this.jurisdictionRegionAddress = const [],
  });
}

