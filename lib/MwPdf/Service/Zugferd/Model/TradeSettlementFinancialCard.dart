import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
import 'package:xml/src/xml/builder.dart';

class TradeSettlementFinancialCard {
  final Id id;
  final String? cardholderName;

  TradeSettlementFinancialCard({
    required this.id,
    this.cardholderName,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(name, nest: () {
      id.toXml(builder, 'ram:ID');
      Util.stringElement(builder, cardholderName, 'ram:CardholderName');
    });
  }
}
