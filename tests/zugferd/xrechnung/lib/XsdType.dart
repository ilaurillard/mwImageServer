import 'Attribute.dart';
import 'InternalType.dart';

class XsdType {
  String schemaId = '';
  String name = '';
  XsdType? parent;

  Map<String, Attribute> attributes = {};

  String get fullname {
    return '$schemaId.$name';
  }

  InternalType? internalType() {
    if (parent != null) {
      return parent!.internalType();
    }
    else if (this is InternalType) {
      return this as InternalType;
    }
    else {
      throw Exception('?');
    }
  }

  // XsdType copy() {
  //   return this;
  // }
}