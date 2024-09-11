import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/HeaderTradeSettlement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/SupplyChainTradeLineItem.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TaxRegistration.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeParty.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeSettlementPaymentMeans.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeTax.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/ubl/Invoice.dart'
    as x_invoice;
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class Invoice {
  // cross industry invoice
  CrossIndustryInvoice? cii;

  // universal business language
  x_invoice.Invoice? ubl;

  Map<String, String> paramsCache = {};
  List<Map<String, String>> itemsCache = [];

  Invoice({
    this.cii,
    this.ubl,
  }) {
    if (cii != null && ubl != null) {
      throw Exception(
        'cannot be both cii *and* ubl',
      );
    }
  }

  bool get isNotEmpty => cii != null || ubl != null;

  static Invoice fromJson({
    Dict jsonCII = const {},
    Dict jsonUBL = const {},
  }) {
    try {
      return Invoice(
        cii: jsonCII.isNotEmpty
            ? CrossIndustryInvoice.fromJson(
          jsonCII,
        )
            : null,
        ubl: jsonUBL.isNotEmpty
            ? x_invoice.Invoice.fromJson(
          jsonUBL,
        )
            : null,
      );
    }
    catch (e) {
      Console.warning('Parsing invoice data failed: $e');
    }
    return Invoice();
  }

  XmlDocument xml() {
    if (cii != null) {
      return cii?.toXml() ?? XmlDocument();
    }
    return ubl?.toXml() ?? XmlDocument();
  }

  Map<String, String> simplified() {
    if (cii != null) {
      return _simplifiedCii();
    } else if (ubl != null) {
      return _simplifiedUbl();
    }
    return {};
  }

  List<Map<String, String>> simplifiedItems() {
    if (cii != null) {
      return _simplifiedItemsCii();
    } else if (ubl != null) {
      return _simplifiedItemsUbl();
    }
    return [];
  }

  Map<String, String> _simplifiedCii() {
    if (paramsCache.isEmpty) {
      TradeParty? buyerTradeParty =
          cii?.tradeTransaction.headerTradeAgreement.buyerTradeParty;
      TradeParty? sellerTradeParty =
          cii?.tradeTransaction.headerTradeAgreement.sellerTradeParty;

      HeaderTradeSettlement? settlement =
          cii?.tradeTransaction.headerTradeSettlement;

      // find UST-Ident.Nr. ...
      List<TaxRegistration> taxReg = sellerTradeParty?.taxRegistrations ?? [];

      List<Amount> tax = settlement?.summation.taxTotalAmount ?? [];

      // es gibt ggf mehrere summen ihr (währungen?)
      List<Amount> grand = settlement?.summation.grandTotalAmount ?? [];

      List<TradeSettlementPaymentMeans> means =
          settlement?.tradeSettlementPaymentMeans ?? [];

      paramsCache = {
        'invoice.id': cii?.document.id ?? '',
        'invoice.date': cii?.document.issueDateTime.dateTimeString.value ?? '',
        'invoice.buyer.name': buyerTradeParty?.name ?? '',
        'invoice.buyer.address1': buyerTradeParty?.tradeAddress?.lineOne ?? '',
        'invoice.buyer.zipcode': buyerTradeParty?.tradeAddress?.postcode ?? '',
        'invoice.buyer.city': buyerTradeParty?.tradeAddress?.city ?? '',
        'invoice.buyer.id': buyerTradeParty?.id?.value ?? '',
        'invoice.seller.taxNr':
            taxReg.isNotEmpty ? taxReg.first.registration.value : '',
        'invoice.seller.contact': sellerTradeParty?.tradeContact?.personName ??
            sellerTradeParty?.tradeContact?.departmentName ??
            '',
        'invoice.seller.phone':
            sellerTradeParty?.tradeContact?.telephone?.completeNumber ?? '',
        'invoice.seller.email':
            sellerTradeParty?.tradeContact?.email?.uriid?.value ?? '',
        'invoice.seller.name': sellerTradeParty?.name ?? '',
        'invoice.seller.address1':
            sellerTradeParty?.tradeAddress?.lineOne ?? '',
        'invoice.seller.zipcode':
            sellerTradeParty?.tradeAddress?.postcode ?? '',
        'invoice.seller.city': sellerTradeParty?.tradeAddress?.city ?? '',
        'invoice.seller.id': sellerTradeParty?.id?.value ?? '',
        'invoice.total': settlement?.summation.lineTotalAmount?.value ?? '',
        'invoice.taxTotal': tax.isNotEmpty ? tax.first.value : '',
        'invoice.grandTotal': grand.isNotEmpty ? grand.first.value : '',
        'invoice.currency': settlement?.currency ?? '',
        'invoice.payment.ref': settlement?.paymentReference ?? '',
        'invoice.payment.type': means.isNotEmpty ? means.first.typeCode : ''
      };
    }
    return paramsCache;
  }

  List<Map<String, String>> _simplifiedItemsCii() {
    if (itemsCache.isEmpty) {
      itemsCache = [];
      for (SupplyChainTradeLineItem item
          in cii?.tradeTransaction.lineItems ?? []) {
        List<TradeTax> tax = item.lineTradeSettlement.tradeTax;

        itemsCache.add({
          'invoice.item.id': item.product.sellerAssignedID ?? '',
          'invoice.item.name': item.product.name,
          'invoice.item.description': item.product.description ?? '',
          'invoice.item.price': item.tradeAgreement.netPrice.amount.value,
          'invoice.item.quantity':
              item.tradeAgreement.netPrice.quantity?.value ?? '',
          'invoice.item.tax':
              tax.isNotEmpty ? tax.first.rateApplicablePercent ?? '' : '',
        });
      }
    }
    return itemsCache;
  }

  Map<String, String> _simplifiedUbl() {
    // TODO
    if (paramsCache.isEmpty) {
      paramsCache = {};
    }
    return paramsCache;
  }

  List<Map<String, String>> _simplifiedItemsUbl() {
    // TODO
    if (itemsCache.isEmpty) {
      itemsCache = [];
    }
    return itemsCache;
  }
}
