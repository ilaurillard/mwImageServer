import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
import 'package:xml/src/xml/builder.dart';

class CreditorFinancialAccount {
  final Id? ibanId;
  final String? accountName;

  CreditorFinancialAccount({
    this.ibanId,
    this.accountName,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(name, nest: () {
      if (ibanId != null) {
        ibanId!.toXml(builder, 'ram:IBANID');
      }
      Util.stringElement(builder, accountName, 'ram:AccountName');
    });
  }
}
