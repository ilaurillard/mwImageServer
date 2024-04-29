import '../cac/ID.dart';
import '../cac/PaymentMeansID.dart';
import '../cac/PrepaidPaymentReferenceID.dart';
import '../cac/Note.dart';
import '../cac/ReferenceEventCode.dart';
import '../cac/SettlementDiscountPercent.dart';
import '../cac/PenaltySurchargePercent.dart';
import '../cac/PaymentPercent.dart';
import '../cac/Amount.dart';
import '../cac/SettlementDiscountAmount.dart';
import '../cac/PenaltyAmount.dart';
import '../cac/PaymentTermsDetailsURI.dart';
import '../cac/PaymentDueDate.dart';
import '../cac/InstallmentDueDate.dart';
import '../cac/InvoicingPartyReference.dart';
import '../cac/SettlementPeriod.dart';
import '../cac/PenaltyPeriod.dart';
import '../cac/ExchangeRate.dart';
import '../cac/ValidityPeriod.dart';

// A class to describe a set of payment terms.
class DisbursementPaymentTerms {


  // An identifier for this set of payment terms.
  final ID? iD;

  // An identifier for a means of payment associated with these payment terms.
  final List<PaymentMeansID> paymentMeansID;

  // An identifier for a reference to a prepaid payment.
  final PrepaidPaymentReferenceID? prepaidPaymentReferenceID;

  // Free-form text conveying information that is not contained explicitly in other structures.
  final List<Note> note;

  // A code signifying the event during which these terms are offered.
  final ReferenceEventCode? referenceEventCode;

  // The percentage for the settlement discount that is offered for payment under these payment terms.
  final SettlementDiscountPercent? settlementDiscountPercent;

  // The penalty for payment after the settlement period, expressed as a percentage of the payment.
  final PenaltySurchargePercent? penaltySurchargePercent;

  // The part of a payment, expressed as a percent, relevant for these payment terms.
  final PaymentPercent? paymentPercent;

  // The monetary amount covered by these payment terms.
  final Amount? amount;

  // The amount of a settlement discount offered for payment under these payment terms.
  final SettlementDiscountAmount? settlementDiscountAmount;

  // The monetary amount of the penalty for payment after the settlement period.
  final PenaltyAmount? penaltyAmount;

  // The Uniform Resource Identifier (URI) of a document providing additional details regarding these payment terms.
  final PaymentTermsDetailsURI? paymentTermsDetailsURI;

  // The due date for these payment terms.
  final PaymentDueDate? paymentDueDate;

  // The due date for an installment payment for these payment terms.
  final InstallmentDueDate? installmentDueDate;

  // A reference to the payment terms used by the invoicing party. This may have been requested of the payer by the payee to accompany its remittance.
  final InvoicingPartyReference? invoicingPartyReference;

  // The period during which settlement may occur.
  final SettlementPeriod? settlementPeriod;

  // The period during which penalties may apply.
  final PenaltyPeriod? penaltyPeriod;

  // The currency exchange rate for purposes of these payment terms.
  final ExchangeRate? exchangeRate;

  // The period during which these payment terms are valid.
  final ValidityPeriod? validityPeriod;

  DisbursementPaymentTerms ({
    this.iD,
    this.paymentMeansID = const [],
    this.prepaidPaymentReferenceID,
    this.note = const [],
    this.referenceEventCode,
    this.settlementDiscountPercent,
    this.penaltySurchargePercent,
    this.paymentPercent,
    this.amount,
    this.settlementDiscountAmount,
    this.penaltyAmount,
    this.paymentTermsDetailsURI,
    this.paymentDueDate,
    this.installmentDueDate,
    this.invoicingPartyReference,
    this.settlementPeriod,
    this.penaltyPeriod,
    this.exchangeRate,
    this.validityPeriod,
  });
}

