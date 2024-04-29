import '../cac/SourceCurrencyCode.dart';
import '../cac/SourceCurrencyBaseRate.dart';
import '../cac/TargetCurrencyCode.dart';
import '../cac/TargetCurrencyBaseRate.dart';
import '../cac/ExchangeMarketID.dart';
import '../cac/CalculationRate.dart';
import '../cac/MathematicOperatorCode.dart';
import '../cac/Date.dart';
import '../cac/ForeignExchangeContract.dart';

// A class to define an exchange rate.
class TaxExchangeRate {


  // The reference currency for this exchange rate; the currency from which the exchange is being made.
  final SourceCurrencyCode sourceCurrencyCode;

  // The target currency for this exchange rate; the currency to which the exchange is being made.
  final TargetCurrencyCode targetCurrencyCode;

  // In the case of a source currency with denominations of small value, the unit base.
  final SourceCurrencyBaseRate? sourceCurrencyBaseRate;

  // In the case of a target currency with denominations of small value, the unit base.
  final TargetCurrencyBaseRate? targetCurrencyBaseRate;

  // An identifier for the currency exchange market used as the source of this exchange rate.
  final ExchangeMarketID? exchangeMarketID;

  // The factor applied to the source currency to calculate the target currency.
  final CalculationRate? calculationRate;

  // A code signifying whether the calculation rate is a multiplier or a divisor.
  final MathematicOperatorCode? mathematicOperatorCode;

  // The date on which the exchange rate was established.
  final Date? date;

  // A contract for foreign exchange.
  final ForeignExchangeContract? foreignExchangeContract;

  TaxExchangeRate ({
    required this.sourceCurrencyCode,
    required this.targetCurrencyCode,
    this.sourceCurrencyBaseRate,
    this.targetCurrencyBaseRate,
    this.exchangeMarketID,
    this.calculationRate,
    this.mathematicOperatorCode,
    this.date,
    this.foreignExchangeContract,
  });
}

