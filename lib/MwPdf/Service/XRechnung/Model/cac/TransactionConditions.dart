import '../cac/ID.dart';
import '../cac/ActionCode.dart';
import '../cac/Description.dart';
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
}

