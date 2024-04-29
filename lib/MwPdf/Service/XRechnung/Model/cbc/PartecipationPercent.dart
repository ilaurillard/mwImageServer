import 'dart:convert';

// Numeric information that is assigned or is determined by calculation, counting, or sequencing and is expressed as a percentage. It does not require a unit of quantity or unit of measure.
class PartecipationPercent {

  final String value; // (decimal)

  // Whether the number is an integer, decimal, real number or percentage.
  final String? format; // (string)

  PartecipationPercent ({
    required this.value,
    this.format,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
     'format': format,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

