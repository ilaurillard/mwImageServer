import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:xml/src/xml/builder.dart';

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
}
