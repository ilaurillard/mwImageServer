import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/DateTimeString.dart';
import 'package:xml/xml.dart';

class DateTime {
  final DateTimeString dateTimeString;

  DateTime({
    required this.dateTimeString,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        dateTimeString.toXml(
          builder,
          'udt:DateTimeString',
        );
      },
    );
  }

  static DateTime? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return DateTime(
        dateTimeString:
        DateTimeString.fromJson(json['dateTimeString'] as Dict? ?? {}),
      );
    }
    return null;
  }

  static DateTime empty() {
    return DateTime(
      dateTimeString:
      DateTimeString.fromJson({}),
    );
  }
}
