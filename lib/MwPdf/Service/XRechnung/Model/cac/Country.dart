import 'dart:convert';
import '../cbc/IdentificationCode.dart';
import '../cbc/Name.dart';

// A class to describe a country.
class Country {


  // A code signifying this country.
  final IdentificationCode? identificationCode;

  // The name of this country.
  final Name? name;

  Country ({
    this.identificationCode,
    this.name,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'identificationCode': identificationCode?.toJson(),
     'name': name?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

