import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeCountry.dart';
import 'package:xml/xml.dart';

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

  static TradeProduct fromJson(Dict json) {
    return TradeProduct(
      globalID: Id.fromJson(json['globalID'] as Dict? ?? {}),
      sellerAssignedID: json['sellerAssignedID'] as String?,
      name: json['name'] as String? ?? '?',
      description: json['description'] as String?,
      tradeCountry: TradeCountry.fromJson(json['tradeCountry'] as Dict? ?? {}),
    );
  }
}
