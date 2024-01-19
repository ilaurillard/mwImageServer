import 'package:mwcdn/MwPdf/Service/Zugferd/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/SupplyChainEvent.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeParty.dart';
import 'package:xml/src/xml/builder.dart';

class HeaderTradeDelivery {
  final TradeParty? shipToTradeParty;
  final SupplyChainEvent? chainEvent;
  final ReferencedDocument? deliveryNoteReferencedDocument;

  HeaderTradeDelivery({
    this.shipToTradeParty,
    this.chainEvent,
    this.deliveryNoteReferencedDocument,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        if (shipToTradeParty != null) {
          shipToTradeParty!.toXml(builder, 'ram:ShipToTradeParty');
        }
        if (chainEvent != null) {
          chainEvent!.toXml(builder, 'ram:ActualDeliverySupplyChainEvent');
        }
        if (deliveryNoteReferencedDocument != null) {
          deliveryNoteReferencedDocument!.toXml(builder, 'ram:DeliveryNoteReferencedDocument');
        }
      },
    );
  }
}
