import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Util.dart';
import 'package:xml/xml.dart';

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

  static CreditorFinancialAccount? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return CreditorFinancialAccount(
        ibanId: Id.fromJson(json['ibanId'] as Dict? ?? {}),
        accountName: json['accountName'] as String?,
      );
    }
    return null;
  }
}
