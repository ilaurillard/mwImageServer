import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:xml/xml.dart';

class CreditorFinancialInstitution {
  final Id bicId;

  CreditorFinancialInstitution({
    required this.bicId,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(name, nest: () {
      bicId.toXml(builder, 'ram:BICID');
    });
  }

  static CreditorFinancialInstitution? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return CreditorFinancialInstitution(
        bicId: Id.fromJson(json['bicId'] as Dict? ?? {}) ?? Id.empty(),
      );
    }
    return null;
  }
}
