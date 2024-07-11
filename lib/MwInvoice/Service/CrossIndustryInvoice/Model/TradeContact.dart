import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/UniversalCommunication.dart';
import 'package:xml/xml.dart';

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
          telephoneUniversalCommunication!
              .toXml(builder, 'ram:TelephoneUniversalCommunication');
        }
        if (faxUniversalCommunication != null) {
          faxUniversalCommunication!
              .toXml(builder, 'ram:FaxUniversalCommunication');
        }
        if (emailURIUniversalCommunication != null) {
          emailURIUniversalCommunication!
              .toXml(builder, 'ram:EmailURIUniversalCommunication');
        }
      },
    );
  }

  static TradeContact? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return TradeContact(
        personName: json['personName'] as String?,
        departmentName: json['departmentName'] as String?,
        telephoneUniversalCommunication: UniversalCommunication.fromJson(json['telephoneUniversalCommunication'] as Dict? ?? {}),
        faxUniversalCommunication: UniversalCommunication.fromJson(json['faxUniversalCommunication'] as Dict? ?? {}),
        emailURIUniversalCommunication: UniversalCommunication.fromJson(json['emailURIUniversalCommunication'] as Dict? ?? {}),
      );
    }
    return null;
  }
}
