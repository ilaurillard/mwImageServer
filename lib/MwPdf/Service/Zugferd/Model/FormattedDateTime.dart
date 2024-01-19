import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DateTimeString.dart';
import 'package:xml/src/xml/builder.dart';

class FormattedDateTime {
  final DateTimeString dateTimeString;

  FormattedDateTime({
    required this.dateTimeString,}
  );

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        dateTimeString.toXml(builder);
      },
    );
  }
}
