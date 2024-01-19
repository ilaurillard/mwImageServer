import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:xml/src/xml/builder.dart';

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
}
