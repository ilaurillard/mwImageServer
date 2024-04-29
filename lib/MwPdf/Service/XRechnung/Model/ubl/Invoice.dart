import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/IssueDate.dart';
import '../cac/AccountingSupplierParty.dart';
import '../cac/AccountingCustomerParty.dart';
import '../cac/LegalMonetaryTotal.dart';
import '../cac/InvoiceLine.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/UBLVersionID.dart';
import '../cbc/CustomizationID.dart';
import '../cbc/ProfileID.dart';
import '../cbc/ProfileExecutionID.dart';
import '../cbc/CopyIndicator.dart';
import '../cbc/UUID.dart';
import '../cbc/IssueTime.dart';
import '../cbc/DueDate.dart';
import '../cbc/InvoiceTypeCode.dart';
import '../cbc/Note.dart';
import '../cbc/TaxPointDate.dart';
import '../cbc/DocumentCurrencyCode.dart';
import '../cbc/TaxCurrencyCode.dart';
import '../cbc/PricingCurrencyCode.dart';
import '../cbc/PaymentCurrencyCode.dart';
import '../cbc/PaymentAlternativeCurrencyCode.dart';
import '../cbc/AccountingCostCode.dart';
import '../cbc/AccountingCost.dart';
import '../cbc/LineCountNumeric.dart';
import '../cbc/BuyerReference.dart';
import '../cac/InvoicePeriod.dart';
import '../cac/OrderReference.dart';
import '../cac/BillingReference.dart';
import '../cac/DespatchDocumentReference.dart';
import '../cac/ReceiptDocumentReference.dart';
import '../cac/StatementDocumentReference.dart';
import '../cac/OriginatorDocumentReference.dart';
import '../cac/ContractDocumentReference.dart';
import '../cac/AdditionalDocumentReference.dart';
import '../cac/ProjectReference.dart';
import '../cac/Signature.dart';
import '../cac/PayeeParty.dart';
import '../cac/BuyerCustomerParty.dart';
import '../cac/SellerSupplierParty.dart';
import '../cac/TaxRepresentativeParty.dart';
import '../cac/Delivery.dart';
import '../cac/DeliveryTerms.dart';
import '../cac/PaymentMeans.dart';
import '../cac/PaymentTerms.dart';
import '../cac/PrepaidPayment.dart';
import '../cac/AllowanceCharge.dart';
import '../cac/TaxExchangeRate.dart';
import '../cac/PricingExchangeRate.dart';
import '../cac/PaymentExchangeRate.dart';
import '../cac/PaymentAlternativeExchangeRate.dart';
import '../cac/TaxTotal.dart';
import '../cac/WithholdingTaxTotal.dart';

// A document used to request payment.
class Invoice {


  // An identifier for this document, assigned by the sender.
  final ID iD;

  // The date, assigned by the sender, on which this document was issued.
  final IssueDate issueDate;

  // The accounting supplier party.
  final AccountingSupplierParty accountingSupplierParty;

  // The accounting customer party.
  final AccountingCustomerParty accountingCustomerParty;

  // The total amount payable on the Invoice, including Allowances, Charges, and Taxes.
  final LegalMonetaryTotal legalMonetaryTotal;

  // A line describing an invoice item.
  final List<InvoiceLine> invoiceLine;

  // A container for all extensions present in the document.
  final UBLExtensions? uBLExtensions;

  // Identifies the earliest version of the UBL 2 schema for this document type that defines all of the elements that might be encountered in the current instance.
  final UBLVersionID? uBLVersionID;

  // Identifies a user-defined customization of UBL for a specific use.
  final CustomizationID? customizationID;

  // Identifies a user-defined profile of the customization of UBL being used.
  final ProfileID? profileID;

  // Identifies an instance of executing a profile, to associate all transactions in a collaboration.
  final ProfileExecutionID? profileExecutionID;

  // Indicates whether this document is a copy (true) or not (false).
  final CopyIndicator? copyIndicator;

  // A universally unique identifier for an instance of this document.
  final UUID? uUID;

  // The time, assigned by the sender, at which this document was issued.
  final IssueTime? issueTime;

  // The date on which Invoice is due.
  final DueDate? dueDate;

  // A code signifying the type of the Invoice.
  final InvoiceTypeCode? invoiceTypeCode;

  // Free-form text pertinent to this document, conveying information that is not contained explicitly in other structures.
  final List<Note> note;

  // The date of the Invoice, used to indicate the point at which tax becomes applicable.
  final TaxPointDate? taxPointDate;

  // A code signifying the default currency for this document.
  final DocumentCurrencyCode? documentCurrencyCode;

