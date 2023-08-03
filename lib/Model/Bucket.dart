import 'dart:convert';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:mwcdn/Model/Method.dart';
import 'package:mwcdn/Service/Work/Images/Converter.dart';

class Bucket implements JsonSerializable {
  final int id;
  String name;
  final List<Method> methods;
  final bool exists;
  final DateTime? created;

  Bucket(
    this.id, {
    this.name = '',
    this.exists = true,
    this.methods = const [],
    this.created,
  });

  bool valid() {
    return id != 0 && exists;
  }

  @override
  Dict toJson() {
    return {
      'id': id,
      'name': name,
      'methods': methods,
      'created': created?.millisecondsSinceEpoch,
    };
  }

  Dict toDatabase() {
    return {
      'id': id,
      'name': name,
      'methods': json.encode(methods),
    };
  }

  Dict toDatabaseUpdate() {
    return {
      'name': name,
      'methods': json.encode(methods),
    };
  }

  factory Bucket.fromDatabase(
    Dict row,
  ) {
    List<dynamic> temp =
        json.decode(row['methods'] as String? ?? '[]') as List<dynamic>;
    List<Method> methods =
        temp.map((dynamic row) => Method.fromDatabase(row as Dict)).toList();

    return Bucket(
      row['id'] as int? ?? 0,
      name: row['name'] as String? ?? '',
      methods: methods,
      created: DateTime.parse(row['created'] as String? ?? ''),
    );
  }

  factory Bucket.notFound(
    int id,
  ) {
    return Bucket(
      id,
      name: '?',
      exists: false,
      methods: [],
    );
  }

  factory Bucket.fresh(
    int id,
    String name,
  ) {
    return Bucket(
      id,
      name: name,
      exists: false,
      methods: [],
      created: DateTime.now(),
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

  @override
  String toString() {
    return 'Bucket#$id ($name)';
  }
}
