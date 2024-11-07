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
  late final String data;

  // externals (for downloads)
  late final String dataCii;
  late final String dataUbl;
  late final String dataSwissQr;
  late final String dataEpcQr;
  late final String dataSoccerTactic;

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

    data = await File(
      '$resDir/schema/mwpdf_schema.json',
    ).readAsString();
    Console.notice(
      'Loaded main schema (${data.length})',
    );

    // --------------

    dataCii = await File(
      '$resDir/schema/invoice_cii_schema.json',
    ).readAsString();
    Console.notice(
      'Loaded schema [CII] (${dataCii.length})',
    );
    JsonSchema.create(
      dataCii,
    );
    Dict cii = json.decode(dataCii) as Dict;

    // --------------

    dataUbl = await File(
      '$resDir/schema/invoice_ubl_schema.json',
    ).readAsString();
    Console.notice(
      'Loaded schema [UBL] (${dataUbl.length})',
    );
    JsonSchema.create(
      dataUbl,
    );
    Dict ubl = json.decode(dataUbl) as Dict;

    // --------------

    dataSwissQr = await File(
      '$resDir/schema/swiss_qr_bill.json',
    ).readAsString();
    Console.notice(
      'Loaded schema [SWISS-QR] (${dataSwissQr.length})',
    );
    JsonSchema.create(
      dataSwissQr,
    );
    Dict swissQr = json.decode(dataSwissQr) as Dict;

    // --------------

    dataEpcQr = await File(
      '$resDir/schema/epc_qr_bill.json',
    ).readAsString();
    Console.notice(
      'Loaded schema [EPC] (${dataEpcQr.length})',
    );
    JsonSchema.create(
      dataEpcQr,
    );
    Dict epcQr = json.decode(dataEpcQr) as Dict;

    // --------------

    dataSoccerTactic = await File(
      '$resDir/schema/soccer_tactic.json',
    ).readAsString();
    Console.notice(
      'Loaded schema [SoccerTactic] (${dataSoccerTactic.length})',
    );
    JsonSchema.create(
      dataSoccerTactic,
    );
    Dict soccerTactic = json.decode(dataSoccerTactic) as Dict;

    // --------------

    schema = JsonSchema.create(
      data,
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
        if (ref.contains('soccer_tactic.json')) {
          return soccerTactic;
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