  // A code signifying the currency used for tax amounts in the Invoice.
  final TaxCurrencyCode? taxCurrencyCode;

  // A code signifying the currency used for prices in the Invoice.
  final PricingCurrencyCode? pricingCurrencyCode;

  // A code signifying the currency used for payment in the Invoice.
  final PaymentCurrencyCode? paymentCurrencyCode;

  // A code signifying the alternative currency used for payment in the Invoice.
  final PaymentAlternativeCurrencyCode? paymentAlternativeCurrencyCode;

  // The buyer's accounting code, applied to the Invoice as a whole.
  final AccountingCostCode? accountingCostCode;

  // The buyer's accounting code, applied to the Invoice as a whole, expressed as text.
  final AccountingCost? accountingCost;

  // The number of lines in the document.
  final LineCountNumeric? lineCountNumeric;

  // A reference provided by the buyer used for internal routing of the document.
  final BuyerReference? buyerReference;

  // A period to which the Invoice applies.
  final List<InvoicePeriod> invoicePeriod;

  // A reference to the Order with which this Invoice is associated.
  final OrderReference? orderReference;

  // A reference to a billing document associated with this document.
  final List<BillingReference> billingReference;

  // A reference to a Despatch Advice associated with this document.
  final List<DespatchDocumentReference> despatchDocumentReference;

  // A reference to a Receipt Advice associated with this document.
  final List<ReceiptDocumentReference> receiptDocumentReference;

  // A reference to a Statement associated with this document.
  final List<StatementDocumentReference> statementDocumentReference;

  // A reference to an originator document associated with this document.
  final List<OriginatorDocumentReference> originatorDocumentReference;

  // A reference to a contract associated with this document.
  final List<ContractDocumentReference> contractDocumentReference;

  // A reference to an additional document associated with this document.
  final List<AdditionalDocumentReference> additionalDocumentReference;

  // Information about a project.
  final List<ProjectReference> projectReference;

  // A signature applied to this document.
  final List<Signature> signature;

  // The payee.
  final PayeeParty? payeeParty;

  // The buyer.
  final BuyerCustomerParty? buyerCustomerParty;

  // The seller.
  final SellerSupplierParty? sellerSupplierParty;

  // The tax representative.
  final TaxRepresentativeParty? taxRepresentativeParty;

  // A delivery associated with this document.
  final List<Delivery> delivery;

  // A set of delivery terms associated with this document.
  final DeliveryTerms? deliveryTerms;

  // Expected means of payment.
  final List<PaymentMeans> paymentMeans;

  // A set of payment terms associated with this document.
  final List<PaymentTerms> paymentTerms;

  // A prepaid payment.
  final List<PrepaidPayment> prepaidPayment;

  // A discount or charge that applies to a price component.
  final List<AllowanceCharge> allowanceCharge;

  // The exchange rate between the document currency and the tax currency.
  final TaxExchangeRate? taxExchangeRate;

  // The exchange rate between the document currency and the pricing currency.
  final PricingExchangeRate? pricingExchangeRate;

  // The exchange rate between the document currency and the payment currency.
  final PaymentExchangeRate? paymentExchangeRate;

  // The exchange rate between the document currency and the payment alternative currency.
  final PaymentAlternativeExchangeRate? paymentAlternativeExchangeRate;

  // The total amount of a specific type of tax.
  final List<TaxTotal> taxTotal;

  // The total withholding tax.
  final List<WithholdingTaxTotal> withholdingTaxTotal;

