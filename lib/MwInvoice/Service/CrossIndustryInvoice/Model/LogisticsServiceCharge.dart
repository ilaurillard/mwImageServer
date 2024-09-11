import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeTax.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class LogisticsServiceCharge {
  final String description;
  final Amount appliedAmount;
  final List<TradeTax> tradeTax;

  LogisticsServiceCharge({
    required this.description,
    required this.appliedAmount,
    this.tradeTax = const [],
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(name, nest: () {
      Util.stringElement(
        builder,
        description,
        'ram:Description',
      );
      appliedAmount.toXml(
        builder,
        'ram:AppliedAmount',
      );
      for (TradeTax t in tradeTax) {
        t.toXml(
          builder,
          'ram:AppliedTradeTax',
        );
      }
    });
  }

  static LogisticsServiceCharge? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return LogisticsServiceCharge(
      description: Util.innerTextOf(xml, 'ram:Description') ?? '',
      appliedAmount: Amount.fromXml(
            xml.findElements('ram:AppliedAmount').singleOrNull,
          ) ??
          Amount.empty(),
      tradeTax: xml
          .findElements('ram:AppliedTradeTax')
          .map((XmlElement e) => TradeTax.fromXml(e)!)
          .toList(),
    );
  }

  static LogisticsServiceCharge fromJson(
    Dict json,
  ) {
    return LogisticsServiceCharge(
      description: json['description'] as String? ?? '?',
      appliedAmount: Amount.fromJson(json['appliedAmount'] as Dict? ?? {}) ??
          Amount.empty(),
      tradeTax: (json['tradeTax'] as List<dynamic>? ?? [])
          .map((dynamic e) => TradeTax.fromJson(e as Dict))
          .toList(),
    );
  }
}
