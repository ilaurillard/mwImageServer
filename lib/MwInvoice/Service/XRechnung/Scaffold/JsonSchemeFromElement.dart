import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Scaffold/Attribute.dart';

import 'ComplexType.dart';
import 'Element.dart';

class JsonSchemeFromElement {
  final Element _element;
  late final ComplexType _type;

  Dict res = {
    'additionalProperties': false,
    'properties': <String, Dict>{},
    'required': <String>[],
    'type': 'object',
    'description': '',
  };

  JsonSchemeFromElement(this._element) {
    _type = _element.type!;
  }

  Dict render() {
    if (_element.type != null && _element.type!.docString.isNotEmpty) {
      res['description'] = _element.type!.docString;
    }

    for (bool required in [true, false]) {
      _prepareValue(required);
      _prepareAttributes(required);
      _prepareChildren(required);
    }
    return res;
  }

  void _prepareValue(bool required) {
    // CDATA/VALUE ATTRIBUTE
    if (required) {
      // BODY todo
      if (_type.bodyType != null) {
        String s = _type.bodyType!.scalarJsonSchemaType();
        if (s.startsWith('Xsd')) {
          res['properties']['value'] = <String, dynamic>{
            '\$ref': '#/definitions/$s',
          };
        } else {
          res['properties']['value'] = <String, dynamic>{
            'type': s,
          };
        }
        if (s == 'string') {
          res['properties']['value']['minLength'] = 1;
        }
        if (_type.bodyType!.docString.isNotEmpty) {
          res['properties']['value']['description'] = _type.bodyType!.docString;
        }
        res['required'].add('value');
      }

    }
  }

  void _prepareAttributes(bool required) {
    // ATTRIBUTES (only internal types / scalars)
      for (Attribute a in _type.attributes.values) {
        bool o = a.optional();
        if ((required && !o) || (!required && o)) {

          String s = a.type.scalarJsonSchemaType();
          if (s.startsWith('Xsd')) {
            res['properties'][a.name] = <String, dynamic>{
              '\$ref': '#/definitions/$s',
            };
          } else {
            res['properties'][a.name] = <String, dynamic>{
              'type': s,
            };
          }

          if (required) {
            // TODO assert not empty??
            if (s == 'string' && !o) {
              res['properties'][a.name]['minLength'] = 1;
            }
          }

          if (a.docString.isNotEmpty) {
            res['properties'][a.name]['description'] = a.docString;
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

        String ns = childElement.refSchemaId;
        String elementClassName = childElement.name;
        String elementVarName = _lcfirst(elementClassName);
        if (childElement.type == null) {
          print(
            '!! WARNING, element ${childElement.fullname} has no type',
          );
        }

        if (maxOccurs == 0) {
          // unbounded -- means: list
          if (childElement.type == null) {
            throw Exception('Cannot handle');
          }
          Dict props = {
            'type': 'array',
            'items': {'\$ref': '#/definitions/$ns/$elementClassName'},
          };
          if (required) {
            res['required'].add(elementVarName);
            props['minItems'] = 1;
          }
          res['properties'][elementVarName] = props;
        } else {
          if (required) {
            res['required'].add(elementVarName);
          }
          res['properties'][elementVarName] = {
            '\$ref': '#/definitions/$ns/$elementClassName'
          };
        }

        if (childElement.docString.isNotEmpty) {
          res['properties'][elementVarName]['description'] =
              childElement.docString;
        }
      }
    }
  }

  String _lcfirst(String input) {
    if (input.isEmpty) return input;
    return input[0].toLowerCase() + input.substring(1);
  }
}
