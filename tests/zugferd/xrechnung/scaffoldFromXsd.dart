import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/ComplexType.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/DartClassFromElement.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/Element.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/Schema.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/XsdParser.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/XsdType.dart';

Future<void> main() async {
  // String dir = '/home/ilja/PhpstormProjects/mwcdn/tests/zugferd/xrechnung/output';
  String dir = '/home/ilja/PhpstormProjects/mwcdn/lib/MwPdf/Service/XRechnung/Model';

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

  Element mainElement = mainType.elements.values.first;
  traverse(mainElement, 0, [], dir);

  print('\n\nTHANKYOU');
}

void traverse(
  Element element,
  int depth,
  List<String> visited,
  String dir,
) {
  String elementName = element.fullname;
  XsdType? type = element.type;
  if (type == null) {

    print('!! WARNING, element $elementName has no type');

    return;
  }

  // String tab = (' ' * (depth * 2));
  if (type is ComplexType) {
    // String typeName = type.fullname;

    if (visited.contains(elementName)) {
      // print('$tab$elementName <$typeName> *skip*');
    } else {
      visited.add(elementName);

      // print('${visited.length}. class ${element.name} (${element.schemaId})');

      DartClassFromElement dc = DartClassFromElement(
        element,
      );
      String code = (dc.render());
      dc.write(
        dir,
        code,
      );

      // print('$tab$elementName <$typeName>');

      // ATTRIBUTES
      // for (Attribute a in type.attributes.values) {
        // print('$tab --${a.name} (${a.type.name})');
      // }

      // CHILDREN
      for (Element childElement in type.elements.values) {
        if (type.bodyType != null) {
          // cannot have children AND cdata
          throw Exception('??? ${type.name}');
        }

        traverse(
          childElement,
          depth + 1,
          visited,
          dir,
        );
      }
    }
  } else {
    throw Exception('??? ${type.name}');
  }
}
