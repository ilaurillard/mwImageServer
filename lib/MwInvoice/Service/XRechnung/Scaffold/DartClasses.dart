import 'package:mwcdn/MwInvoice/Service/XRechnung/Scaffold/ComplexType.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Scaffold/DartClassFromElement.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Scaffold/XsdType.dart';

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

    if (type is ComplexType) {

      if (!visited.contains(elementName)) {

        visited.add(elementName);

        DartClassFromElement dc = DartClassFromElement(
          element,
        );
        String code = (dc.render());
        dc.write(
          dir,
          code,
        );

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
