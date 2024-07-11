import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:xml/xml.dart';

class TradeAccountingAccount {
  final Id id;
  final String? typeCode;

  TradeAccountingAccount({
    required this.id,
    this.typeCode,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        id.toXml(builder, 'ram:ID');
        if (typeCode != null) {
          builder.element('ram:TypeCode', nest: () {
            builder.text(typeCode!);
          });
        }
      },
    );
  }

  static TradeAccountingAccount fromJson(Dict json) {
    return TradeAccountingAccount(
      id: Id.fromJson(json['id'] as Dict? ?? {}) ?? Id.empty(),
      typeCode: json['typeCode'] as String?,
    );
  }
}
