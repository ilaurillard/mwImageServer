import 'package:xml/xml.dart';

import 'ComplexType.dart';
import 'Schema.dart';
import 'XsdParser.dart';

class Element {
  final XmlElement xml;
  final ComplexType parentType;

  // final bool refferred;

  String schemaId = '';
  String refSchemaId = '';
  String name = '';

  late final int minOccurs;
  late final int maxOccurs;

  ComplexType? type;

  String docString = '';

  Element(
    this.xml,
    this.parentType,
    //     {
    //   this.refferred = false,
    // }
  ) {
    schemaId = parentType.schemaId;
    refSchemaId = schemaId;
  }

  String get fullname {
    return '$refSchemaId.$name';
  }

  void parse() {
    name = xml.getAttribute('name') ?? '';
    String ref = xml.getAttribute('ref') ?? '';
    String typeName = xml.getAttribute('type') ?? '';

    minOccurs = int.tryParse(xml.getAttribute('minOccurs') ?? '') ?? 0;
    maxOccurs = int.tryParse(xml.getAttribute('maxOccurs') ?? '') ?? 0;

    if (ref.isNotEmpty) {
      // print('   Element ref=$ref');
      Schema refSchema;

      List<String> tmp = ref.split(':');
      if (tmp.length == 2) {
        String refId = tmp[0];
        name = tmp[1];
        if (refId != parentType.schemaId) {
          //   print('###Elem: $name $schemaId $refId ${parentType.name} ${parentType
          //       .schemaId}');
          // }
          // if (name == 'Condition') {
          //   if (refId == 'cbc') {
          refSchemaId = refId;
          // }
        }
        refSchema = XsdParser.schemaForIdentifier(refId);
      } else if (tmp.length == 1) {
        String refId = parentType.schema.identifier;
        name = tmp[0];
        refSchema = XsdParser.schemaForIdentifier(refId);
      } else {
        throw Exception('?');
      }

      Element refElem = refSchema.elementByName(
        name,
      );
      ComplexType? ct = refElem.type;

      if (ct == null) {
        print('!! WARNING, ref "$ref" has no type!');
      }

      type = ct;
    } else {
      // print('   Element name=$name type=$typeName');
      ComplexType? ct = parentType.schema.typeByName(typeName);
      if (ct == null) {
        print('!! WARNING, "$typeName" not found!');
      } else {
        type = ct;
      }
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

    // if (minOccurs == 1 && maxOccurs == 0) {
    //   print(fullname);
    // }

    // print('    Element "$name" type "${type?.name}"');
  }

  List<Schema> referredSchemas() {
    Map<String, bool> used = {};
    if (type != null) {
      for (Element e in type!.elements.values) {
        used[e.refSchemaId] = true;
      }
    }
    List<Schema> schemas = [];
    for (String i in used.keys.toList()) {
      schemas.add(
        XsdParser.schemaForIdentifier(i),
      );
    }
    return schemas;
  }

  Schema mainSchema() {
    return XsdParser.schemaForIdentifier(refSchemaId);
  }
}
