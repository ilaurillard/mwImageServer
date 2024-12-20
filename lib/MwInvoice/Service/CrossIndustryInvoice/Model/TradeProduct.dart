import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ProductClassification.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeCountry.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradeProduct {
  final Id? globalID;
  final String? sellerAssignedID;
  final String name;
  final String? description;
  final TradeCountry? tradeCountry;
  final ProductClassification? classification;

  TradeProduct({
    this.globalID,
    this.sellerAssignedID,
    required this.name,
    this.description,
    this.tradeCountry,
    this.classification,
  });

  void toXml(
    XmlBuilder builder,
  ) {
    if (globalID != null) {
      globalID!.toXml(
        builder,
        'ram:GlobalID',
      );
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
    if (classification != null) {
      classification!.toXml(
        builder,
        'ram:DesignatedProductClassification',
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

  static TradeProduct? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return TradeProduct(
      globalID: Id.fromXml(
        xml.findElements('ram:GlobalID').singleOrNull,
      ),
      sellerAssignedID: Util.innerTextOf(
        xml,
        'ram:SellerAssignedID',
      ),
      name: Util.innerTextOf(xml, 'ram:Name') ?? '',
      description: Util.innerTextOf(
        xml,
        'ram:Description',
      ),
      tradeCountry: TradeCountry.fromXml(
        xml.findElements('ram:OriginTradeCountry').singleOrNull,
      ),
      classification: ProductClassification.fromXml(
        xml.findElements('ram:DesignatedProductClassification').singleOrNull,
      ),
    );
  }

  static TradeProduct fromJson(
    Dict json,
  ) {
    return TradeProduct(
      globalID: Id.fromJson(json['globalID'] as Dict? ?? {}),
      sellerAssignedID: json['sellerAssignedID'] as String?,
      name: json['name'] as String? ?? '?',
      description: json['description'] as String?,
      tradeCountry: TradeCountry.fromJson(json['tradeCountry'] as Dict? ?? {}),
      classification: ProductClassification.fromJson(
        json['classification'] as Dict? ?? {},
      ),
    );
  }
}
