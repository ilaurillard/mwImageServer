import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cac/IssuerParty.dart';

// A class describing identifiers or references relating to customs procedures.
class CustomsDeclaration {


  // An identifier associated with customs related procedures.
  final ID iD;

  // Describes the party issuing the customs declaration.
  final IssuerParty? issuerParty;

  CustomsDeclaration ({
    required this.iD,
    this.issuerParty,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD.toJson(),
     'issuerParty': issuerParty?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  CustomsDeclaration fromJson(Map<String, dynamic> json) {
    return CustomsDeclaration (
    );
  }

}

