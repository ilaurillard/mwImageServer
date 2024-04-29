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
    this.invoiceDocumentReference,
    this.selfBilledInvoiceDocumentReference,
    this.creditNoteDocumentReference,
    this.selfBilledCreditNoteDocumentReference,
    this.debitNoteDocumentReference,
    this.reminderDocumentReference,
    this.additionalDocumentReference,
    this.billingReferenceLine = const [],
  });
}

