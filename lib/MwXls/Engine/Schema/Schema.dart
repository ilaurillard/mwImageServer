import 'dart:io';

import 'package:json_schema/json_schema.dart';
import 'package:json_schema/src/json_schema/models/validation_results.dart';

class Schema {
  final String baseDir;

  late final JsonSchema schema;

  Schema._({
    required this.baseDir,
  });

  static Future<Schema> create({
    required String baseDir,
  }) async {
    Schema schema = Schema._(baseDir: baseDir);
    await schema.load();
    return schema;
  }

  Future<void> load() async {
    String schemaData = await File('$baseDir/mwxls_schema.json').readAsString();
    print('Loaded schema (${schemaData.length})');
    schema = JsonSchema.create(schemaData);
  }

  Results validate(
    String json,
  ) {
    print('Validating data (${json.length})');

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