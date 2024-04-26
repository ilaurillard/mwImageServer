import 'package:xml/xml.dart';

import 'ComplexType.dart';
import 'Element.dart';
import 'XsdParser.dart';

class Schema {
  final String identifier;
  final Uri uri;
  final String namespace;
  final XmlDocument document;

  Map<String, ComplexType> types = {};

  Schema({
    required this.identifier,
    required this.uri,
    required this.namespace,
    required this.document,
  });

  ComplexType? typeByName(
    String name,
  ) {
    // if (types[name] == null) {
    //   throw Exception('Type $name not found');
    // }
    return types[name];
  }

  ComplexType schemaType() {
    ComplexType? rootType = typeByName(XsdParser.schemaType);
    if (rootType == null) {
      throw Exception(
        'Have no root/schema type in schema $identifier',
      );
    }
    return rootType;
  }

  Element elementByName(
    String name,
  ) {
    return schemaType().elementByName(name);
  }

  void parse() {
    // unfold
    // print('------');
    // print('Parsing schema $namespace');

    Iterable<XmlElement> cts = document.rootElement.childElements
        .whereType<XmlElement>()
        .where((element) => element.name.qualified == 'xsd:complexType');
    // print(' Found ${cts.length} types');

    for (XmlElement t in cts) {
      ComplexType ct = ComplexType(
        t,
        this,
      );
      types[ct.name] = ct;
    }

    ComplexType rootType = ComplexType(
      document.rootElement,
      this,
    );
    rootType.parse();
    types[rootType.name] = rootType;

    for (ComplexType ct in types.values) {
      if (ct.name != XsdParser.schemaType) {
        ct.parse();
      }
    }
  }
}
