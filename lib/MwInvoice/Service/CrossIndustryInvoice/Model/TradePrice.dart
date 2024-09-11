import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Quantity.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradePrice {
  final Amount amount;
  final Quantity? quantity;

  TradePrice({
    required this.amount,
    this.quantity,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        amount.toXml(
          builder,
          'ram:ChargeAmount',
        );
        if (quantity != null) {
          quantity!.toXml(
            builder,
            'ram:BasisQuantity',
          );
        }
      },
    );
  }

  static TradePrice? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return TradePrice(
      amount: Amount.fromXml(
            xml.findElements('ram:ChargeAmount').singleOrNull,
          ) ??
          Amount.empty(),
      quantity: Quantity.fromXml(
        xml.findElements('ram:BasisQuantity').singleOrNull,
      ),
    );
  }

  static TradePrice? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return TradePrice(
        amount:
            Amount.fromJson(json['amount'] as Dict? ?? {}) ?? Amount.empty(),
        quantity: Quantity.fromJson(json['quantity'] as Dict? ?? {}),
      );
    }
    return null;
  }

  static TradePrice empty() {
    return TradePrice(
      amount: Amount.empty(),
    );
  }
}
