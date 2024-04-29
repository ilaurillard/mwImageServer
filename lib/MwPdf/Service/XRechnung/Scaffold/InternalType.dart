import 'XsdType.dart';

class InternalType extends XsdType {
  InternalType(
    String name,
  ) {
    schemaId = 'xsd';
    super.name = name;
  }

  String scalarType() {
    switch (name) {
      case 'decimal':
        return 'double';
      case 'boolean':
        return 'bool';
      case 'date':
        return 'XsdDate';
      case 'time':
        return 'XsdTime';
    }
    return 'String';
  }

  String fromDef(
    String source, {
    bool optional = false,
  }) {
    switch (name) {
      case 'decimal':
        return 'double.tryParse($source.toString())${optional ? '' : " ?? 0"}';
      case 'boolean':
        return '$source as bool?${optional ? '' : " ?? false"}';
      case 'date':
        return 'XsdDate.fromJson($source as String?)${optional ? '' : '!'}';
      case 'time':
        return 'XsdTime.fromJson($source as String?)${optional ? '' : '!'}';
    }
    return '$source as String?${optional ? '' : " ?? ''"}';
  }

  static InternalType from(
    String name,
  ) {
    switch (name) {
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
