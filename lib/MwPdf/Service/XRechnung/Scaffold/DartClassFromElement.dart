import 'dart:io';

import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/XsdParser.dart';
import 'package:path/path.dart';

import 'Attribute.dart';
import 'ComplexType.dart';
import 'Element.dart';
import 'Schema.dart';

class DartClassFromElement {
  final Element _element;
  late final ComplexType _type;

  final List<String> _imports = [];
  final List<String> _attributes = [];
  final List<String> _constructorMembers = [];
  final List<String> _assertions = [];
  final List<String> _methods = [];

  DartClassFromElement(this._element) {
    _type = _element.type!;
    _imports.add("import 'dart:convert';");
    _imports.add("import '../../Etc/Util.dart';");
    _imports.add("import 'package:xml/xml.dart';");
  }

  String _lcfirst(String input) {
    if (input.isEmpty) return input;
    return input[0].toLowerCase() + input.substring(1);
  }

  String render() {
    for (bool required in [true, false]) {
      _prepareValue(required);
      _prepareAttributes(required);
      _prepareChildren(required);
    }

    __prepareMethods();

    return _render();
  }

  void write(
    String dir,
    String code,
  ) {
    File f = File(
      join(
        dir,
        _element.refSchemaId,
        '${_element.name}.dart',
      ),
    );
    if (f.existsSync()) {
      f.deleteSync();
    }
    f.createSync(recursive: true);
    f.writeAsStringSync(code);
  }

  String _render() {
    String res = '';

    if (_imports.isNotEmpty) {
      res += (_imports.toSet().toList().join('\n'));
      res += '\n\n';
    }

    if (_element.type != null && _element.type!.docString.isNotEmpty) {
      res += '// ${_element.type!.docString}\n';
    }

    res += 'class ${_element.name} {\n';
    res += '\n';

    res += (_attributes.join('\n'));

    res += '\n\n';
    if (_constructorMembers.isNotEmpty) {
      res += ('  ${_element.name} ({\n');
      res += ('${_constructorMembers.join(',\n')},\n');
      res += ('  })');

      if (_assertions.isNotEmpty) {
        res += (' {\n');
        res += '${_assertions.join('\n')}\n';
        res += ('  }\n');
      } else {
        res += (';\n');
      }
    }

    res += ('\n');
    res += (_methods.join('\n'));

    res += ('}\n\n');

    return res;
  }

  void _prepareValue(bool required) {
    // CDATA/VALUE ATTRIBUTE
    if (required) {
      // BODY todo
      if (_type.bodyType != null) {
        if (_type.bodyType!.docString.isNotEmpty) {
          _attributes.add(
            '\n  // ${_type.bodyType!.docString}',
          );
        }

        String s = _type.bodyType!.scalarType();
        _attributes.add(
          '  final $s value; // (${_type.bodyType!.name})',
        );
        _constructorMembers.add(
          '    required this.value',
        );
        // TODO assert not empty??
        if (s == 'String') {
          _assertions.add(
            '    assert(value.isNotEmpty);',
          );
        }
      }
    }
  }

  void _prepareAttributes(bool required) {
    // ATTRIBUTES (only internal types / scalars)
    for (Attribute a in _type.attributes.values) {
      bool o = a.optional();
      if ((required && !o) || (!required && o)) {
        if (a.docString.isNotEmpty) {
          _attributes.add(
            '\n  // ${a.docString}',
          );
        }

        String s = a.type.scalarType();
        _attributes
            .add('  final $s${o ? '?' : ''} ${a.name}; // (${a.type.name})');
        if (required) {
          _constructorMembers.add(
            '    required this.${a.name}',
          );
          // TODO assert not empty??
          if (s == 'String' && !o) {
            _assertions.add(
              '    assert(${a.name}.isNotEmpty);',
            );
          }
        } else {
          _constructorMembers.add(
            '    this.${a.name}',
          );
        }
      }
    }
  }

