import 'package:xml/src/xml/builder.dart';

class DateTimeString {
  final int format;
  final String value;

  DateTimeString({
    required this.format,
    required this.value,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        builder.attribute('format', format);
        builder.text(value);
      },
    );
  }
}
