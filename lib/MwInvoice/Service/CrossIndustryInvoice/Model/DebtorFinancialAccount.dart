import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class DebtorFinancialAccount {
  final Id? ibanId;

  DebtorFinancialAccount({
    this.ibanId,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(name, nest: () {
      if (ibanId != null) {
        ibanId!.toXml(
          builder,
          'ram:IBANID',
        );
      }
    });
  }

  static DebtorFinancialAccount? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return DebtorFinancialAccount(
      ibanId: Id.fromXml(
        xml.findElements('ram:IBANID').singleOrNull,
      ),
    );
  }

  static DebtorFinancialAccount? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return DebtorFinancialAccount(
        ibanId: Id.fromJson(json['ibanId'] as Dict? ?? {}),
      );
    }
    return null;
  }
}
