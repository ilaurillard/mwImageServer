import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Quantity.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/SupplyChainEvent.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class LineTradeDelivery {
  final Quantity billedQuantity;
  final SupplyChainEvent? chainEvent;
  final ReferencedDocument? deliveryNoteReferencedDocument;

  LineTradeDelivery({
    required this.billedQuantity,
    this.chainEvent,
    this.deliveryNoteReferencedDocument,
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
    if (deliveryNoteReferencedDocument != null) {
      deliveryNoteReferencedDocument!.toXml(
        builder,
        'ram:DeliveryNoteReferencedDocument',
      );
    }
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
        deliveryNoteReferencedDocument: ReferencedDocument.fromJson(
          json['deliveryNoteReferencedDocument'] as Dict? ?? {},
        ),
      );
    }
    return null;
  }
}
