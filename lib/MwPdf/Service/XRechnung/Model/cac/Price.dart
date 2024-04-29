import '../cac/PriceAmount.dart';
import '../cac/BaseQuantity.dart';
import '../cac/PriceChangeReason.dart';
import '../cac/PriceTypeCode.dart';
import '../cac/PriceType.dart';
import '../cac/OrderableUnitFactorRate.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/PriceList.dart';
import '../cac/AllowanceCharge.dart';
import '../cac/PricingExchangeRate.dart';

// A class to describe a price, expressed in a data structure containing multiple properties (compare with UnstructuredPrice).
class Price {


  // The amount of the price.
  final PriceAmount priceAmount;

  // The quantity at which this price applies.
  final BaseQuantity? baseQuantity;

  // A reason for a price change.
  final List<PriceChangeReason> priceChangeReason;

  // The type of price, expressed as a code.
  final PriceTypeCode? priceTypeCode;

  // The type of price, expressed as text.
  final PriceType? priceType;

  // The factor by which the base price unit can be converted to the orderable unit.
  final OrderableUnitFactorRate? orderableUnitFactorRate;

  // A period during which this price is valid.
  final List<ValidityPeriod> validityPeriod;

  // Information about a price list applicable to this price.
  final PriceList? priceList;

  // An allowance or charge associated with this price.
  final List<AllowanceCharge> allowanceCharge;

  // The exchange rate applicable to this price, if it differs from the exchange rate applicable to the document as a whole.
  final PricingExchangeRate? pricingExchangeRate;

  Price ({
    required this.priceAmount,
    this.baseQuantity,
    this.priceChangeReason = const [],
    this.priceTypeCode,
    this.priceType,
    this.orderableUnitFactorRate,
    this.validityPeriod = const [],
    this.priceList,
    this.allowanceCharge = const [],
    this.pricingExchangeRate,
  });
}

