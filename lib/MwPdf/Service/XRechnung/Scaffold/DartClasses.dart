import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/ComplexType.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/DartClassFromElement.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/XsdType.dart';

import 'Element.dart';
import 'Schema.dart';

class DartClasses {
  final Schema schema;
  final String dir;

  DartClasses(
    this.schema,
    this.dir,
  );

  void execute() {
    ComplexType? mainType = schema.schemaType();
    _traverse(
      element: mainType.elements.values.first,
      visited: [],
    );
  }

  void _traverse({
    required Element element,
    required List<String> visited,
    int depth = 0,
  }) {
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

          _traverse(
            element: childElement,
            visited: visited,
            depth: depth + 1,
          );
        }
      }
    } else {
      throw Exception('??? ${type.name}');
    }
  }
}
