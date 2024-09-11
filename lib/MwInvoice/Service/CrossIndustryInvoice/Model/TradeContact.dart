import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/UniversalCommunication.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradeContact {
  final String? personName;
  final String? departmentName;
  final UniversalCommunication? telephone;
  final UniversalCommunication? fax;
  final UniversalCommunication? email;

  TradeContact({
    this.personName,
    this.departmentName,
    this.telephone,
    this.fax,
    this.email,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
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
        if (telephone != null) {
          telephone!.toXml(builder, 'ram:TelephoneUniversalCommunication');
        }
        if (fax != null) {
          fax!.toXml(builder, 'ram:FaxUniversalCommunication');
        }
        if (email != null) {
          email!.toXml(builder, 'ram:EmailURIUniversalCommunication');
        }
      },
    );
  }

  static TradeContact? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return TradeContact(
      personName: Util.innerTextOf(xml, 'ram:PersonName'),
      departmentName: Util.innerTextOf(xml, 'ram:DepartmentName'),
      telephone: UniversalCommunication.fromXml(
        xml.findElements('ram:TelephoneUniversalCommunication').singleOrNull,
      ),
      fax: UniversalCommunication.fromXml(
        xml.findElements('ram:FaxUniversalCommunication').singleOrNull,
      ),
      email: UniversalCommunication.fromXml(
        xml.findElements('ram:EmailURIUniversalCommunication').singleOrNull,
      ),
    );
  }

  static TradeContact? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return TradeContact(
        personName: json['personName'] as String?,
        departmentName: json['departmentName'] as String?,
        telephone:
            UniversalCommunication.fromJson(json['telephone'] as Dict? ?? {}),
        fax: UniversalCommunication.fromJson(json['fax'] as Dict? ?? {}),
        email: UniversalCommunication.fromJson(json['email'] as Dict? ?? {}),
      );
    }
    return null;
  }
}
