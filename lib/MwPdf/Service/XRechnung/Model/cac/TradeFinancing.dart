import 'dart:convert';
import '../cac/FinancingParty.dart';
import '../cbc/ID.dart';
import '../cbc/FinancingInstrumentCode.dart';
import '../cac/ContractDocumentReference.dart';
import '../cac/DocumentReference.dart';
import '../cac/FinancingFinancialAccount.dart';
import '../cac/Clause.dart';

// A class to describe a trade financing instrument.
class TradeFinancing {


  // The financing party (bank or other enabled party).
  final FinancingParty financingParty;

  // An identifier for this trade financing instrument.
  final ID? iD;

  // A code signifying the type of this financing instrument.
  final FinancingInstrumentCode? financingInstrumentCode;

  // A reference to a contract document.
  final ContractDocumentReference? contractDocumentReference;

  // A reference to a document associated with this trade financing instrument.
  final List<DocumentReference> documentReference;

  // An internal bank account used by the bank or its first agent to manage the line of credit granted to the financing requester.
  final FinancingFinancialAccount? financingFinancialAccount;

  // A clause applicable to this trade financing instrument.
  final List<Clause> clause;

  TradeFinancing ({
    required this.financingParty,
    this.iD,
    this.financingInstrumentCode,
    this.contractDocumentReference,
    this.documentReference = const [],
    this.financingFinancialAccount,
    this.clause = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'financingInstrumentCode': financingInstrumentCode?.toJson(),
     'contractDocumentReference': contractDocumentReference?.toJson(),
     'documentReference': documentReference.map((e) => e.toJson()).toList(),
     'financingParty': financingParty.toJson(),
     'financingFinancialAccount': financingFinancialAccount?.toJson(),
     'clause': clause.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

