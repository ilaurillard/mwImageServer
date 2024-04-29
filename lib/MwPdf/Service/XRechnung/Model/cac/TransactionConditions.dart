import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/ActionCode.dart';
import '../cbc/Description.dart';
import '../cac/DocumentReference.dart';

// A class to describe purchasing, sales, or payment conditions.
class TransactionConditions {


  // An identifier for conditions of the transaction, typically purchase/sales conditions.
  final ID? iD;

  // A code signifying a type of action relating to sales or payment conditions.
  final ActionCode? actionCode;

  // Text describing the transaction conditions.
  final List<Description> description;

  // A document associated with these transaction conditions.
  final List<DocumentReference> documentReference;

  TransactionConditions ({
    this.iD,
    this.actionCode,
    this.description = const [],
    this.documentReference = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'actionCode': actionCode?.toJson(),
     'description': description.map((e) => e.toJson()).toList(),
     'documentReference': documentReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

