import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cac/InvoiceDocumentReference.dart';
import '../cac/SelfBilledInvoiceDocumentReference.dart';
import '../cac/CreditNoteDocumentReference.dart';
import '../cac/SelfBilledCreditNoteDocumentReference.dart';
import '../cac/DebitNoteDocumentReference.dart';
import '../cac/ReminderDocumentReference.dart';
import '../cac/AdditionalDocumentReference.dart';
import '../cac/BillingReferenceLine.dart';

// A class to define a reference to a billing document.
class BillingReference {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A reference to an invoice.
  final InvoiceDocumentReference? invoiceDocumentReference;

  // A reference to a self billed invoice.
  final SelfBilledInvoiceDocumentReference? selfBilledInvoiceDocumentReference;

  // A reference to a credit note.
  final CreditNoteDocumentReference? creditNoteDocumentReference;

  // A reference to a self billed credit note.
  final SelfBilledCreditNoteDocumentReference? selfBilledCreditNoteDocumentReference;

  // A reference to a debit note.
  final DebitNoteDocumentReference? debitNoteDocumentReference;

  // A reference to a billing reminder.
  final ReminderDocumentReference? reminderDocumentReference;

  // A reference to an additional document.
  final AdditionalDocumentReference? additionalDocumentReference;

  // A reference to a transaction line in the billing document.
  final List<BillingReferenceLine> billingReferenceLine;

  BillingReference ({
    this.uBLExtensions,
    this.invoiceDocumentReference,
    this.selfBilledInvoiceDocumentReference,
    this.creditNoteDocumentReference,
    this.selfBilledCreditNoteDocumentReference,
    this.debitNoteDocumentReference,
    this.reminderDocumentReference,
    this.additionalDocumentReference,
    this.billingReferenceLine = const [],
  });

  static BillingReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return BillingReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      invoiceDocumentReference: InvoiceDocumentReference.fromJson(json['invoiceDocumentReference'] as Map<String, dynamic>?),
      selfBilledInvoiceDocumentReference: SelfBilledInvoiceDocumentReference.fromJson(json['selfBilledInvoiceDocumentReference'] as Map<String, dynamic>?),
      creditNoteDocumentReference: CreditNoteDocumentReference.fromJson(json['creditNoteDocumentReference'] as Map<String, dynamic>?),
      selfBilledCreditNoteDocumentReference: SelfBilledCreditNoteDocumentReference.fromJson(json['selfBilledCreditNoteDocumentReference'] as Map<String, dynamic>?),
      debitNoteDocumentReference: DebitNoteDocumentReference.fromJson(json['debitNoteDocumentReference'] as Map<String, dynamic>?),
      reminderDocumentReference: ReminderDocumentReference.fromJson(json['reminderDocumentReference'] as Map<String, dynamic>?),
      additionalDocumentReference: AdditionalDocumentReference.fromJson(json['additionalDocumentReference'] as Map<String, dynamic>?),
      billingReferenceLine: (json['billingReferenceLine'] as List? ?? []).map((dynamic d) => BillingReferenceLine.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'invoiceDocumentReference': invoiceDocumentReference?.toJson(),
      'selfBilledInvoiceDocumentReference': selfBilledInvoiceDocumentReference?.toJson(),
      'creditNoteDocumentReference': creditNoteDocumentReference?.toJson(),
      'selfBilledCreditNoteDocumentReference': selfBilledCreditNoteDocumentReference?.toJson(),
      'debitNoteDocumentReference': debitNoteDocumentReference?.toJson(),
      'reminderDocumentReference': reminderDocumentReference?.toJson(),
      'additionalDocumentReference': additionalDocumentReference?.toJson(),
      'billingReferenceLine': billingReferenceLine.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static BillingReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return BillingReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      invoiceDocumentReference: InvoiceDocumentReference.fromXml(xml.findElements('cac:InvoiceDocumentReference').singleOrNull),
      selfBilledInvoiceDocumentReference: SelfBilledInvoiceDocumentReference.fromXml(xml.findElements('cac:SelfBilledInvoiceDocumentReference').singleOrNull),
      creditNoteDocumentReference: CreditNoteDocumentReference.fromXml(xml.findElements('cac:CreditNoteDocumentReference').singleOrNull),
      selfBilledCreditNoteDocumentReference: SelfBilledCreditNoteDocumentReference.fromXml(xml.findElements('cac:SelfBilledCreditNoteDocumentReference').singleOrNull),
      debitNoteDocumentReference: DebitNoteDocumentReference.fromXml(xml.findElements('cac:DebitNoteDocumentReference').singleOrNull),
      reminderDocumentReference: ReminderDocumentReference.fromXml(xml.findElements('cac:ReminderDocumentReference').singleOrNull),
      additionalDocumentReference: AdditionalDocumentReference.fromXml(xml.findElements('cac:AdditionalDocumentReference').singleOrNull),
      billingReferenceLine: xml.findElements('cac:BillingReferenceLine').map((XmlElement e) => BillingReferenceLine.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'BillingReference',
        'cac',
      ),
    );
  }
}

