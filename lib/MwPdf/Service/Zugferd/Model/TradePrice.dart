import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Amount.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Quantity.dart';
import 'package:xml/src/xml/builder.dart';

class TradePrice {
  final Amount chargeAmount;
  final Quantity? basisQuantity;

  TradePrice({
    required this.chargeAmount,
    this.basisQuantity,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        chargeAmount.toXml(builder, 'ram:ChargeAmount');
        if (basisQuantity != null) {
          basisQuantity!.toXml(builder, 'ram:BasisQuantity');
        }
      },
    );
  }
}
