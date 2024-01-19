import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DocumentLineDocument.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/LineTradeAgreement.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/LineTradeDelivery.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/LineTradeSettlement.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeProduct.dart';
import 'package:xml/src/xml/builder.dart';

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
}
