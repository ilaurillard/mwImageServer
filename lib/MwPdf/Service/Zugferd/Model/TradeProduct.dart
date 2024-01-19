import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeCountry.dart';
import 'package:xml/src/xml/builder.dart';

class TradeProduct {
  final Id? globalID;
  final String? sellerAssignedID;
  final String name;
  final String? description;
  final TradeCountry? tradeCountry;

  TradeProduct({
    this.globalID,
    this.sellerAssignedID,
    required this.name,
    this.description,
    this.tradeCountry,
  });

  void toXml(XmlBuilder builder) {
    if (globalID != null) {
      globalID!.toXml(builder, 'ram:GlobalID');
    }
    if (sellerAssignedID != null) {
      builder.element(
        'ram:SellerAssignedID',
        nest: () {
          builder.text(sellerAssignedID!);
        },
      );
    }
    builder.element(
      'ram:Name',
      nest: () {
        builder.text(name);
      },
    );
    if (description != null) {
      builder.element(
        'ram:Description',
        nest: () {
          builder.text(description!);
        },
      );
    }
    if (tradeCountry != null) {
      builder.element(
        'ram:OriginTradeCountry',
        nest: () {
          tradeCountry!.toXml(builder);
        },
      );
    }
  }
}
