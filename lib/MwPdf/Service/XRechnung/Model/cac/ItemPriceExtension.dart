import '../cac/Amount.dart';
import '../cac/TaxTotal.dart';

// A class to describe a price extension, calculated by multiplying the price per unit by the quantity of items.
class ItemPriceExtension {


  // The amount of this price extension.
  final Amount amount;

  // A total amount of taxes of a particular kind applicable to this price extension.
  final List<TaxTotal> taxTotal;

  ItemPriceExtension ({
    required this.amount,
    this.taxTotal = const [],
  });
}

