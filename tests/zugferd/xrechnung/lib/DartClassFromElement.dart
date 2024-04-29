import 'dart:io';

import 'package:path/path.dart';

import 'Attribute.dart';
import 'ComplexType.dart';
import 'Element.dart';

class DartClassFromElement {
  final Element element;

  DartClassFromElement(this.element);

  String _lcfirst(String input) {
    if (input.isEmpty) return input;
    return input[0].toLowerCase() + input.substring(1);
  }

  String render() {
    ComplexType type = element.type!;

    List<String> imports = [];
    List<String> attributes = [];
    List<String> constructorMembers = [];
    List<String> assertions = [];

    // ---------------------------------------------

    for (bool required in [true, false]) {
      if (required) {
        // BODY todo
        if (type.bodyType != null) {

          if (type.bodyType!.docString.isNotEmpty) {
            attributes.add(
              '\n  // ${type.bodyType!.docString}',
            );
          }

          attributes.add(
            '  final String value; // (${type.bodyType!.name})',
          );
          constructorMembers.add(
            '    required this.value',
          );
          // TODO assert not empty??
        }
      }

      // ---------------------------------------------

      // ATTRIBUTES (only internal types / scalars)
      for (Attribute a in type.attributes.values) {
        bool o = a.optional();
        if ((required && !o) || (!required && o)) {

          if (a.docString.isNotEmpty) {
            attributes.add(
              '\n  // ${a.docString}',
            );
          }

          attributes.add(
              '  final String${o ? '?' : ''} ${a.name}; // (${a.type.name})');
          if (required) {
            constructorMembers.add(
              '    required this.${a.name}',
            );
            // TODO assert not empty??
          } else {
            constructorMembers.add(
              '    this.${a.name}',
            );
          }
        }
      }

      // ---------------------------------------------

      // CHILDREN/ELEMENTS
      for (Element childElement in type.elements.values) {
        int minOccurs = childElement.minOccurs;
        int maxOccurs = childElement.maxOccurs;

        if (maxOccurs > 1 || maxOccurs < 0) {
          throw Exception(
              'Can only handle maxOccurs = 0/1 in element ${childElement.fullname}');
        }

        String elementClassName = childElement.name;
        String elementVarName = _lcfirst(elementClassName);
        if (childElement.type == null) {
          print('!! WARNING, element ${childElement.fullname} has no type');
        } else {
          imports.add(
              "import '../${childElement.schemaId}/$elementClassName.dart';");
        }

        bool o = minOccurs == 0;
        if ((required && !o) || (!required && o)) {

          if (childElement.docString.isNotEmpty) {
            attributes.add(
              '\n  // ${childElement.docString}',
            );
          }

          if (maxOccurs == 0) {
            // unbounded -- means: list
            if (childElement.type == null) {
              throw Exception('Cannot handle');
            }

            attributes.add(
              '  final List<$elementClassName> $elementVarName;',
            );

            if (required) {
              constructorMembers.add(
                '    required this.$elementVarName',
              );
              assertions.add(
                '    assert($elementVarName.isNotEmpty);',
              );
            } else {
              constructorMembers.add(
                '    this.$elementVarName = const []',
              );
            }
          } else {
            if (childElement.type == null) {
              attributes.add(
                '  final $elementVarName; // missing type $elementClassName',
              );
            } else {
              attributes.add(
                '  final $elementClassName${o ? '?' : ''} $elementVarName;',
              );
            }

            if (required) {
              constructorMembers.add(
                '    required this.$elementVarName',
              );
            } else {
              constructorMembers.add(
                '    this.$elementVarName',
              );
            }
          }
        }
      }
    }

    String res = '';

    if (imports.isNotEmpty) {
      res += (imports.toSet().toList().join('\n'));
      res += '\n\n';
    }

    // if (element.docString.isNotEmpty) {
    //   res += '// ${element.docString}\n';
    // }
    if (element.type != null && element.type!.docString.isNotEmpty) {
      res += '// ${element.type!.docString}\n';
    }

    res += 'class ${element.name} {\n';
    res += '\n';

    res += (attributes.join('\n'));

    res += '\n\n';
    res += ('  ${element.name} ({\n');
    res += ('${constructorMembers.join(',\n')},\n');
    res += ('  })');

    if (assertions.isNotEmpty) {
      res += (' {\n');
      res += (assertions.join(',\n'));
      res += ('  }\n');
    } else {
      res += (';\n');
    }

    res += ('}\n\n');

    return res;
  }

  void write(
    String dir,
    String code,
  ) {
    File f = File(
      join(
        dir,
        element.schemaId,
        '${element.name}.dart',
      ),
    );
    if (f.existsSync()) {
      f.deleteSync();
    }
    f.createSync(recursive: true);
    f.writeAsStringSync(code);
  }
}
