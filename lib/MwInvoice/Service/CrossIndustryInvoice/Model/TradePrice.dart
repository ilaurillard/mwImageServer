import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Quantity.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradePrice {
  final Amount chargeAmount;
  final Quantity? basisQuantity;

  TradePrice({
    required this.chargeAmount,
    this.basisQuantity,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        chargeAmount.toXml(
          builder,
          'ram:ChargeAmount',
        );
        if (basisQuantity != null) {
          basisQuantity!.toXml(
            builder,
            'ram:BasisQuantity',
          );
        }
      },
    );
  }

  static TradePrice? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return TradePrice(
        chargeAmount: Amount.fromJson(json['chargeAmount'] as Dict? ?? {}) ??
            Amount.empty(),
        basisQuantity: Quantity.fromJson(json['basisQuantity'] as Dict? ?? {}),
      );
    }
    return null;
  }

  static TradePrice empty() {
    return TradePrice(
      chargeAmount: Amount.empty(),
    );
  }
}
