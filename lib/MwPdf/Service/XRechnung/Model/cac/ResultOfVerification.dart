import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ValidatorID.dart';
import '../cbc/ValidationResultCode.dart';
import '../cbc/ValidationDate.dart';
import '../cbc/ValidationTime.dart';
import '../cbc/ValidateProcess.dart';
import '../cbc/ValidateTool.dart';
import '../cbc/ValidateToolVersion.dart';
import '../cac/SignatoryParty.dart';

// A class to describe the result of an attempt to verify a signature.
class ResultOfVerification {


  // An identifier for the organization, person, service, or server that verified the signature.
  final ValidatorID? validatorID;

  // A code signifying the result of the verification.
  final ValidationResultCode? validationResultCode;

  // The date upon which verification took place.
  final ValidationDate? validationDate;

  // The time at which verification took place.
  final ValidationTime? validationTime;

  // The verification process.
  final ValidateProcess? validateProcess;

  // The tool used to verify the signature.
  final ValidateTool? validateTool;

  // The version of the tool used to verify the signature.
  final ValidateToolVersion? validateToolVersion;

  // The signing party.
  final SignatoryParty? signatoryParty;

  ResultOfVerification ({
    this.validatorID,
    this.validationResultCode,
    this.validationDate,
    this.validationTime,
    this.validateProcess,
    this.validateTool,
    this.validateToolVersion,
    this.signatoryParty,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'validatorID': validatorID?.toJson(),
     'validationResultCode': validationResultCode?.toJson(),
     'validationDate': validationDate?.toJson(),
     'validationTime': validationTime?.toJson(),
     'validateProcess': validateProcess?.toJson(),
     'validateTool': validateTool?.toJson(),
     'validateToolVersion': validateToolVersion?.toJson(),
     'signatoryParty': signatoryParty?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ResultOfVerification fromJson(Map<String, dynamic> json) {
    return ResultOfVerification (
    );
  }

}

