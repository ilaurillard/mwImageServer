import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Amount.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeTax.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
import 'package:xml/src/xml/builder.dart';

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
}
