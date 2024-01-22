import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/Quantity.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/SupplyChainEvent.dart';
import 'package:xml/xml.dart';

class LineTradeDelivery {
  final Quantity billedQuantity;
  final SupplyChainEvent? chainEvent;

  LineTradeDelivery({
    required this.billedQuantity,
    this.chainEvent,
  });

  void toXml(XmlBuilder builder) {
    billedQuantity.toXml(builder, 'ram:BilledQuantity');

    if (chainEvent != null) {
      chainEvent!.toXml(builder, 'ram:ActualDeliverySupplyChainEvent');
    }
  }

  static LineTradeDelivery? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return LineTradeDelivery(
        billedQuantity:
            Quantity.fromJson(json['billedQuantity'] as Dict? ?? {}) ??
                Quantity.empty(),
        chainEvent:
            SupplyChainEvent.fromJson(json['chainEvent'] as Dict? ?? {}),
      );
    }
    return null;
  }
}
