import 'dart:io';

import 'package:json_schema/json_schema.dart';
// ignore: implementation_imports
import 'package:json_schema/src/json_schema/models/validation_results.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';

class Schema {
  final String resDir;
  late final JsonSchema schema;
  late final String schemaData;
  static Schema? instance;

  Schema._({
    required this.resDir,
  });

  static Future<Schema> create({
    required String resDir,
  }) async {
    if (instance == null) {
      instance = Schema._(
        resDir: resDir,
      );
      await instance!.load();
    }
    return instance!;
  }

  Future<void> load() async {
    schemaData = await File(
      '$resDir/schema/mwxls_schema.json',
    ).readAsString();
    Console.notice('Loaded schema (${schemaData.length})');
    schema = JsonSchema.create(schemaData);
  }

  Results validate(
    String json,
  ) {
    Console.notice('Validating data (${json.length})');

    ValidationResults results = schema.validate(
      json,
      parseJson: true,
      validateFormats: true,
    );

    return Results(
      valid: results.errors.isEmpty,
      errors: results.errors.map((e) => e.toString()).toList(),
      warnings: results.warnings.map((e) => e.toString()).toList(),
    );
  }
}

class Results {
  bool valid;
  List<String> errors;
  List<String> warnings;

  Results({
    required this.valid,
    required this.errors,
    required this.warnings,
  });
}
