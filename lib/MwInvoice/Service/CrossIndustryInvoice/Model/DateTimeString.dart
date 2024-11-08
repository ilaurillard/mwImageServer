import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class DateTimeString {
  final int format;
  final String value;

  DateTimeString({
    required this.format,
    required this.value,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        builder.attribute(
          'format',
          format,
        );
        builder.text(value);
      },
    );
  }

  static DateTimeString? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return DateTimeString(
      format: int.tryParse(xml.getAttribute('format') ?? '') ?? 0,
      value: xml.innerText,
    );
  }

  static DateTimeString fromJson(
    Dict json,
  ) {
    return DateTimeString(
      value: json['value'] as String? ?? '0',
      format: int.tryParse(json['format'].toString()) ?? 0,
    );
  }
}