  void _prepareChildren(bool required) {
    // CHILDREN/ELEMENTS
    for (Element childElement in _type.elements.values) {
      int minOccurs = childElement.minOccurs;
      int maxOccurs = childElement.maxOccurs;
      bool o = minOccurs == 0;
      if ((required && !o) || (!required && o)) {
        if (maxOccurs > 1 || maxOccurs < 0) {
          throw Exception(
            'Can only handle maxOccurs = 0/1 in element ${childElement.fullname}',
          );
        }

        String elementClassName = childElement.name;
        String elementVarName = _lcfirst(elementClassName);
        if (childElement.type == null) {
          print(
            '!! WARNING, element ${childElement.fullname} has no type',
          );
        } else {
          if (childElement.refSchemaId != _element.refSchemaId ||
              elementClassName != _element.name) {
            _imports.add(
              "import '../${childElement.refSchemaId}/$elementClassName.dart';",
            );
          }
        }

        if (childElement.docString.isNotEmpty) {
          _attributes.add(
            '\n  // ${childElement.docString}',
          );
        }

        if (maxOccurs == 0) {
          // unbounded -- means: list
          if (childElement.type == null) {
            throw Exception('Cannot handle');
          }

          _attributes.add(
            '  final List<$elementClassName> $elementVarName;',
          );

          if (required) {
            _constructorMembers.add(
              '    required this.$elementVarName',
            );
            _assertions.add(
              '    assert($elementVarName.isNotEmpty);',
            );
          } else {
            _constructorMembers.add(
              '    this.$elementVarName = const []',
            );
          }
        } else {
          if (childElement.type == null) {
            _attributes.add(
              '  final $elementVarName; // missing type $elementClassName',
            );
          } else {
            _attributes.add(
              '  final $elementClassName${o ? '?' : ''} $elementVarName;',
            );
          }

          if (required) {
            _constructorMembers.add(
              '    required this.$elementVarName',
            );
          } else {
            _constructorMembers.add(
              '    this.$elementVarName',
            );
          }
        }
      }
    }
  }

  void __prepareMethodToJson() {
    String toJson = '  Map<String, dynamic> toJson() {\n';
    toJson += '    Map<String, dynamic> map = {\n';

    if (_type.bodyType != null) {
      toJson += "      'value': value,\n";
    }
    for (Attribute a in _type.attributes.values) {
      toJson += "      '${a.name}': ${a.name},\n";
    }
    for (Element childElement in _type.elements.values) {
      int minOccurs = childElement.minOccurs;
      int maxOccurs = childElement.maxOccurs;
      String elementClassName = childElement.name;
      String elementVarName = _lcfirst(elementClassName);
      bool o = minOccurs == 0;
      if (maxOccurs == 0) {
        toJson +=
            "      '$elementVarName': $elementVarName.map((e) => e.toJson()).toList(),\n";
      } else {
        toJson +=
            "      '$elementVarName': $elementVarName${o ? '?' : ''}.toJson(),\n";
      }
    }

    toJson += '    };\n';
    toJson +=
        '    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));\n';
    toJson += '    return map;\n';
    toJson += '  }\n';

    _methods.add(toJson);
  }

  void __prepareMethodFromJson() {
    String fromJson =
        '  static ${_element.name}? fromJson(Map<String, dynamic>? json) {\n';
    fromJson += '    if (json == null) { return null; }\n';
    fromJson += '    return ${_element.name} (\n';
    if (_type.bodyType != null) {
      fromJson +=
          '      value: ${_type.bodyType!.fromJsonDef("json['value']")},\n';
    }
    for (Attribute a in _type.attributes.values) {
      bool o = a.optional();
      fromJson +=
          '      ${a.name}: ${a.type.fromJsonDef("json['${a.name}']", optional: o)},\n';
    }
    for (Element childElement in _type.elements.values) {
      String elementClassName = childElement.name;
      String elementVarName = _lcfirst(elementClassName);
      if (childElement.type != null) {
        int minOccurs = childElement.minOccurs;
        int maxOccurs = childElement.maxOccurs;
        bool o = minOccurs == 0;
        if (maxOccurs == 0) {
          fromJson +=
              "      $elementVarName: (json['$elementVarName'] as List? ?? []).map((dynamic d) => $elementClassName.fromJson(d as Map<String, dynamic>?)!).toList(),\n";
        } else {
          fromJson +=
              "      $elementVarName: $elementClassName.fromJson(json['$elementVarName'] as Map<String, dynamic>?)${(o ? '' : '!')},\n";
        }
      } else {
        fromJson += '      $elementVarName: null, // missing type!!,\n';
      }
    }

    fromJson += '    );\n';
    fromJson += '  }\n';

    _methods.add(fromJson);
  }

