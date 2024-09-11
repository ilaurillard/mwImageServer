import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class UniversalCommunication {
  final String? completeNumber;
  final Id? uriid;

  UniversalCommunication({
    this.completeNumber,
    this.uriid,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        if (completeNumber != null) {
          builder.element(
            'ram:CompleteNumber',
            nest: () {
              builder.text(completeNumber!);
            },
          );
        }
        if (uriid != null) {
          uriid!.toXml(
            builder,
            'ram:URIID',
          );
        }
      },
    );
  }

  static UniversalCommunication? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return UniversalCommunication(
      completeNumber: Util.innerTextOf(
        xml,
        'ram:CompleteNumber',
      ),
      uriid: Id.fromXml(
        xml.findElements('ram:URIID').singleOrNull,
      ),
    );
  }

  static UniversalCommunication? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return UniversalCommunication(
        completeNumber: json['completeNumber'] as String?,
        uriid: Id.fromJson(json['uriid'] as Dict? ?? {}),
      );
    }
    return null;
  }
}
