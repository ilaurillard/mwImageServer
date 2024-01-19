import 'package:xml/src/xml/builder.dart';

class Amount {
  final String value;
  final String? currency;
  Amount({
    required this.value,
    this.currency,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        builder.text(value);
        builder.attribute('currencyID', currency);
      },
    );
  }
}
