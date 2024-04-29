import 'dart:convert';
import '../cbc/ID.dart';

// A class to define an identifier for a party.
class PartyIdentification {


  // An identifier for the party.
  final ID iD;

  PartyIdentification ({
    required this.iD,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

