import 'package:xml/xml.dart';

import 'ComplexType.dart';
import 'Schema.dart';
import 'XsdParser.dart';

class Element {
  final XmlElement xml;
  final ComplexType parentType;

  String schemaId = '';
  String name = '';

  late final int minOccurs;
  late final int maxOccurs;

  ComplexType? type;

  Element(
    this.xml,
    this.parentType,
  ) {
    schemaId = parentType.schemaId;
  }

  String get fullname {
    return '$schemaId.$name';
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
        print('    WARNING, ref "$ref" has no type!');
      }

      type = ct;
    } else {
      // print('   Element name=$name type=$typeName');
      ComplexType? ct = parentType.schema.typeByName(typeName);
      if (ct == null) {
        print('    WARNING, "$typeName" not found!');
      } else {
        type = ct;
      }
    }

    // print('    Element "$name" type "${type?.name}"');
  }
}
