import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/HeaderTradeAgreement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/HeaderTradeDelivery.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/HeaderTradeSettlement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/SupplyChainTradeLineItem.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class SupplyChainTradeTransaction {
  final List<SupplyChainTradeLineItem> lineItems;
  final HeaderTradeAgreement headerTradeAgreement;
  final HeaderTradeDelivery headerTradeDelivery;
  final HeaderTradeSettlement headerTradeSettlement;

  SupplyChainTradeTransaction({
    this.lineItems = const [],
    required this.headerTradeAgreement,
    required this.headerTradeDelivery,
    required this.headerTradeSettlement,
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
        headerTradeAgreement.toXml(
          builder,
          'ram:ApplicableHeaderTradeAgreement',
        );
        headerTradeDelivery.toXml(
          builder,
          'ram:ApplicableHeaderTradeDelivery',
        );
        headerTradeSettlement.toXml(
          builder,
          'ram:ApplicableHeaderTradeSettlement',
        );
      },
    );
  }

  static SupplyChainTradeTransaction fromJson(
    Dict json,
  ) {
    return SupplyChainTradeTransaction(
      lineItems: (json['lineItems'] as List<dynamic>? ?? [])
          .map((dynamic e) => SupplyChainTradeLineItem.fromJson(e as Dict))
          .toList(),
      headerTradeAgreement: HeaderTradeAgreement.fromJson(
        json['headerTradeAgreement'] as Dict? ?? {},
      ),
      headerTradeDelivery: HeaderTradeDelivery.fromJson(
        json['headerTradeDelivery'] as Dict? ?? {},
      ),
      headerTradeSettlement: HeaderTradeSettlement.fromJson(
        json['headerTradeSettlement'] as Dict? ?? {},
      ),
    );
  }
}
