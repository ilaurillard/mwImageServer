import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DocumentLineDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LineTradeAgreement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LineTradeDelivery.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LineTradeSettlement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeProduct.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class SupplyChainTradeLineItem {
  final DocumentLineDocument associatedDocumentLineDocument;
  final TradeProduct specifiedTradeProduct;
  final LineTradeAgreement tradeAgreement;
  final LineTradeDelivery? delivery;
  final LineTradeSettlement specifiedLineTradeSettlement;

  SupplyChainTradeLineItem({
    required this.associatedDocumentLineDocument,
    required this.specifiedTradeProduct,
    required this.tradeAgreement,
    this.delivery,
    required this.specifiedLineTradeSettlement,
  });

  void toXml(XmlBuilder builder) {
    builder.element(
      'ram:IncludedSupplyChainTradeLineItem',
      nest: () {
        builder.element(
          'ram:AssociatedDocumentLineDocument',
          nest: () {
            associatedDocumentLineDocument.toXml(builder);
          },
        );
        builder.element(
          'ram:SpecifiedTradeProduct',
          nest: () {
            specifiedTradeProduct.toXml(builder);
          },
        );
        builder.element(
          'ram:SpecifiedLineTradeAgreement',
          nest: () {
            tradeAgreement.toXml(builder);
          },
        );
        if (delivery != null) {
          builder.element(
            'ram:SpecifiedLineTradeDelivery',
            nest: () {
              delivery!.toXml(builder);
            },
          );
        }
        builder.element(
          'ram:SpecifiedLineTradeSettlement',
          nest: () {
            specifiedLineTradeSettlement.toXml(builder);
          },
        );
      },
    );
  }

  static SupplyChainTradeLineItem fromJson(Dict json) {
    return SupplyChainTradeLineItem(
      associatedDocumentLineDocument: DocumentLineDocument.fromJson(
          json['associatedDocumentLineDocument'] as Dict? ?? {}),
      specifiedTradeProduct:
          TradeProduct.fromJson(json['specifiedTradeProduct'] as Dict? ?? {}),
      tradeAgreement:
          LineTradeAgreement.fromJson(json['tradeAgreement'] as Dict? ?? {}),
      delivery: LineTradeDelivery.fromJson(json['delivery'] as Dict? ?? {}),
      specifiedLineTradeSettlement: LineTradeSettlement.fromJson(
          json['specifiedLineTradeSettlement'] as Dict? ?? {}),
    );
  }
}
