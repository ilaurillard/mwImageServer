import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/LineExtensionAmount.dart';
import '../cac/Item.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/UUID.dart';
import '../cbc/Note.dart';
import '../cbc/InvoicedQuantity.dart';
import '../cbc/TaxInclusiveLineExtensionAmount.dart';
import '../cbc/TaxPointDate.dart';
import '../cbc/AccountingCostCode.dart';
import '../cbc/AccountingCost.dart';
import '../cbc/PaymentPurposeCode.dart';
import '../cbc/FreeOfChargeIndicator.dart';
import '../cac/InvoicePeriod.dart';
import '../cac/OrderLineReference.dart';
import '../cac/DespatchLineReference.dart';
import '../cac/ReceiptLineReference.dart';
import '../cac/BillingReference.dart';
import '../cac/DocumentReference.dart';
import '../cac/PricingReference.dart';
import '../cac/OriginatorParty.dart';
import '../cac/Delivery.dart';
import '../cac/PaymentTerms.dart';
import '../cac/AllowanceCharge.dart';
import '../cac/TaxTotal.dart';
import '../cac/WithholdingTaxTotal.dart';
import '../cac/Price.dart';
import '../cac/DeliveryTerms.dart';
import '../cac/SubInvoiceLine.dart';
import '../cac/ItemPriceExtension.dart';

// A class to define a line in an Invoice.
class InvoiceLine {


  // An identifier for this invoice line.
  final ID iD;

  // The total amount for this invoice line, including allowance charges but net of taxes.
  final LineExtensionAmount lineExtensionAmount;

  // The item associated with this invoice line.
  final Item item;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A universally unique identifier for this invoice line.
  final UUID? uUID;

  // Free-form text conveying information that is not contained explicitly in other structures.
  final List<Note> note;

  // The quantity (of items) on this invoice line.
  final InvoicedQuantity? invoicedQuantity;

  // The total amount for this invoice line, including all allowances, charges and taxes.
  final TaxInclusiveLineExtensionAmount? taxInclusiveLineExtensionAmount;

  // The date of this invoice line, used to indicate the point at which tax becomes applicable.
  final TaxPointDate? taxPointDate;

  // The buyer's accounting cost centre for this invoice line, expressed as a code.
  final AccountingCostCode? accountingCostCode;

  // The buyer's accounting cost centre for this invoice line, expressed as text.
  final AccountingCost? accountingCost;

  // A code signifying the business purpose for this payment.
  final PaymentPurposeCode? paymentPurposeCode;

  // An indicator that this invoice line is free of charge (true) or not (false). The default is false.
  final FreeOfChargeIndicator? freeOfChargeIndicator;

  // An invoice period to which this invoice line applies.
  final List<InvoicePeriod> invoicePeriod;

  // A reference to an order line associated with this invoice line.
  final List<OrderLineReference> orderLineReference;

  // A reference to a despatch line associated with this invoice line.
  final List<DespatchLineReference> despatchLineReference;

  // A reference to a receipt line associated with this invoice line.
  final List<ReceiptLineReference> receiptLineReference;

  // A reference to a billing document associated with this invoice line.
  final List<BillingReference> billingReference;

  // A reference to a document associated with this invoice line.
  final List<DocumentReference> documentReference;

  // A reference to pricing and item location information associated with this invoice line.
  final PricingReference? pricingReference;

  // The party who originated the Order to which the Invoice is related.
  final OriginatorParty? originatorParty;

  // A delivery associated with this invoice line.
  final List<Delivery> delivery;

  // A specification of payment terms associated with this invoice line.
  final List<PaymentTerms> paymentTerms;

  // An allowance or charge associated with this invoice line.
  final List<AllowanceCharge> allowanceCharge;

  // A total amount of taxes of a particular kind applicable to this invoice line.
  final List<TaxTotal> taxTotal;

  // A reference to a TaxTotal class describing the amount that has been withhold by the authorities, e.g. if the creditor is in dept because of non paid taxes.
  final List<WithholdingTaxTotal> withholdingTaxTotal;

  // The price of the item associated with this invoice line.
  final Price? price;

