import 'package:xml/src/xml/builder.dart';

class Indicator {
  final bool indicator;

  Indicator({
    required this.indicator,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        builder.element(
          'udt:Indicator',
          nest: () {
            builder.text(indicator ? 'true' : 'false');
          },
        );
      },
    );
  }
}
