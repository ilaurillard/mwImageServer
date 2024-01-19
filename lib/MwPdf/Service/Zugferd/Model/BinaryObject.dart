import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
import 'package:xml/src/xml/builder.dart';

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
}
