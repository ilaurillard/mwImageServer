import 'package:mwcdn/MwPdf/Service/Zugferd/Model/HeaderTradeAgreement.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/HeaderTradeDelivery.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/HeaderTradeSettlement.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/SupplyChainTradeLineItem.dart';
import 'package:xml/src/xml/builder.dart';

class SupplyChainTradeTransaction {
  final List<SupplyChainTradeLineItem> lineItems;
  final HeaderTradeAgreement applicableHeaderTradeAgreement;
  final HeaderTradeDelivery applicableHeaderTradeDelivery;
  final HeaderTradeSettlement applicableHeaderTradeSettlement;

  SupplyChainTradeTransaction({
    this.lineItems = const [],
    required this.applicableHeaderTradeAgreement,
    required this.applicableHeaderTradeDelivery,
    required this.applicableHeaderTradeSettlement,
  });

  void toXml(
    XmlBuilder builder,
  ) {
    builder.element(
      'rsm:SupplyChainTradeTransaction',
      nest: () {
        for (SupplyChainTradeLineItem i in lineItems) {
          i.toXml(builder);
        }
        applicableHeaderTradeAgreement.toXml(builder, 'ram:ApplicableHeaderTradeAgreement');
        applicableHeaderTradeDelivery.toXml(builder, 'ram:ApplicableHeaderTradeDelivery');
        applicableHeaderTradeSettlement.toXml(builder, 'ram:ApplicableHeaderTradeSettlement');

      },
    );
  }
}
