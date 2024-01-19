import 'package:xml/xml.dart';

class Util {


  static void stringElement(
      XmlBuilder builder,
      String? value,
      String name,
      ) {
    if (value != null) {
      builder.element(
        name,
        nest: () {
          builder.text(value);
        },
      );
    }
  }

}