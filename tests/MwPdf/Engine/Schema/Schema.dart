import 'dart:io';

import 'package:json_schema/json_schema.dart';
import 'package:json_schema/src/json_schema/models/validation_results.dart';


class Schema {
  final String basedir;

  late final JsonSchema schema;

  Schema._({
    required this.basedir,
  });

  static Future<Schema> create({
    required String basedir,
  }) async {
    Schema schema = Schema._(basedir: basedir);
    await schema.load();
    return schema;
  }

  Future<void> load() async {
    String schemaData =
        await File('${basedir}mwpdf_schema.json').readAsString();
    print('Loaded schema (${schemaData.length})');
    schema = JsonSchema.create(schemaData);
  }

  bool validate(
    String json,
  ) {
    print('Validating data (${json.length})');

    ValidationResults results = schema.validate(
      json,
      parseJson: true,
      validateFormats: true,
    );

    if (results.errors.isNotEmpty) {
      print('Oh no, document does not validate!');
      print('Errors: ');
      print(results.errors.map((e) => print("$e\n")));
    }
    else {
      print('Fine! Document is valid.');
    }

    if (results.warnings.isNotEmpty) {
      print('Warnings: ');
      print(results.warnings.map((e) => print("$e\n")));
    }

    return results.errors.isEmpty;
  }
}
