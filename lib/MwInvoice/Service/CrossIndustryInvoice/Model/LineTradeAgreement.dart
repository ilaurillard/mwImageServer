import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DocumentLineDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradePrice.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class LineTradeAgreement {
  final TradePrice? grossPrice;
  final TradePrice netPrice;
  final DocumentLineDocument? referencedDocument;

  LineTradeAgreement({
    this.grossPrice,
    required this.netPrice,
    this.referencedDocument,
  });

  void toXml(
    XmlBuilder builder,
  ) {
    if (grossPrice != null) {
      grossPrice!.toXml(
        builder,
        'ram:GrossPriceProductTradePrice',
      );
    }
    if (referencedDocument != null) {
      builder.element(
        'ram:BuyerOrderReferencedDocument',
        nest: () {
          referencedDocument!.toXml(
            builder,
          );
        },
      );
    }
    netPrice.toXml(
      builder,
      'ram:NetPriceProductTradePrice',
    );
  }

  static LineTradeAgreement? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return LineTradeAgreement(
      netPrice: TradePrice.fromXml(
            xml.findElements('ram:NetPriceProductTradePrice').singleOrNull,
          ) ??
          TradePrice.empty(),
      grossPrice: TradePrice.fromXml(
        xml.findElements('ram:GrossPriceProductTradePrice').singleOrNull,
      ),
      referencedDocument: DocumentLineDocument.fromXml(
        xml.findElements('ram:BuyerOrderReferencedDocument').singleOrNull,
      ),
    );
  }

  static LineTradeAgreement fromJson(
    Dict json,
  ) {
    return LineTradeAgreement(
      netPrice: TradePrice.fromJson(
            json['netPrice'] as Dict? ?? {},
          ) ??
          TradePrice.empty(),
      grossPrice: TradePrice.fromJson(
        json['grossPrice'] as Dict? ?? {},
      ),
      referencedDocument: DocumentLineDocument.fromJson(
          json['referencedDocument'] as Dict? ?? {}),
    );
  }
}
