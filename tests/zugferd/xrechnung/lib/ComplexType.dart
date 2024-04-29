import 'package:xml/xml.dart';

import 'Attribute.dart';
import 'Element.dart';
import 'InternalType.dart';
import 'Schema.dart';
import 'XsdParser.dart';
import 'XsdType.dart';

class ComplexType extends XsdType {
  final Schema schema;
  final XmlElement xml; // origin element
  Map<String, Element> elements = {};

  InternalType? bodyType;

  ComplexType(
    this.xml,
    this.schema,
  ) {
    schemaId = schema.identifier;
    name = xml.getAttribute('name') ?? XsdParser.schemaType;
  }

  Element elementByName(
    String name,
  ) {
    if (elements[name] == null) {
      throw Exception('Element $name not found');
    }
    return elements[name]!;
  }

  void parse() {
    // print(' Parsing complexType: $name');

    Iterable<XmlElement> st = xml.childElements
        .whereType<XmlElement>()
        .where((element) => element.name.qualified == 'xsd:simpleContent');
    Iterable<XmlElement> sq = xml.childElements
        .whereType<XmlElement>()
        .where((element) => element.name.qualified == 'xsd:sequence');

    if (st.length == 1) {
      if (sq.length == 1) {
        throw Exception('sequence+simpleContent');
      }
      _parseSimpleContent(st.first);
    } else if (sq.length == 1) {
      _parseSequence(sq.first);
    } else {
      _parseSchema(xml);
    }

    Iterable<XmlElement> attr = xml.childElements
        .whereType<XmlElement>()
        .where((element) => element.name.qualified == 'xsd:attribute');
    for (XmlElement a in attr) {
      Attribute ax = Attribute(a);
      ax.parse();
      attributes[ax.name] = ax;
      print(ax.name);
    }

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

  // @override
  // ComplexType copy() {
  //   ComplexType ct = ComplexType(
  //     xml,
  //     schema,
  //   );
  //
  //   ct.attributes = {...attributes};
  //   ct.elements = {...elements};
  //
  //   return ct;
  // }

  void _parseElements(XmlElement e) {
    Iterable<XmlElement> elems = _allElements(e);
    for (XmlElement e in elems) {
      Element elem = Element(
        e,
        this,
      );
      elem.parse();

      if (elem.name.isEmpty) {
        throw Exception();
      }
      if (elements[elem.name] != null) {
        throw Exception();
      }
      elements[elem.name] = elem;
    }
  }

  void _parseSchema(XmlElement e) {
    // print('  [schema]');
    _parseElements(e);
  }

  void _parseSequence(XmlElement e) {
    // print('  [sequence]');
    _parseElements(e);
  }

  void _parseSimpleContent(XmlElement e) {
    // print('  [simpleContent]');

    Iterable<XmlElement> ext = e.childElements
        .whereType<XmlElement>()
        .where((element) => element.name.qualified == 'xsd:extension');
    Iterable<XmlElement> res = e.childElements
        .whereType<XmlElement>()
        .where((element) => element.name.qualified == 'xsd:restriction');

    String base;
    XmlElement s;

    if (ext.length == 1) {
      s = ext.first;
      base = s.getAttribute('base') ?? '';
      // print('   [extension of $base]');
    } else if (res.length == 1) {
      s = res.first;
      base = s.getAttribute('base') ?? '';
      // print('   [restriction of $base]');
    } else {
      throw Exception('Unsupported');
    }

    parent = _baseType(base);

    // print(fullname + ' <- ' + (parent?.fullname ?? ''));

    // clone parent type
    // XsdType type = parent!.copy();

    bodyType = parent!.internalType();

    // collect attributes
    for (Attribute ax in parent!.attributes.values) {
      attributes[ax.name] = ax;
    }

    if (parent!.docString.isNotEmpty) {
      docString = parent!.docString;
    }

    // override attributes
    Iterable<XmlElement> attr = s.childElements
        .whereType<XmlElement>()
        .where((element) => element.name.qualified == 'xsd:attribute');
    for (XmlElement a in attr) {
      Attribute ax = Attribute(a);
      ax.parse();
      // type.attributes[ax.name] = ax;
      // print(' ' + type.fullname + ' > '  + ax.name);
      attributes[ax.name] = ax;
    }

    Iterable<XmlElement> elems = s.childElements
        .whereType<XmlElement>()
        .where((element) => element.name.qualified == 'xsd:element');
    for (XmlElement e in elems) {
      throw Exception('Unsupported');
    }
  }

  Iterable<XmlElement> _allElements(
    XmlElement e,
  ) {
    Iterable<XmlElement> elements = e.childElements
        .whereType<XmlElement>()
        .where((element) => element.name.qualified == 'xsd:element');
    // print('  Found ${elements.length} elements');
    return elements;
  }

  XsdType _baseType(
    String base,
  ) {
    List<String> tmp = base.split(':');
    if (tmp.length == 2) {
      String refId = tmp[0];
      String refName = tmp[1];
      if (refId == 'xsd') {
        return InternalType.from(
          base,
        );
      } else {
        Schema refSchema = XsdParser.schemaForIdentifier(refId);
        ComplexType? ct = refSchema.typeByName(refName);
        if (ct == null) {
          throw Exception('Type $refId:$refName not found?');
        }

        return ct;
      }
    } else {
      throw Exception('?');
    }
  }
}
