import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradePrice.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class LineTradeAgreement {
  final TradePrice? grossPrice;
  final TradePrice netPrice;

  LineTradeAgreement({
    this.grossPrice,
    required this.netPrice,
  });

  void toXml(XmlBuilder builder) {
    if (grossPrice != null) {
      grossPrice!.toXml(
        builder,
        'ram:GrossPriceProductTradePrice',
      );
    }
    netPrice.toXml(
      builder,
      'ram:NetPriceProductTradePrice',
    );
  }

  static LineTradeAgreement fromJson(Dict json) {
    return LineTradeAgreement(
      netPrice: TradePrice.fromJson(
            json['netPrice'] as Dict? ?? {},
          ) ??
          TradePrice.empty(),
      grossPrice: TradePrice.fromJson(
        json['grossPrice'] as Dict? ?? {},
      ),
    );
  }
}