  void __prepareMethodToXml() {
    String toXml = '  XmlNode toXml() {\n';

    if (_element.parentType.name == XsdParser.schemaType) {
      // special handling of root element --------------
      String schemas = '';
      for (Schema s in _element.referredSchemas()) {
        schemas += '''
          XmlAttribute(
            XmlName('xmlns:${s.identifier}'),
            '${s.namespace}',
          ),
''';
      }
      Schema mainSchema = _element.mainSchema();
      toXml += '''
    return XmlDocument([
      XmlDeclaration([
        XmlAttribute(XmlName('version'), '1.0'),
        XmlAttribute(XmlName('encoding'), 'UTF-8')
      ]),
      XmlElement(
        XmlName(
          '${_element.name}',
          '${_element.refSchemaId}',
        ),
        [
$schemas
          XmlAttribute(
            XmlName('xmlns:xsi'),
            'http://www.w3.org/2001/XMLSchema-instance',
          ),
          XmlAttribute(
            XmlName('xsi:schemaLocation'),
            '${mainSchema.namespace} ${mainSchema.uri}',
          ),
        ]
      ),
    ]);
''';
    } else {
      // other elements --------------------
      toXml += '''
    return XmlElement(
      XmlName(
        '${_element.name}',
        '${_element.refSchemaId}',
      ),
    );
''';
    }

    toXml += '  }\n';

    _methods.add(toXml);
  }

  void __prepareMethodFromXml() {
    String fromXml = '  static ${_element.name}? fromXml(XmlElement? xml) {\n';
    fromXml += '    if (xml == null) { return null; }\n';
    fromXml += '    return ${_element.name} (\n';

    if (_type.bodyType != null) {
      fromXml +=
          '      value: ${_type.bodyType!.fromXmlDef("xml.innerText")},\n';
    }
    for (Attribute a in _type.attributes.values) {
      bool o = a.optional();
      fromXml +=
          '      ${a.name}: ${a.type.fromXmlDef("xml.getAttribute('${a.name}')", optional: o, nullable: true)},\n';
    }
    for (Element childElement in _type.elements.values) {
      String elementClassName = childElement.name;
      String elementVarName = _lcfirst(elementClassName);
      String schemaId = childElement.refSchemaId;
      if (childElement.type != null) {
        int minOccurs = childElement.minOccurs;
        int maxOccurs = childElement.maxOccurs;
        bool o = minOccurs == 0;
        if (maxOccurs == 0) {
          fromXml +=
              "      $elementVarName: xml.findElements('$schemaId:$elementClassName').map((XmlElement e) => $elementClassName.fromXml(e)!).toList(),\n";
        } else {
          fromXml +=
              "      $elementVarName: $elementClassName.fromXml(xml.findElements('$schemaId:$elementClassName').singleOrNull)${(o ? '' : '!')},\n";
        }
      } else {
        fromXml += '      $elementVarName: null, // missing type!!,\n';
      }
    }

    fromXml += '    );\n';
    fromXml += '  }\n';

    _methods.add(fromXml);
  }

  void __prepareMethods() {
    __prepareMethodFromJson();
    __prepareMethodToJson();
    __prepareMethodFromXml();
    __prepareMethodToXml();
  }
}
