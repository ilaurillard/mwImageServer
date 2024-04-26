import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/SupplyChainEvent.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/TradeParty.dart';
import 'package:xml/xml.dart';

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
          deliveryNoteReferencedDocument!
              .toXml(builder, 'ram:DeliveryNoteReferencedDocument');
        }
      },
    );
  }

  static HeaderTradeDelivery fromJson(Dict json) {
    return HeaderTradeDelivery(
      shipToTradeParty:
          TradeParty.fromJson(json['shipToTradeParty'] as Dict? ?? {}),
      chainEvent: SupplyChainEvent.fromJson(json['chainEvent'] as Dict? ?? {}),
      deliveryNoteReferencedDocument: ReferencedDocument.fromJson(
          json['deliveryNoteReferencedDocument'] as Dict? ?? {}),
    );
  }
}
