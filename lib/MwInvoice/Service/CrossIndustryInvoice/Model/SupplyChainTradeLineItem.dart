import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DocumentLineDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LineTradeAgreement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LineTradeDelivery.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LineTradeSettlement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeProduct.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class SupplyChainTradeLineItem {
  final DocumentLineDocument documentLineDocument;
  final TradeProduct product;
  final LineTradeAgreement tradeAgreement;
  final LineTradeDelivery? delivery;
  final LineTradeSettlement lineTradeSettlement;

  SupplyChainTradeLineItem({
    required this.documentLineDocument,
    required this.product,
    required this.tradeAgreement,
    this.delivery,
    required this.lineTradeSettlement,
  });

  void toXml(
    XmlBuilder builder,
  ) {
    builder.element(
      'ram:IncludedSupplyChainTradeLineItem',
      nest: () {
        builder.element(
          'ram:AssociatedDocumentLineDocument',
          nest: () {
            documentLineDocument.toXml(builder);
          },
        );
        builder.element(
          'ram:SpecifiedTradeProduct',
          nest: () {
            product.toXml(builder);
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
            lineTradeSettlement.toXml(builder);
          },
        );
      },
    );
  }

  static SupplyChainTradeLineItem? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return SupplyChainTradeLineItem(
      documentLineDocument: DocumentLineDocument.fromXml(
        xml.findElements('ram:AssociatedDocumentLineDocument').singleOrNull,
      )!,
      product: TradeProduct.fromXml(
        xml.findElements('ram:SpecifiedTradeProduct').singleOrNull,
      )!,
      tradeAgreement: LineTradeAgreement.fromXml(
        xml.findElements('ram:SpecifiedLineTradeAgreement').singleOrNull,
      )!,
      lineTradeSettlement: LineTradeSettlement.fromXml(
        xml.findElements('ram:SpecifiedLineTradeSettlement').singleOrNull,
      )!,
      delivery: LineTradeDelivery.fromXml(
        xml.findElements('ram:SpecifiedLineTradeDelivery').singleOrNull,
      ),
    );
  }

  static SupplyChainTradeLineItem fromJson(
    Dict json,
  ) {
    return SupplyChainTradeLineItem(
      documentLineDocument: DocumentLineDocument.fromJson(
          json['documentLineDocument'] as Dict? ?? {})!,
      product: TradeProduct.fromJson(json['product'] as Dict? ?? {}),
      tradeAgreement:
          LineTradeAgreement.fromJson(json['tradeAgreement'] as Dict? ?? {}),
      delivery: LineTradeDelivery.fromJson(json['delivery'] as Dict? ?? {}),
      lineTradeSettlement: LineTradeSettlement.fromJson(
          json['lineTradeSettlement'] as Dict? ?? {}),
    );
  }
}
