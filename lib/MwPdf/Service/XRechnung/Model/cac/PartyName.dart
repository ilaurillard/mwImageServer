import 'dart:convert';
import '../cbc/Name.dart';

// A class for defining the name of a party.
class PartyName {


  // The name of the party.
  final Name name;

  PartyName ({
    required this.name,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'name': name.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

