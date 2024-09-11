import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class LegalOrganization {
  final String id;
  final String name;

  LegalOrganization({
    required this.id,
    required this.name,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        Util.stringElement(
          builder,
          id,
          'ram:ID',
        );
        Util.stringElement(
          builder,
          this.name,
          'ram:TradingBusinessName',
        );
      },
    );
  }

  static LegalOrganization? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return LegalOrganization(
      id: xml.findElements('ram:ID').singleOrNull?.innerText ?? '',
      name: xml.findElements('ram:TradingBusinessName').singleOrNull?.innerText ?? '',
    );

  }

  static LegalOrganization? fromJson(
    Dict json,
  ) {
    return json.isNotEmpty
        ? LegalOrganization(
            id: json['id'] as String? ?? '?',
            name: json['name'] as String? ?? '?',
          )
        : null;
  }
}
