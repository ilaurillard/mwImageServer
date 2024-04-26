import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/TradeTax.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Util.dart';
import 'package:xml/xml.dart';

class LogisticsServiceCharge {
  final String description;
  final Amount appliedAmount;
  final List<TradeTax> tradeTaxes;

  LogisticsServiceCharge({
    required this.description,
    required this.appliedAmount,
    this.tradeTaxes = const [],
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(name, nest: () {
      Util.stringElement(builder, description, 'ram:Description');
      appliedAmount.toXml(builder, 'ram:AppliedAmount');
      for (TradeTax t in tradeTaxes) {
        t.toXml(builder, 'ram:AppliedTradeTax');
      }
    });
  }

  static LogisticsServiceCharge fromJson(Dict json) {
    return LogisticsServiceCharge(
      description: json['description'] as String? ?? '?',
      appliedAmount: Amount.fromJson(json['appliedAmount'] as Dict? ?? {}) ??
          Amount.empty(),
      tradeTaxes: (json['tradeTaxes'] as List<dynamic>? ?? [])
          .map((dynamic e) => TradeTax.fromJson(e as Dict))
          .toList(),
    );
  }
}
