import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:xml/src/xml/builder.dart';

class TaxRegistration {
  final Id registration;

  TaxRegistration({
    required this.registration,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        registration.toXml(builder, 'ram:ID');
      },
    );
  }
}
