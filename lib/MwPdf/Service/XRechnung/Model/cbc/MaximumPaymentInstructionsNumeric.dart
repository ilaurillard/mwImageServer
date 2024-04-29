import 'dart:convert';
import '../../Etc/Util.dart';

// Numeric information that is assigned or is determined by calculation, counting, or sequencing. It does not require a unit of quantity or unit of measure.
class MaximumPaymentInstructionsNumeric {

  final double value; // (decimal)

  // Whether the number is an integer, decimal, real number or percentage.
  final String? format; // (string)

  MaximumPaymentInstructionsNumeric ({
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


  MaximumPaymentInstructionsNumeric fromJson(Map<String, dynamic> json) {
    return MaximumPaymentInstructionsNumeric (
    );
  }

}

