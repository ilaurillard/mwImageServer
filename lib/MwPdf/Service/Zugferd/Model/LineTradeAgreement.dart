import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradePrice.dart';
import 'package:xml/src/xml/builder.dart';

class LineTradeAgreement {
  final TradePrice? grossPrice;
  final TradePrice netPrice;

  LineTradeAgreement({
    this.grossPrice,
    required this.netPrice,
  });

  void toXml(XmlBuilder builder) {

    if (grossPrice != null) {
      grossPrice!.toXml(builder, 'ram:GrossPriceProductTradePrice');
    }

    netPrice.toXml(builder, 'ram:NetPriceProductTradePrice');

  }
}
