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

  late final JsonSchema schemaCii;
  late final String schemaDataCii;

  late final JsonSchema schemaUbl;
  late final String schemaDataUbl;

  late final JsonSchema schemaSwissQr;
  late final String schemaDataSwissQr;

  late final JsonSchema schemaEpcQr;
  late final String schemaDataEpcQr;



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
    Console.notice(
      'Loaded schema (${schemaData.length})',
    );

    // --------------

    schemaDataCii = await File(
      '$resDir/schema/invoice_cii_schema.json',
    ).readAsString();
    Console.notice(
      'Loaded schema [CII] (${schemaDataCii.length})',
    );
    Dict cii = json.decode(schemaDataCii) as Dict;
    schemaCii = JsonSchema.create(
      schemaDataCii,
    );

    // --------------

    schemaDataUbl = await File(
      '$resDir/schema/invoice_ubl_schema.json',
    ).readAsString();
    Console.notice(
      'Loaded schema [UBL] (${schemaDataUbl.length})',
    );
    Dict ubl = json.decode(schemaDataUbl) as Dict;
    schemaUbl = JsonSchema.create(
      schemaDataUbl,
    );

    // --------------

    schemaDataSwissQr = await File(
      '$resDir/schema/swiss_qr_bill.json',
    ).readAsString();
    Console.notice(
      'Loaded schema [SWISS-QR] (${schemaDataSwissQr.length})',
    );
    Dict swissQr = json.decode(schemaDataSwissQr) as Dict;
    schemaSwissQr = JsonSchema.create(
      schemaDataSwissQr,
    );

    // --------------

    schemaDataEpcQr = await File(
      '$resDir/schema/epc_qr_bill.json',
    ).readAsString();
    Console.notice(
      'Loaded schema [EPC] (${schemaDataEpcQr.length})',
    );
    Dict epcQr = json.decode(schemaDataEpcQr) as Dict;
    schemaEpcQr = JsonSchema.create(
      schemaDataEpcQr,
    );

    // --------------

    schema = JsonSchema.create(
      schemaData,
      refProvider: RefProvider.sync((String ref) {
        if (ref.contains('invoice_cii_schema.json')) {
          return cii;
        }
        if (ref.contains('invoice_ubl_schema.json')) {
          return ubl;
        }
        if (ref.contains('swiss_qr_bill.json')) {
          return swissQr;
        }
        if (ref.contains('epc_qr_bill.json')) {
          return epcQr;
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
