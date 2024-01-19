import 'package:xml/src/xml/builder.dart';

class TradeCountry {
  final String id;

  TradeCountry({
    required this.id,
  });

  void toXml(XmlBuilder builder) {
    builder.element(
      'ram:ID',
      nest: () {
        builder.text(id);
      },
    );
  }
}
