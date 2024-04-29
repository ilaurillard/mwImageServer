import '../cac/LeadTimeMeasure.dart';
import '../cac/MinimumQuantity.dart';
import '../cac/MaximumQuantity.dart';
import '../cac/HazardousRiskIndicator.dart';
import '../cac/TradingRestrictions.dart';
import '../cac/ApplicableTerritoryAddress.dart';
import '../cac/Price.dart';
import '../cac/DeliveryUnit.dart';
import '../cac/ApplicableTaxCategory.dart';
import '../cac/Package.dart';
import '../cac/AllowanceCharge.dart';
import '../cac/DependentPriceReference.dart';

// A class for information about pricing structure, lead time, and location associated with an item.
class OriginalItemLocationQuantity {


  // The lead time, i.e., the time taken from the time at which an item is ordered to the time of its delivery.
  final LeadTimeMeasure? leadTimeMeasure;

  // The minimum quantity that can be ordered to qualify for a specific price.
  final MinimumQuantity? minimumQuantity;

  // The maximum quantity that can be ordered to qualify for a specific price.
  final MaximumQuantity? maximumQuantity;

  // An indication that the transported item, as delivered, in the stated quantity to the stated location, is subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  // Text describing trade restrictions on the quantity of this item or on the item itself.
  final List<TradingRestrictions> tradingRestrictions;

  // The applicable sales territory.
  final List<ApplicableTerritoryAddress> applicableTerritoryAddress;

  // The price associated with the given location.
  final Price? price;

  // A delivery unit in which the item is located.
  final List<DeliveryUnit> deliveryUnit;

  // A tax category applicable to this item location quantity.
  final List<ApplicableTaxCategory> applicableTaxCategory;

  // The package to which this price applies.
  final Package? package;

  // An allowance or charge associated with this item location quantity.
  final List<AllowanceCharge> allowanceCharge;

  // The price of the item as a percentage of the price of some other item.
  final DependentPriceReference? dependentPriceReference;

  OriginalItemLocationQuantity ({
    this.leadTimeMeasure,
    this.minimumQuantity,
    this.maximumQuantity,
    this.hazardousRiskIndicator,
    this.tradingRestrictions = const [],
    this.applicableTerritoryAddress = const [],
    this.price,
    this.deliveryUnit = const [],
    this.applicableTaxCategory = const [],
    this.package,
    this.allowanceCharge = const [],
    this.dependentPriceReference,
  });
}

