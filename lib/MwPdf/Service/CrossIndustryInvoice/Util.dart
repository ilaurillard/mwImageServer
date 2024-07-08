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

  static String prettyXml(XmlDocument xml)
  {
    return xml.toXmlString(
      pretty: true,
      preserveWhitespace: (XmlNode n) {
        if (n is XmlElement) {
          if (n.name.toString() == 'ram:Content') {
            return true;
          }
          if (n.name.toString() == 'cbc:Note') {
            return true;
          }
        }
        return false;
      },
    );
  }
}