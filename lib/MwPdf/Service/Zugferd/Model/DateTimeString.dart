import 'package:xml/src/xml/builder.dart';

class DateTimeString {
  final int format;
  final String value;

  DateTimeString({
    required this.format,
    required this.value,
  });

  void toXml(XmlBuilder builder,) {
    builder.element(
      'udt:DateTimeString',
      nest: () {
        builder.attribute('format', format);
        builder.text(value);
      },
    );
  }
}
