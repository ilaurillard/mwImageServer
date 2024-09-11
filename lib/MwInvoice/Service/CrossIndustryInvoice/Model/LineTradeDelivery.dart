import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Quantity.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/SupplyChainEvent.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class LineTradeDelivery {
  final Quantity billedQuantity;
  final SupplyChainEvent? chainEvent;
  final ReferencedDocument? referencedDocument;

  LineTradeDelivery({
    required this.billedQuantity,
    this.chainEvent,
    this.referencedDocument,
  });

  void toXml(
    XmlBuilder builder,
  ) {
    billedQuantity.toXml(
      builder,
      'ram:BilledQuantity',
    );
    if (chainEvent != null) {
      chainEvent!.toXml(
        builder,
        'ram:ActualDeliverySupplyChainEvent',
      );
    }
    if (referencedDocument != null) {
      referencedDocument!.toXml(
        builder,
        'ram:DeliveryNoteReferencedDocument',
      );
    }
  }

  static LineTradeDelivery? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return LineTradeDelivery(
      billedQuantity: Quantity.fromXml(
            xml.findElements('ram:BilledQuantity').singleOrNull,
          ) ??
          Quantity.empty(),
      chainEvent: SupplyChainEvent.fromXml(
        xml.findElements('ram:ActualDeliverySupplyChainEvent').singleOrNull,
      ),
      referencedDocument: ReferencedDocument.fromXml(
        xml.findElements('ram:DeliveryNoteReferencedDocument').singleOrNull,
      ),
    );
  }

  static LineTradeDelivery? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return LineTradeDelivery(
        billedQuantity: Quantity.fromJson(
              json['billedQuantity'] as Dict? ?? {},
            ) ??
            Quantity.empty(),
        chainEvent: SupplyChainEvent.fromJson(
          json['chainEvent'] as Dict? ?? {},
        ),
        referencedDocument: ReferencedDocument.fromJson(
          json['referencedDocument'] as Dict? ?? {},
        ),
      );
    }
    return null;
  }
}
