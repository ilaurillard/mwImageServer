import 'dart:io';

import 'lib/Attribute.dart';
import 'lib/ComplexType.dart';
import 'lib/Element.dart';
import 'lib/Schema.dart';
import 'lib/XsdParser.dart';
import 'lib/XsdType.dart';

Future<void> main() async {
  String identifier = 'ubl';
  // String url =
  //     'http://docs.oasis-open.org/ubl/os-UBL-2.3/xsd/maindoc/UBL-Invoice-2.3.xsd';
  String url =
      'http://docs.oasis-open.org/ubl/os-UBL-2.1/xsd/maindoc/UBL-Invoice-2.1.xsd';

  // identifier = 'udt';
  // url = 'http://docs.oasis-open.org/ubl/os-UBL-2.3/xsd/common/BDNDR-UnqualifiedDataTypes-1.1.xsd';

  XsdParser parser = XsdParser(url, identifier);
  await parser.parse();

  print('\n\n');

  Schema ubl = XsdParser.schemaForIdentifier(identifier);
  ComplexType? mainType = ubl.schemaType();

  showType(mainType, 0, []);

  print('\n\nTHANKYOU');
}

void showType(
  XsdType type,
  int depth,
  List<String> visited,
) {
  String tab = (' ' * (depth * 2));
  if (type is ComplexType) {
    String typeName = type.fullname;

    if (visited.contains(typeName)) {

      print('$tab<$typeName> *skip*');

    } else {

      print('$tab<$typeName>');

      visited.add(typeName);

      for (Attribute a in type.attributes.values) {
        print('$tab --${a.name} (${a.type.name})');
      }

      for (Element e in type.elements.values) {

        if (type.bodyType != null) {
          // cannot have children AND cdata
          throw Exception('??? ${type.name}');
        }

        String elementName = e.fullname;

        print('$tab $elementName');

        XsdType? t = e.type;
        if (t == null) {
          // print('  ???');
        } else {
          showType(
            t,
            depth + 1,
            visited,
          );
        }
      }

      if (type.bodyType != null) {
        print('$tab (${type.bodyType!.fullname})');
      }

      // if (type.body != null) {
      //   // print('$tab  X:' + (type.parent?.fullname ?? ''));
      //   showType(
      //     type.body!,
      //     depth + 1,
      //     visited,
      //   );
      // }
    }
  } else {
    throw Exception('??? ${type.name}');
  }
}
