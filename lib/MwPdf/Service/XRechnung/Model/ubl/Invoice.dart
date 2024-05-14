import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/IssueDate.dart';
import '../cac/AccountingSupplierParty.dart';
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
import '../cac/AccountingCustomerParty.dart';
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

  // The total amount payable on the Invoice, including Allowances, Charges, and Taxes.
  final LegalMonetaryTotal legalMonetaryTotal;

  // A line describing an invoice item.
  final List<InvoiceLine> invoiceLine;

  // A container for extensions foreign to the document.
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

  // The accounting customer party.
  final AccountingCustomerParty? accountingCustomerParty;

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
    this.accountingCustomerParty,
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

  static Invoice? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Invoice (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      uBLVersionID: UBLVersionID.fromJson(json['uBLVersionID'] as Map<String, dynamic>?),
      customizationID: CustomizationID.fromJson(json['customizationID'] as Map<String, dynamic>?),
      profileID: ProfileID.fromJson(json['profileID'] as Map<String, dynamic>?),
      profileExecutionID: ProfileExecutionID.fromJson(json['profileExecutionID'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      copyIndicator: CopyIndicator.fromJson(json['copyIndicator'] as Map<String, dynamic>?),
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      issueDate: IssueDate.fromJson(json['issueDate'] as Map<String, dynamic>?)!,
      issueTime: IssueTime.fromJson(json['issueTime'] as Map<String, dynamic>?),
      dueDate: DueDate.fromJson(json['dueDate'] as Map<String, dynamic>?),
      invoiceTypeCode: InvoiceTypeCode.fromJson(json['invoiceTypeCode'] as Map<String, dynamic>?),
      note: (json['note'] as List? ?? []).map((dynamic d) => Note.fromJson(d as Map<String, dynamic>?)!).toList(),
      taxPointDate: TaxPointDate.fromJson(json['taxPointDate'] as Map<String, dynamic>?),
      documentCurrencyCode: DocumentCurrencyCode.fromJson(json['documentCurrencyCode'] as Map<String, dynamic>?),
      taxCurrencyCode: TaxCurrencyCode.fromJson(json['taxCurrencyCode'] as Map<String, dynamic>?),
      pricingCurrencyCode: PricingCurrencyCode.fromJson(json['pricingCurrencyCode'] as Map<String, dynamic>?),
      paymentCurrencyCode: PaymentCurrencyCode.fromJson(json['paymentCurrencyCode'] as Map<String, dynamic>?),
      paymentAlternativeCurrencyCode: PaymentAlternativeCurrencyCode.fromJson(json['paymentAlternativeCurrencyCode'] as Map<String, dynamic>?),
      accountingCostCode: AccountingCostCode.fromJson(json['accountingCostCode'] as Map<String, dynamic>?),
      accountingCost: AccountingCost.fromJson(json['accountingCost'] as Map<String, dynamic>?),
      lineCountNumeric: LineCountNumeric.fromJson(json['lineCountNumeric'] as Map<String, dynamic>?),
      buyerReference: BuyerReference.fromJson(json['buyerReference'] as Map<String, dynamic>?),
      invoicePeriod: (json['invoicePeriod'] as List? ?? []).map((dynamic d) => InvoicePeriod.fromJson(d as Map<String, dynamic>?)!).toList(),
      orderReference: OrderReference.fromJson(json['orderReference'] as Map<String, dynamic>?),
      billingReference: (json['billingReference'] as List? ?? []).map((dynamic d) => BillingReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      despatchDocumentReference: (json['despatchDocumentReference'] as List? ?? []).map((dynamic d) => DespatchDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      receiptDocumentReference: (json['receiptDocumentReference'] as List? ?? []).map((dynamic d) => ReceiptDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      statementDocumentReference: (json['statementDocumentReference'] as List? ?? []).map((dynamic d) => StatementDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      originatorDocumentReference: (json['originatorDocumentReference'] as List? ?? []).map((dynamic d) => OriginatorDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      contractDocumentReference: (json['contractDocumentReference'] as List? ?? []).map((dynamic d) => ContractDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      additionalDocumentReference: (json['additionalDocumentReference'] as List? ?? []).map((dynamic d) => AdditionalDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      projectReference: (json['projectReference'] as List? ?? []).map((dynamic d) => ProjectReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      signature: (json['signature'] as List? ?? []).map((dynamic d) => Signature.fromJson(d as Map<String, dynamic>?)!).toList(),
      accountingSupplierParty: AccountingSupplierParty.fromJson(json['accountingSupplierParty'] as Map<String, dynamic>?)!,
      accountingCustomerParty: AccountingCustomerParty.fromJson(json['accountingCustomerParty'] as Map<String, dynamic>?),
      payeeParty: PayeeParty.fromJson(json['payeeParty'] as Map<String, dynamic>?),
      buyerCustomerParty: BuyerCustomerParty.fromJson(json['buyerCustomerParty'] as Map<String, dynamic>?),
      sellerSupplierParty: SellerSupplierParty.fromJson(json['sellerSupplierParty'] as Map<String, dynamic>?),
      taxRepresentativeParty: TaxRepresentativeParty.fromJson(json['taxRepresentativeParty'] as Map<String, dynamic>?),
      delivery: (json['delivery'] as List? ?? []).map((dynamic d) => Delivery.fromJson(d as Map<String, dynamic>?)!).toList(),
      deliveryTerms: DeliveryTerms.fromJson(json['deliveryTerms'] as Map<String, dynamic>?),
      paymentMeans: (json['paymentMeans'] as List? ?? []).map((dynamic d) => PaymentMeans.fromJson(d as Map<String, dynamic>?)!).toList(),
      paymentTerms: (json['paymentTerms'] as List? ?? []).map((dynamic d) => PaymentTerms.fromJson(d as Map<String, dynamic>?)!).toList(),
      prepaidPayment: (json['prepaidPayment'] as List? ?? []).map((dynamic d) => PrepaidPayment.fromJson(d as Map<String, dynamic>?)!).toList(),
      allowanceCharge: (json['allowanceCharge'] as List? ?? []).map((dynamic d) => AllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      taxExchangeRate: TaxExchangeRate.fromJson(json['taxExchangeRate'] as Map<String, dynamic>?),
      pricingExchangeRate: PricingExchangeRate.fromJson(json['pricingExchangeRate'] as Map<String, dynamic>?),
      paymentExchangeRate: PaymentExchangeRate.fromJson(json['paymentExchangeRate'] as Map<String, dynamic>?),
      paymentAlternativeExchangeRate: PaymentAlternativeExchangeRate.fromJson(json['paymentAlternativeExchangeRate'] as Map<String, dynamic>?),
      taxTotal: (json['taxTotal'] as List? ?? []).map((dynamic d) => TaxTotal.fromJson(d as Map<String, dynamic>?)!).toList(),
      withholdingTaxTotal: (json['withholdingTaxTotal'] as List? ?? []).map((dynamic d) => WithholdingTaxTotal.fromJson(d as Map<String, dynamic>?)!).toList(),
      legalMonetaryTotal: LegalMonetaryTotal.fromJson(json['legalMonetaryTotal'] as Map<String, dynamic>?)!,
      invoiceLine: (json['invoiceLine'] as List? ?? []).map((dynamic d) => InvoiceLine.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
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
      'accountingCustomerParty': accountingCustomerParty?.toJson(),
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

  static Invoice? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return Invoice (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      uBLVersionID: UBLVersionID.fromXml(xml.findElements('cbc:UBLVersionID').singleOrNull),
      customizationID: CustomizationID.fromXml(xml.findElements('cbc:CustomizationID').singleOrNull),
      profileID: ProfileID.fromXml(xml.findElements('cbc:ProfileID').singleOrNull),
      profileExecutionID: ProfileExecutionID.fromXml(xml.findElements('cbc:ProfileExecutionID').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      copyIndicator: CopyIndicator.fromXml(xml.findElements('cbc:CopyIndicator').singleOrNull),
      uUID: UUID.fromXml(xml.findElements('cbc:UUID').singleOrNull),
      issueDate: IssueDate.fromXml(xml.findElements('cbc:IssueDate').singleOrNull)!,
      issueTime: IssueTime.fromXml(xml.findElements('cbc:IssueTime').singleOrNull),
      dueDate: DueDate.fromXml(xml.findElements('cbc:DueDate').singleOrNull),
      invoiceTypeCode: InvoiceTypeCode.fromXml(xml.findElements('cbc:InvoiceTypeCode').singleOrNull),
      note: xml.findElements('cbc:Note').map((XmlElement e) => Note.fromXml(e)!).toList(),
      taxPointDate: TaxPointDate.fromXml(xml.findElements('cbc:TaxPointDate').singleOrNull),
      documentCurrencyCode: DocumentCurrencyCode.fromXml(xml.findElements('cbc:DocumentCurrencyCode').singleOrNull),
      taxCurrencyCode: TaxCurrencyCode.fromXml(xml.findElements('cbc:TaxCurrencyCode').singleOrNull),
      pricingCurrencyCode: PricingCurrencyCode.fromXml(xml.findElements('cbc:PricingCurrencyCode').singleOrNull),
      paymentCurrencyCode: PaymentCurrencyCode.fromXml(xml.findElements('cbc:PaymentCurrencyCode').singleOrNull),
      paymentAlternativeCurrencyCode: PaymentAlternativeCurrencyCode.fromXml(xml.findElements('cbc:PaymentAlternativeCurrencyCode').singleOrNull),
      accountingCostCode: AccountingCostCode.fromXml(xml.findElements('cbc:AccountingCostCode').singleOrNull),
      accountingCost: AccountingCost.fromXml(xml.findElements('cbc:AccountingCost').singleOrNull),
      lineCountNumeric: LineCountNumeric.fromXml(xml.findElements('cbc:LineCountNumeric').singleOrNull),
      buyerReference: BuyerReference.fromXml(xml.findElements('cbc:BuyerReference').singleOrNull),
      invoicePeriod: xml.findElements('cac:InvoicePeriod').map((XmlElement e) => InvoicePeriod.fromXml(e)!).toList(),
      orderReference: OrderReference.fromXml(xml.findElements('cac:OrderReference').singleOrNull),
      billingReference: xml.findElements('cac:BillingReference').map((XmlElement e) => BillingReference.fromXml(e)!).toList(),
      despatchDocumentReference: xml.findElements('cac:DespatchDocumentReference').map((XmlElement e) => DespatchDocumentReference.fromXml(e)!).toList(),
      receiptDocumentReference: xml.findElements('cac:ReceiptDocumentReference').map((XmlElement e) => ReceiptDocumentReference.fromXml(e)!).toList(),
      statementDocumentReference: xml.findElements('cac:StatementDocumentReference').map((XmlElement e) => StatementDocumentReference.fromXml(e)!).toList(),
      originatorDocumentReference: xml.findElements('cac:OriginatorDocumentReference').map((XmlElement e) => OriginatorDocumentReference.fromXml(e)!).toList(),
      contractDocumentReference: xml.findElements('cac:ContractDocumentReference').map((XmlElement e) => ContractDocumentReference.fromXml(e)!).toList(),
      additionalDocumentReference: xml.findElements('cac:AdditionalDocumentReference').map((XmlElement e) => AdditionalDocumentReference.fromXml(e)!).toList(),
      projectReference: xml.findElements('cac:ProjectReference').map((XmlElement e) => ProjectReference.fromXml(e)!).toList(),
      signature: xml.findElements('cac:Signature').map((XmlElement e) => Signature.fromXml(e)!).toList(),
      accountingSupplierParty: AccountingSupplierParty.fromXml(xml.findElements('cac:AccountingSupplierParty').singleOrNull)!,
      accountingCustomerParty: AccountingCustomerParty.fromXml(xml.findElements('cac:AccountingCustomerParty').singleOrNull),
      payeeParty: PayeeParty.fromXml(xml.findElements('cac:PayeeParty').singleOrNull),
      buyerCustomerParty: BuyerCustomerParty.fromXml(xml.findElements('cac:BuyerCustomerParty').singleOrNull),
      sellerSupplierParty: SellerSupplierParty.fromXml(xml.findElements('cac:SellerSupplierParty').singleOrNull),
      taxRepresentativeParty: TaxRepresentativeParty.fromXml(xml.findElements('cac:TaxRepresentativeParty').singleOrNull),
      delivery: xml.findElements('cac:Delivery').map((XmlElement e) => Delivery.fromXml(e)!).toList(),
      deliveryTerms: DeliveryTerms.fromXml(xml.findElements('cac:DeliveryTerms').singleOrNull),
      paymentMeans: xml.findElements('cac:PaymentMeans').map((XmlElement e) => PaymentMeans.fromXml(e)!).toList(),
      paymentTerms: xml.findElements('cac:PaymentTerms').map((XmlElement e) => PaymentTerms.fromXml(e)!).toList(),
      prepaidPayment: xml.findElements('cac:PrepaidPayment').map((XmlElement e) => PrepaidPayment.fromXml(e)!).toList(),
      allowanceCharge: xml.findElements('cac:AllowanceCharge').map((XmlElement e) => AllowanceCharge.fromXml(e)!).toList(),
      taxExchangeRate: TaxExchangeRate.fromXml(xml.findElements('cac:TaxExchangeRate').singleOrNull),
      pricingExchangeRate: PricingExchangeRate.fromXml(xml.findElements('cac:PricingExchangeRate').singleOrNull),
      paymentExchangeRate: PaymentExchangeRate.fromXml(xml.findElements('cac:PaymentExchangeRate').singleOrNull),
      paymentAlternativeExchangeRate: PaymentAlternativeExchangeRate.fromXml(xml.findElements('cac:PaymentAlternativeExchangeRate').singleOrNull),
      taxTotal: xml.findElements('cac:TaxTotal').map((XmlElement e) => TaxTotal.fromXml(e)!).toList(),
      withholdingTaxTotal: xml.findElements('cac:WithholdingTaxTotal').map((XmlElement e) => WithholdingTaxTotal.fromXml(e)!).toList(),
      legalMonetaryTotal: LegalMonetaryTotal.fromXml(xml.findElements('cac:LegalMonetaryTotal').singleOrNull)!,
      invoiceLine: xml.findElements('cac:InvoiceLine').map((XmlElement e) => InvoiceLine.fromXml(e)!).toList(),
    );
  }

  XmlDocument toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      uBLVersionID?.toXml(),
      customizationID?.toXml(),
      profileID?.toXml(),
      profileExecutionID?.toXml(),
      iD.toXml(),
      copyIndicator?.toXml(),
      uUID?.toXml(),
      issueDate.toXml(),
      issueTime?.toXml(),
      dueDate?.toXml(),
      invoiceTypeCode?.toXml(),
      ...note.map((Note e) => e.toXml()).toList(),
      taxPointDate?.toXml(),
      documentCurrencyCode?.toXml(),
      taxCurrencyCode?.toXml(),
      pricingCurrencyCode?.toXml(),
      paymentCurrencyCode?.toXml(),
      paymentAlternativeCurrencyCode?.toXml(),
      accountingCostCode?.toXml(),
      accountingCost?.toXml(),
      lineCountNumeric?.toXml(),
      buyerReference?.toXml(),
      ...invoicePeriod.map((InvoicePeriod e) => e.toXml()).toList(),
      orderReference?.toXml(),
      ...billingReference.map((BillingReference e) => e.toXml()).toList(),
      ...despatchDocumentReference.map((DespatchDocumentReference e) => e.toXml()).toList(),
      ...receiptDocumentReference.map((ReceiptDocumentReference e) => e.toXml()).toList(),
      ...statementDocumentReference.map((StatementDocumentReference e) => e.toXml()).toList(),
      ...originatorDocumentReference.map((OriginatorDocumentReference e) => e.toXml()).toList(),
      ...contractDocumentReference.map((ContractDocumentReference e) => e.toXml()).toList(),
      ...additionalDocumentReference.map((AdditionalDocumentReference e) => e.toXml()).toList(),
      ...projectReference.map((ProjectReference e) => e.toXml()).toList(),
      ...signature.map((Signature e) => e.toXml()).toList(),
      accountingSupplierParty.toXml(),
      accountingCustomerParty?.toXml(),
      payeeParty?.toXml(),
      buyerCustomerParty?.toXml(),
      sellerSupplierParty?.toXml(),
      taxRepresentativeParty?.toXml(),
      ...delivery.map((Delivery e) => e.toXml()).toList(),
      deliveryTerms?.toXml(),
      ...paymentMeans.map((PaymentMeans e) => e.toXml()).toList(),
      ...paymentTerms.map((PaymentTerms e) => e.toXml()).toList(),
      ...prepaidPayment.map((PrepaidPayment e) => e.toXml()).toList(),
      ...allowanceCharge.map((AllowanceCharge e) => e.toXml()).toList(),
      taxExchangeRate?.toXml(),
      pricingExchangeRate?.toXml(),
      paymentExchangeRate?.toXml(),
      paymentAlternativeExchangeRate?.toXml(),
      ...taxTotal.map((TaxTotal e) => e.toXml()).toList(),
      ...withholdingTaxTotal.map((WithholdingTaxTotal e) => e.toXml()).toList(),
      legalMonetaryTotal.toXml(),
      ...invoiceLine.map((InvoiceLine e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [
      XmlAttribute(
        XmlName('xmlns:ubl'),
        'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2',
      ),
      XmlAttribute(
        XmlName('xmlns:ext'),
        'urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2',
      ),
      XmlAttribute(
        XmlName('xmlns:cbc'),
        'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2',
      ),
      XmlAttribute(
        XmlName('xmlns:cac'),
        'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2',
      ),
      XmlAttribute(
        XmlName('xmlns:xsi'),
        'http://www.w3.org/2001/XMLSchema-instance',
      ),
      XmlAttribute(
        XmlName('xsi:schemaLocation'),
        'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2 http://docs.oasis-open.org/ubl/os-UBL-2.3/xsd/maindoc/UBL-Invoice-2.3.xsd',
      ),


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlDocument([
      XmlDeclaration([
        XmlAttribute(XmlName('version'), '1.0'),
        XmlAttribute(XmlName('encoding'), 'UTF-8')
      ]),
      XmlElement(
        XmlName(
          'Invoice',
          'ubl',
        ),
        attributes,
        children,
      ),
    ]);
  }
}

