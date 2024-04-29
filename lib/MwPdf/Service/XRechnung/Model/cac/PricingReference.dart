import '../cac/OriginalItemLocationQuantity.dart';
import '../cac/AlternativeConditionPrice.dart';

// A reference to the basis for pricing. This may be based on a catalogue or a quoted amount from a price list and include some alternative pricing conditions.
class PricingReference {


  // An original set of location-specific properties (e.g., price and quantity) associated with this item.
  final OriginalItemLocationQuantity? originalItemLocationQuantity;

  // The price expressed in terms other than the actual price, e.g., the list price v. the contracted price, or the price in bags v. the price in kilos, or the list price in bags v. the contracted price in kilos.
  final List<AlternativeConditionPrice> alternativeConditionPrice;

  PricingReference ({
    this.originalItemLocationQuantity,
    this.alternativeConditionPrice = const [],
  });
}

