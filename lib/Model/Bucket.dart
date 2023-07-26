import 'dart:convert';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Service/Converter.dart';

class Bucket implements JsonSerializable {
  final int id;
  final List<Method> methods;
  final bool exists;

  Bucket(
    this.id, {
    this.exists = true,
    this.methods = const [],
  });

  bool valid() {
    return id != 0 && exists;
  }

  Dict toJson() {
    return {
      'id': id,
      'methods': methods,
    };
  }

  Dict toDatabase() {
    return {
      'id': id,
      'methods': json.encode(methods),
    };
  }

  factory Bucket.fromDatabase(
    Dict row,
  ) {
    List<dynamic> temp = json.decode(row['methods'] as String? ?? '[]') as List<dynamic>;
    List<Method> methods =
        temp.map((dynamic row) => Method.fromDatabase(row as Dict)).toList();

    return Bucket(
      row['id'] as int? ?? 0,
      methods: methods,
    );
  }

  factory Bucket.notFound(
    int id,
  ) {
    return Bucket(
      id,
      exists: false,
      methods: [],
    );
  }

  factory Bucket.fresh(
    int id,
  ) {
    return Bucket(
      id,
      exists: false,
      methods: [],
    );
  }

  void addMethod(
    Method method,
  ) {
    removeMethod(
      method,
    );
    methods.add(
      method,
    );
  }

  void removeMethod(
    Method method,
  ) {
    methods.removeWhere(
      (
        Method m,
      ) =>
          m.name == method.name,
    );
  }

  Method method(
    String methodName,
  ) {
    Method builtIn = Converter.builtInMethods(
      methodName,
    );
    if (builtIn.valid()) {
      return builtIn;
    }

    return methods.firstWhere(
      (Method m) => m.name == methodName,
      orElse: () => Method.notFound(
        methodName,
      ),
    );
  }
}