  // Terms and conditions of the delivery associated with this invoice line.
  final DeliveryTerms? deliveryTerms;

  // An invoice line subsidiary to this invoice line.
  final List<SubInvoiceLine> subInvoiceLine;

  // The price extension, calculated by multiplying the price per unit by the quantity of items on this invoice line.
  final ItemPriceExtension? itemPriceExtension;

  InvoiceLine ({
    required this.iD,
    required this.lineExtensionAmount,
    required this.item,
    this.uBLExtensions,
    this.uUID,
    this.note = const [],
    this.invoicedQuantity,
    this.taxInclusiveLineExtensionAmount,
    this.taxPointDate,
    this.accountingCostCode,
    this.accountingCost,
    this.paymentPurposeCode,
    this.freeOfChargeIndicator,
    this.invoicePeriod = const [],
    this.orderLineReference = const [],
    this.despatchLineReference = const [],
    this.receiptLineReference = const [],
    this.billingReference = const [],
    this.documentReference = const [],
    this.pricingReference,
    this.originatorParty,
    this.delivery = const [],
    this.paymentTerms = const [],
    this.allowanceCharge = const [],
    this.taxTotal = const [],
    this.withholdingTaxTotal = const [],
    this.price,
    this.deliveryTerms,
    this.subInvoiceLine = const [],
    this.itemPriceExtension,
  });

