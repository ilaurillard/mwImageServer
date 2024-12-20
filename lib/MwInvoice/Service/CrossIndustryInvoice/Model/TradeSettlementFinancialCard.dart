import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradeSettlementFinancialCard {
  final Id id;
  final String? cardholderName;

  TradeSettlementFinancialCard({
    required this.id,
    this.cardholderName,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(name, nest: () {
      id.toXml(builder, 'ram:ID');
      Util.stringElement(
        builder,
        cardholderName,
        'ram:CardholderName',
      );
    });
  }

  static TradeSettlementFinancialCard? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return TradeSettlementFinancialCard(
      id: Id.fromXml(
            xml.findElements('ram:ID').singleOrNull,
          ) ??
          Id.empty(),
      cardholderName: Util.innerTextOf(xml, 'ram:CardholderName'),
    );
  }

  static TradeSettlementFinancialCard? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return TradeSettlementFinancialCard(
        id: Id.fromJson(json['id'] as Dict? ?? {}) ?? Id.empty(),
        cardholderName: json['cardholderName'] as String?,
      );
    }
    return null;
  }
}
