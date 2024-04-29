import 'dart:convert';
import '../cbc/Percent.dart';
import '../cac/LocationAddress.dart';
import '../cac/DependentLineReference.dart';

// A class to define the price of an item as a percentage of the price of a different item.
class DependentPriceReference {


  // The percentage by which the price of the different item is multiplied to calculate the price of the item.
  final Percent? percent;

  // The reference location for this dependent price reference.
  final LocationAddress? locationAddress;

  // A reference to a line that the price is depended of.
  final DependentLineReference? dependentLineReference;

  DependentPriceReference ({
    this.percent,
    this.locationAddress,
    this.dependentLineReference,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'percent': percent?.toJson(),
     'locationAddress': locationAddress?.toJson(),
     'dependentLineReference': dependentLineReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