  static InvoiceLine? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return InvoiceLine (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      note: (json['note'] as List? ?? []).map((dynamic d) => Note.fromJson(d as Map<String, dynamic>?)!).toList(),
      invoicedQuantity: InvoicedQuantity.fromJson(json['invoicedQuantity'] as Map<String, dynamic>?),
      lineExtensionAmount: LineExtensionAmount.fromJson(json['lineExtensionAmount'] as Map<String, dynamic>?)!,
      taxInclusiveLineExtensionAmount: TaxInclusiveLineExtensionAmount.fromJson(json['taxInclusiveLineExtensionAmount'] as Map<String, dynamic>?),
      taxPointDate: TaxPointDate.fromJson(json['taxPointDate'] as Map<String, dynamic>?),
      accountingCostCode: AccountingCostCode.fromJson(json['accountingCostCode'] as Map<String, dynamic>?),
      accountingCost: AccountingCost.fromJson(json['accountingCost'] as Map<String, dynamic>?),
      paymentPurposeCode: PaymentPurposeCode.fromJson(json['paymentPurposeCode'] as Map<String, dynamic>?),
      freeOfChargeIndicator: FreeOfChargeIndicator.fromJson(json['freeOfChargeIndicator'] as Map<String, dynamic>?),
      invoicePeriod: (json['invoicePeriod'] as List? ?? []).map((dynamic d) => InvoicePeriod.fromJson(d as Map<String, dynamic>?)!).toList(),
      orderLineReference: (json['orderLineReference'] as List? ?? []).map((dynamic d) => OrderLineReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      despatchLineReference: (json['despatchLineReference'] as List? ?? []).map((dynamic d) => DespatchLineReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      receiptLineReference: (json['receiptLineReference'] as List? ?? []).map((dynamic d) => ReceiptLineReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      billingReference: (json['billingReference'] as List? ?? []).map((dynamic d) => BillingReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      documentReference: (json['documentReference'] as List? ?? []).map((dynamic d) => DocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      pricingReference: PricingReference.fromJson(json['pricingReference'] as Map<String, dynamic>?),
      originatorParty: OriginatorParty.fromJson(json['originatorParty'] as Map<String, dynamic>?),
      delivery: (json['delivery'] as List? ?? []).map((dynamic d) => Delivery.fromJson(d as Map<String, dynamic>?)!).toList(),
      paymentTerms: (json['paymentTerms'] as List? ?? []).map((dynamic d) => PaymentTerms.fromJson(d as Map<String, dynamic>?)!).toList(),
      allowanceCharge: (json['allowanceCharge'] as List? ?? []).map((dynamic d) => AllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      taxTotal: (json['taxTotal'] as List? ?? []).map((dynamic d) => TaxTotal.fromJson(d as Map<String, dynamic>?)!).toList(),
      withholdingTaxTotal: (json['withholdingTaxTotal'] as List? ?? []).map((dynamic d) => WithholdingTaxTotal.fromJson(d as Map<String, dynamic>?)!).toList(),
      item: Item.fromJson(json['item'] as Map<String, dynamic>?)!,
      price: Price.fromJson(json['price'] as Map<String, dynamic>?),
      deliveryTerms: DeliveryTerms.fromJson(json['deliveryTerms'] as Map<String, dynamic>?),
      subInvoiceLine: (json['subInvoiceLine'] as List? ?? []).map((dynamic d) => SubInvoiceLine.fromJson(d as Map<String, dynamic>?)!).toList(),
      itemPriceExtension: ItemPriceExtension.fromJson(json['itemPriceExtension'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'uUID': uUID?.toJson(),
      'note': note.map((e) => e.toJson()).toList(),
      'invoicedQuantity': invoicedQuantity?.toJson(),
      'lineExtensionAmount': lineExtensionAmount.toJson(),
      'taxInclusiveLineExtensionAmount': taxInclusiveLineExtensionAmount?.toJson(),
      'taxPointDate': taxPointDate?.toJson(),
      'accountingCostCode': accountingCostCode?.toJson(),
      'accountingCost': accountingCost?.toJson(),
      'paymentPurposeCode': paymentPurposeCode?.toJson(),
      'freeOfChargeIndicator': freeOfChargeIndicator?.toJson(),
      'invoicePeriod': invoicePeriod.map((e) => e.toJson()).toList(),
      'orderLineReference': orderLineReference.map((e) => e.toJson()).toList(),
      'despatchLineReference': despatchLineReference.map((e) => e.toJson()).toList(),
      'receiptLineReference': receiptLineReference.map((e) => e.toJson()).toList(),
      'billingReference': billingReference.map((e) => e.toJson()).toList(),
      'documentReference': documentReference.map((e) => e.toJson()).toList(),
      'pricingReference': pricingReference?.toJson(),
      'originatorParty': originatorParty?.toJson(),
      'delivery': delivery.map((e) => e.toJson()).toList(),
      'paymentTerms': paymentTerms.map((e) => e.toJson()).toList(),
      'allowanceCharge': allowanceCharge.map((e) => e.toJson()).toList(),
      'taxTotal': taxTotal.map((e) => e.toJson()).toList(),
      'withholdingTaxTotal': withholdingTaxTotal.map((e) => e.toJson()).toList(),
      'item': item.toJson(),
      'price': price?.toJson(),
      'deliveryTerms': deliveryTerms?.toJson(),
      'subInvoiceLine': subInvoiceLine.map((e) => e.toJson()).toList(),
      'itemPriceExtension': itemPriceExtension?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static InvoiceLine? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return InvoiceLine (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      uUID: UUID.fromXml(xml.findElements('cbc:UUID').singleOrNull),
      note: xml.findElements('cbc:Note').map((XmlElement e) => Note.fromXml(e)!).toList(),
      invoicedQuantity: InvoicedQuantity.fromXml(xml.findElements('cbc:InvoicedQuantity').singleOrNull),
      lineExtensionAmount: LineExtensionAmount.fromXml(xml.findElements('cbc:LineExtensionAmount').singleOrNull)!,
      taxInclusiveLineExtensionAmount: TaxInclusiveLineExtensionAmount.fromXml(xml.findElements('cbc:TaxInclusiveLineExtensionAmount').singleOrNull),
      taxPointDate: TaxPointDate.fromXml(xml.findElements('cbc:TaxPointDate').singleOrNull),
      accountingCostCode: AccountingCostCode.fromXml(xml.findElements('cbc:AccountingCostCode').singleOrNull),
      accountingCost: AccountingCost.fromXml(xml.findElements('cbc:AccountingCost').singleOrNull),
      paymentPurposeCode: PaymentPurposeCode.fromXml(xml.findElements('cbc:PaymentPurposeCode').singleOrNull),
      freeOfChargeIndicator: FreeOfChargeIndicator.fromXml(xml.findElements('cbc:FreeOfChargeIndicator').singleOrNull),
      invoicePeriod: xml.findElements('cac:InvoicePeriod').map((XmlElement e) => InvoicePeriod.fromXml(e)!).toList(),
      orderLineReference: xml.findElements('cac:OrderLineReference').map((XmlElement e) => OrderLineReference.fromXml(e)!).toList(),
      despatchLineReference: xml.findElements('cac:DespatchLineReference').map((XmlElement e) => DespatchLineReference.fromXml(e)!).toList(),
      receiptLineReference: xml.findElements('cac:ReceiptLineReference').map((XmlElement e) => ReceiptLineReference.fromXml(e)!).toList(),
      billingReference: xml.findElements('cac:BillingReference').map((XmlElement e) => BillingReference.fromXml(e)!).toList(),
      documentReference: xml.findElements('cac:DocumentReference').map((XmlElement e) => DocumentReference.fromXml(e)!).toList(),
      pricingReference: PricingReference.fromXml(xml.findElements('cac:PricingReference').singleOrNull),
      originatorParty: OriginatorParty.fromXml(xml.findElements('cac:OriginatorParty').singleOrNull),
      delivery: xml.findElements('cac:Delivery').map((XmlElement e) => Delivery.fromXml(e)!).toList(),
      paymentTerms: xml.findElements('cac:PaymentTerms').map((XmlElement e) => PaymentTerms.fromXml(e)!).toList(),
      allowanceCharge: xml.findElements('cac:AllowanceCharge').map((XmlElement e) => AllowanceCharge.fromXml(e)!).toList(),
      taxTotal: xml.findElements('cac:TaxTotal').map((XmlElement e) => TaxTotal.fromXml(e)!).toList(),
      withholdingTaxTotal: xml.findElements('cac:WithholdingTaxTotal').map((XmlElement e) => WithholdingTaxTotal.fromXml(e)!).toList(),
      item: Item.fromXml(xml.findElements('cac:Item').singleOrNull)!,
      price: Price.fromXml(xml.findElements('cac:Price').singleOrNull),
      deliveryTerms: DeliveryTerms.fromXml(xml.findElements('cac:DeliveryTerms').singleOrNull),
      subInvoiceLine: xml.findElements('cac:SubInvoiceLine').map((XmlElement e) => SubInvoiceLine.fromXml(e)!).toList(),
      itemPriceExtension: ItemPriceExtension.fromXml(xml.findElements('cac:ItemPriceExtension').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      uUID?.toXml(),
      ...note.map((Note e) => e.toXml()).toList(),
      invoicedQuantity?.toXml(),
      lineExtensionAmount.toXml(),
      taxInclusiveLineExtensionAmount?.toXml(),
      taxPointDate?.toXml(),
      accountingCostCode?.toXml(),
      accountingCost?.toXml(),
      paymentPurposeCode?.toXml(),
      freeOfChargeIndicator?.toXml(),
      ...invoicePeriod.map((InvoicePeriod e) => e.toXml()).toList(),
      ...orderLineReference.map((OrderLineReference e) => e.toXml()).toList(),
      ...despatchLineReference.map((DespatchLineReference e) => e.toXml()).toList(),
      ...receiptLineReference.map((ReceiptLineReference e) => e.toXml()).toList(),
      ...billingReference.map((BillingReference e) => e.toXml()).toList(),
      ...documentReference.map((DocumentReference e) => e.toXml()).toList(),
      pricingReference?.toXml(),
      originatorParty?.toXml(),
      ...delivery.map((Delivery e) => e.toXml()).toList(),
      ...paymentTerms.map((PaymentTerms e) => e.toXml()).toList(),
      ...allowanceCharge.map((AllowanceCharge e) => e.toXml()).toList(),
      ...taxTotal.map((TaxTotal e) => e.toXml()).toList(),
      ...withholdingTaxTotal.map((WithholdingTaxTotal e) => e.toXml()).toList(),
      item.toXml(),
      price?.toXml(),
      deliveryTerms?.toXml(),
      ...subInvoiceLine.map((SubInvoiceLine e) => e.toXml()).toList(),
      itemPriceExtension?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'InvoiceLine',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

