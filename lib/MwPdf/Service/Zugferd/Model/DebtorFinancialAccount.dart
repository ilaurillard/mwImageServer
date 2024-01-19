import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:xml/src/xml/builder.dart';

class DebtorFinancialAccount {
  final Id? ibanId;

  DebtorFinancialAccount({
    this.ibanId,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(name, nest: () {
      if (ibanId != null) {
        ibanId!.toXml(builder, 'ram:IBANID');
      }
    });
  }
}
