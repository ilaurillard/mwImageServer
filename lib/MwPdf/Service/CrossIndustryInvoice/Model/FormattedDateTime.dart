import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/DateTimeString.dart';
import 'package:xml/xml.dart';

class FormattedDateTime {
  final DateTimeString dateTimeString;

  FormattedDateTime({
    required this.dateTimeString,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        dateTimeString.toXml(builder, 'qdt:DateTimeString');
      },
    );
  }

  static FormattedDateTime? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return FormattedDateTime(
        dateTimeString:
        DateTimeString.fromJson(json['dateTimeString'] as Dict? ?? {}),
      );
    }
    return null;
  }
}
