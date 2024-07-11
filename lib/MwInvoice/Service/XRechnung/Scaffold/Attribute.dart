import 'package:xml/xml.dart';

import 'InternalType.dart';

class Attribute {
  final XmlElement xml;

  late final String name;
  late final String typeName;
  late final String use; // required|optional

  late final InternalType type;

  String docString = '';

  Attribute(
    this.xml,
  );

  bool optional() {
    return use == 'optional';
  }

  void parse() {
    name = xml.getAttribute('name') ?? '';
    typeName = xml.getAttribute('type') ?? '';
    use = xml.getAttribute('use') ?? 'optional';
    // print('    Attribute "$name" type "$typeName" [$use]');
    type = InternalType.from(
      typeName,
    );

    Iterable<XmlElement> docs = xml.findAllElements(
      'xsd:documentation',
    );
    if (docs.isNotEmpty) {
      XmlElement doc = docs.first;
      docString = doc.innerText.trim();
      Iterable<XmlElement> defs = doc.findAllElements(
        'ccts:Definition',
      );
      if (defs.isNotEmpty) {
        XmlElement def = defs.first;
        docString = def.innerText.trim();
      }
    }

  }
}
