import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/LineExtensionAmount.dart';
import '../cac/Item.dart';
import '../cbc/UUID.dart';
import '../cbc/Note.dart';
import '../cbc/InvoicedQuantity.dart';
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
import '../cac/ItemPriceExtension.dart';

// A class to define a line in an Invoice.
class SubInvoiceLine {


  // An identifier for this invoice line.
  final ID iD;

  // The total amount for this invoice line, including allowance charges but net of taxes.
  final LineExtensionAmount lineExtensionAmount;

  // The item associated with this invoice line.
  final Item item;

  // A universally unique identifier for this invoice line.
  final UUID? uUID;

  // Free-form text conveying information that is not contained explicitly in other structures.
  final List<Note> note;

  // The quantity (of items) on this invoice line.
  final InvoicedQuantity? invoicedQuantity;

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

  SubInvoiceLine ({
    required this.iD,
    required this.lineExtensionAmount,
    required this.item,
    this.uUID,
    this.note = const [],
    this.invoicedQuantity,
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD.toJson(),
     'uUID': uUID?.toJson(),
     'note': note.map((e) => e.toJson()).toList(),
     'invoicedQuantity': invoicedQuantity?.toJson(),
     'lineExtensionAmount': lineExtensionAmount.toJson(),
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

}

