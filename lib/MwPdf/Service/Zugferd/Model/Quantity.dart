import 'package:xml/src/xml/builder.dart';

class Quantity {
  final String unitCode;
  final String value;

  Quantity({
    required this.unitCode,
    required this.value,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        builder.text(value);
        builder.attribute('unitCode', unitCode);
      },
    );
  }
}
