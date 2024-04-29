import 'XsdType.dart';

class InternalType extends XsdType {
  InternalType(
    String name,
  ) {
    schemaId = 'xsd';
    super.name = name;
  }

  String scalarType()
  {
    switch(name) {
      case 'decimal':
        return 'double';
    }
    return 'String';
  }

  static InternalType from(
    String name,
  ) {
    switch(name) {
      case 'xsd:decimal':
        break;
      case 'xsd:normalizedString':
        break;
      case 'xsd:string':
        break;
      case 'xsd:base64Binary':
        break;
      case 'xsd:anyURI':
        break;
      case 'xsd:language':
        break;
      case 'xsd:time':
        break;
      case 'xsd:date':
        break;
      case 'xsd:dateTime':
        break;
      case 'xsd:boolean':
        break;
      default:
        throw Exception('unsupported');
    }

    return InternalType(name.substring(name.indexOf(':') + 1));
  }
}
