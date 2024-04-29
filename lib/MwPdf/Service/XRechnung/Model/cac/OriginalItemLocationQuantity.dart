import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/LeadTimeMeasure.dart';
import '../cbc/MinimumQuantity.dart';
import '../cbc/MaximumQuantity.dart';
import '../cbc/HazardousRiskIndicator.dart';
import '../cbc/TradingRestrictions.dart';
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'leadTimeMeasure': leadTimeMeasure?.toJson(),
     'minimumQuantity': minimumQuantity?.toJson(),
     'maximumQuantity': maximumQuantity?.toJson(),
     'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
     'tradingRestrictions': tradingRestrictions.map((e) => e.toJson()).toList(),
     'applicableTerritoryAddress': applicableTerritoryAddress.map((e) => e.toJson()).toList(),
     'price': price?.toJson(),
     'deliveryUnit': deliveryUnit.map((e) => e.toJson()).toList(),
     'applicableTaxCategory': applicableTaxCategory.map((e) => e.toJson()).toList(),
     'package': package?.toJson(),
     'allowanceCharge': allowanceCharge.map((e) => e.toJson()).toList(),
     'dependentPriceReference': dependentPriceReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  OriginalItemLocationQuantity fromJson(Map<String, dynamic> json) {
    return OriginalItemLocationQuantity (
    );
  }

}

