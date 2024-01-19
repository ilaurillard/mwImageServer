import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Quantity.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/SupplyChainEvent.dart';
import 'package:xml/src/xml/builder.dart';

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
}
