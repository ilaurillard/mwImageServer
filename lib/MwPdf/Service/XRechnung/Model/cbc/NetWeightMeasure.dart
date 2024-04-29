import 'dart:convert';
import '../../Etc/Util.dart';

// A numeric value determined by measuring an object using a specified unit of measure.
class NetWeightMeasure {

  final double value; // (decimal)

  // The type of unit of measure.
  final String unitCode; // (normalizedString)

  // The version of the measure unit code list.
  final String? unitCodeListVersionID; // (normalizedString)

  NetWeightMeasure ({
    required this.value,
    required this.unitCode,
    this.unitCodeListVersionID,
  }) {
    assert(unitCode.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
     'unitCode': unitCode,
     'unitCodeListVersionID': unitCodeListVersionID,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  NetWeightMeasure fromJson(Map<String, dynamic> json) {
    return NetWeightMeasure (
    );
  }

}

