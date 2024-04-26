import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:xml/xml.dart';

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

  static TaxRegistration fromJson(Dict json) {
    return TaxRegistration(
      registration:
          Id.fromJson(json['registration'] as Dict? ?? {}) ?? Id.empty(),
    );
  }
}
