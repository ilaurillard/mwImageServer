import 'package:xml/xml.dart';

import 'InternalType.dart';

class Attribute {
  final XmlElement xml;

  late final String name;
  late final String typeName;
  late final String use; // required|optional

  late final InternalType type;

  Attribute(
    this.xml,
  );

  void parse() {
    name = xml.getAttribute('name') ?? '';
    typeName = xml.getAttribute('type') ?? '';
    use = xml.getAttribute('use') ?? 'optional';
    // print('    Attribute "$name" type "$typeName" [$use]');
    type = InternalType.from(
      typeName,
    );
  }
}
