import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cac/FinancingParty.dart';
import '../ext/UBLExtensions.dart';
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

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
    this.uBLExtensions,
    this.iD,
    this.financingInstrumentCode,
    this.contractDocumentReference,
    this.documentReference = const [],
    this.financingFinancialAccount,
    this.clause = const [],
  });

  static TradeFinancing? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TradeFinancing (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      financingInstrumentCode: FinancingInstrumentCode.fromJson(json['financingInstrumentCode'] as Map<String, dynamic>?),
      contractDocumentReference: ContractDocumentReference.fromJson(json['contractDocumentReference'] as Map<String, dynamic>?),
      documentReference: (json['documentReference'] as List? ?? []).map((dynamic d) => DocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      financingParty: FinancingParty.fromJson(json['financingParty'] as Map<String, dynamic>?)!,
      financingFinancialAccount: FinancingFinancialAccount.fromJson(json['financingFinancialAccount'] as Map<String, dynamic>?),
      clause: (json['clause'] as List? ?? []).map((dynamic d) => Clause.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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

  static TradeFinancing? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TradeFinancing (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      financingInstrumentCode: FinancingInstrumentCode.fromXml(xml.findElements('cbc:FinancingInstrumentCode').singleOrNull),
      contractDocumentReference: ContractDocumentReference.fromXml(xml.findElements('cac:ContractDocumentReference').singleOrNull),
      documentReference: xml.findElements('cac:DocumentReference').map((XmlElement e) => DocumentReference.fromXml(e)!).toList(),
      financingParty: FinancingParty.fromXml(xml.findElements('cac:FinancingParty').singleOrNull)!,
      financingFinancialAccount: FinancingFinancialAccount.fromXml(xml.findElements('cac:FinancingFinancialAccount').singleOrNull),
      clause: xml.findElements('cac:Clause').map((XmlElement e) => Clause.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'TradeFinancing',
        'cac',
      ),
    );
  }
}

