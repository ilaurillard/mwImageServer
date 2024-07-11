import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class BinaryObject {
  final String mimeCode;
  final String filename;
  final String value;

  BinaryObject({
    required this.mimeCode,
    required this.filename,
    required this.value,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        builder.attribute('mimeCode', mimeCode);
        builder.attribute('filename', filename);
        builder.text(value);
      },
    );
  }

  static BinaryObject? fromJson(Dict json)
  {
    if (json.isNotEmpty) {
      return BinaryObject(
        value: json['value'] as String? ?? '?',
        mimeCode: json['mimeCode'] as String? ?? '?',
        filename: json['filename'] as String? ?? '?',
      );
    }
    return null;
  }
}
