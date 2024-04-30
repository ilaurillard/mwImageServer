// ignore_for_file: implementation_imports

import 'dart:convert';
import 'dart:io';

import 'package:json_schema/json_schema.dart';
import 'package:json_schema/src/json_schema/models/validation_results.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';

class Schema {
  final String resDir;

  late final JsonSchema schema;
  late final String schemaData;

  late final JsonSchema schemaFacturx;
  late final String schemaDataFacturx;

  late final JsonSchema schemaXRechnung;
  late final String schemaDataXRechnung;

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
      '$resDir/schema/mwpdf_schema.json',
    ).readAsString();
    Console.notice('Loaded schema (${schemaData.length})');

    // --------------

    schemaDataFacturx = await File(
      '$resDir/schema/facturx_schema.json',
    ).readAsString();
    Console.notice('Loaded schema [Factur-X] (${schemaData.length})');
    Dict facturx = json.decode(schemaDataFacturx) as Dict;
    schemaFacturx = JsonSchema.create(
      schemaDataFacturx,
    );

    // --------------

    schemaDataXRechnung = await File(
      '$resDir/schema/xrechnung_schema.json',
    ).readAsString();
    Console.notice('Loaded schema [XRechnung] (${schemaData.length})');
    Dict xrechnung = json.decode(schemaDataXRechnung) as Dict;
    schemaXRechnung = JsonSchema.create(
      schemaDataXRechnung,
    );

    // --------------

    schema = JsonSchema.create(
      schemaData,
      refProvider: RefProvider.sync((String ref) {
        if (ref.contains('facturx_schema.json')) {
          return facturx;
        }
        if (ref.contains('xrechnung_schema.json')) {
          return xrechnung;
        }
        return {};
      }),
    );
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