  Invoice ({
    required this.iD,
    required this.issueDate,
    required this.accountingSupplierParty,
    required this.accountingCustomerParty,
    required this.legalMonetaryTotal,
    required this.invoiceLine,
    this.uBLExtensions,
    this.uBLVersionID,
    this.customizationID,
    this.profileID,
    this.profileExecutionID,
    this.copyIndicator,
    this.uUID,
    this.issueTime,
    this.dueDate,
    this.invoiceTypeCode,
    this.note = const [],
    this.taxPointDate,
    this.documentCurrencyCode,
    this.taxCurrencyCode,
    this.pricingCurrencyCode,
    this.paymentCurrencyCode,
    this.paymentAlternativeCurrencyCode,
    this.accountingCostCode,
    this.accountingCost,
    this.lineCountNumeric,
    this.buyerReference,
    this.invoicePeriod = const [],
    this.orderReference,
    this.billingReference = const [],
    this.despatchDocumentReference = const [],
    this.receiptDocumentReference = const [],
    this.statementDocumentReference = const [],
    this.originatorDocumentReference = const [],
    this.contractDocumentReference = const [],
    this.additionalDocumentReference = const [],
    this.projectReference = const [],
    this.signature = const [],
    this.payeeParty,
    this.buyerCustomerParty,
    this.sellerSupplierParty,
    this.taxRepresentativeParty,
    this.delivery = const [],
    this.deliveryTerms,
    this.paymentMeans = const [],
    this.paymentTerms = const [],
    this.prepaidPayment = const [],
    this.allowanceCharge = const [],
    this.taxExchangeRate,
    this.pricingExchangeRate,
    this.paymentExchangeRate,
    this.paymentAlternativeExchangeRate,
    this.taxTotal = const [],
    this.withholdingTaxTotal = const [],
  }) {
    assert(invoiceLine.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'uBLExtensions': uBLExtensions?.toJson(),
     'uBLVersionID': uBLVersionID?.toJson(),
     'customizationID': customizationID?.toJson(),
     'profileID': profileID?.toJson(),
     'profileExecutionID': profileExecutionID?.toJson(),
     'iD': iD.toJson(),
     'copyIndicator': copyIndicator?.toJson(),
     'uUID': uUID?.toJson(),
     'issueDate': issueDate.toJson(),
     'issueTime': issueTime?.toJson(),
     'dueDate': dueDate?.toJson(),
     'invoiceTypeCode': invoiceTypeCode?.toJson(),
     'note': note.map((e) => e.toJson()).toList(),
     'taxPointDate': taxPointDate?.toJson(),
     'documentCurrencyCode': documentCurrencyCode?.toJson(),
     'taxCurrencyCode': taxCurrencyCode?.toJson(),
     'pricingCurrencyCode': pricingCurrencyCode?.toJson(),
     'paymentCurrencyCode': paymentCurrencyCode?.toJson(),
     'paymentAlternativeCurrencyCode': paymentAlternativeCurrencyCode?.toJson(),
     'accountingCostCode': accountingCostCode?.toJson(),
     'accountingCost': accountingCost?.toJson(),
     'lineCountNumeric': lineCountNumeric?.toJson(),
     'buyerReference': buyerReference?.toJson(),
     'invoicePeriod': invoicePeriod.map((e) => e.toJson()).toList(),
     'orderReference': orderReference?.toJson(),
     'billingReference': billingReference.map((e) => e.toJson()).toList(),
     'despatchDocumentReference': despatchDocumentReference.map((e) => e.toJson()).toList(),
     'receiptDocumentReference': receiptDocumentReference.map((e) => e.toJson()).toList(),
     'statementDocumentReference': statementDocumentReference.map((e) => e.toJson()).toList(),
     'originatorDocumentReference': originatorDocumentReference.map((e) => e.toJson()).toList(),
     'contractDocumentReference': contractDocumentReference.map((e) => e.toJson()).toList(),
     'additionalDocumentReference': additionalDocumentReference.map((e) => e.toJson()).toList(),
     'projectReference': projectReference.map((e) => e.toJson()).toList(),
     'signature': signature.map((e) => e.toJson()).toList(),
     'accountingSupplierParty': accountingSupplierParty.toJson(),
     'accountingCustomerParty': accountingCustomerParty.toJson(),
     'payeeParty': payeeParty?.toJson(),
     'buyerCustomerParty': buyerCustomerParty?.toJson(),
     'sellerSupplierParty': sellerSupplierParty?.toJson(),
     'taxRepresentativeParty': taxRepresentativeParty?.toJson(),
     'delivery': delivery.map((e) => e.toJson()).toList(),
     'deliveryTerms': deliveryTerms?.toJson(),
     'paymentMeans': paymentMeans.map((e) => e.toJson()).toList(),
     'paymentTerms': paymentTerms.map((e) => e.toJson()).toList(),
     'prepaidPayment': prepaidPayment.map((e) => e.toJson()).toList(),
     'allowanceCharge': allowanceCharge.map((e) => e.toJson()).toList(),
     'taxExchangeRate': taxExchangeRate?.toJson(),
     'pricingExchangeRate': pricingExchangeRate?.toJson(),
     'paymentExchangeRate': paymentExchangeRate?.toJson(),
     'paymentAlternativeExchangeRate': paymentAlternativeExchangeRate?.toJson(),
     'taxTotal': taxTotal.map((e) => e.toJson()).toList(),
     'withholdingTaxTotal': withholdingTaxTotal.map((e) => e.toJson()).toList(),
     'legalMonetaryTotal': legalMonetaryTotal.toJson(),
     'invoiceLine': invoiceLine.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

