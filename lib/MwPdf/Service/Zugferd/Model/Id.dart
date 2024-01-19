import 'package:xml/src/xml/builder.dart';

class Id {
  final String value;
  final String? schemeID;

  Id({
    required this.value,
    this.schemeID,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {

    builder.element(
      name,
      nest: () {
        builder.text(value);
        if (schemeID != null) {
          builder.attribute('schemeID', schemeID!);
        }
      },
    );

  }
}
