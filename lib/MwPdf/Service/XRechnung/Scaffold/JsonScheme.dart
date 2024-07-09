import 'dart:convert';
import 'dart:io';

import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/ComplexType.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/DartClassFromElement.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/JsonSchemeFromElement.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/XsdType.dart';
import 'package:path/path.dart';

import 'Element.dart';
import 'Schema.dart';

class JsonScheme {
  final Schema schema;
  final String dir;

  Dict main = {};
  Dict definitions = {
    'XsdTime': {
      'type': 'string',
      'maxLength': 5,
      'minLength': 5,
      'pattern': '^([01][0-9]|2[0-3]):[0-5][0-9]\$',
      'description': 'HH:II'
    },
    'XsdDate': {
      'type': 'string',
      'maxLength': 10,
      'minLength': 10,
      'pattern': '^\\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])\$',
      'description': 'YYYY-MM-DD'
    },
    'ext': <String, dynamic>{
      'ExtensionContent': {
        'description': 'missing type'
      }
    }
  };

  JsonScheme(
    this.schema,
    this.dir,
  );

  void execute() {
    ComplexType? mainType = schema.schemaType();
    _traverse(
      element: mainType.elements.values.first,
      visited: [],
    );
    main['definitions'] = definitions;
    String res = prettyJson(main);

    File f = File(
      join(
        dir,
        'xrechnung_schema.json',
      ),
    );
    if (f.existsSync()) {
      f.deleteSync();
    }
    f.createSync(recursive: true);
    f.writeAsStringSync(res);
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
      String typeName = type.fullname;

      if (visited.contains(elementName)) {
        // print('${' ' * depth}$elementName <$typeName> *skip*');
      } else {
        visited.add(elementName);

        // print('${' ' * depth}$elementName <$typeName>');

        JsonSchemeFromElement js = JsonSchemeFromElement(
          element,
        );
        if (element.refSchemaId == 'ubl' && element.name == 'Invoice') {
          main = (js.render());
        } else {
          if (definitions[element.refSchemaId] == null) {
            definitions[element.refSchemaId] = Dict();
          }
          definitions[element.refSchemaId][element.name] = (js.render());
        }

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

  String prettyJson(Dict jsonObject) {
    var encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(jsonObject);
  }
}
