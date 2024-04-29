import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/Amount.dart';
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'amount': amount.toJson(),
     'taxTotal': taxTotal.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ItemPriceExtension fromJson(Map<String, dynamic> json) {
    return ItemPriceExtension (
    );
  }

}

