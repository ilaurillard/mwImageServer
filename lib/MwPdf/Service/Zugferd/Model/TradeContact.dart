import 'package:mwcdn/MwPdf/Service/Zugferd/Model/UniversalCommunication.dart';
import 'package:xml/src/xml/builder.dart';

class TradeContact {
  final String? personName;
  final String? departmentName;
  final UniversalCommunication? telephoneUniversalCommunication;
  final UniversalCommunication? faxUniversalCommunication;
  final UniversalCommunication? emailURIUniversalCommunication;

  TradeContact({
    this.personName,
    this.departmentName,
    this.telephoneUniversalCommunication,
    this.faxUniversalCommunication,
    this.emailURIUniversalCommunication,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        if (personName != null) {
          builder.element(
            'ram:PersonName',
            nest: () {
              builder.text(personName!);
            },
          );
        }
        if (departmentName != null) {
          builder.element(
            'ram:DepartmentName',
            nest: () {
              builder.text(departmentName!);
            },
          );
        }
        if (telephoneUniversalCommunication != null) {
          telephoneUniversalCommunication!.toXml(builder, 'ram:TelephoneUniversalCommunication');
        }
        if (faxUniversalCommunication != null) {
          faxUniversalCommunication!.toXml(builder, 'ram:FaxUniversalCommunication');
        }
        if (emailURIUniversalCommunication != null) {
          emailURIUniversalCommunication!.toXml(builder, 'ram:EmailURIUniversalCommunication');
        }
      },
    );
  }
}
