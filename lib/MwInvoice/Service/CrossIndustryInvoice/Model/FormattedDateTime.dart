import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DateTimeString.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class FormattedDateTime {
  final DateTimeString dateTimeString;

  FormattedDateTime({
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
          'qdt:DateTimeString',
        );
      },
    );
  }

  static FormattedDateTime? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return FormattedDateTime(
      dateTimeString: DateTimeString.fromXml(
        xml.findElements('qdt:DateTimeString').singleOrNull,
      )!,
    );
  }

  static FormattedDateTime? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return FormattedDateTime(
        dateTimeString: DateTimeString.fromJson(
          json['dateTimeString'] as Dict? ?? {},
        ),
      );
    }
    return null;
  }
}
