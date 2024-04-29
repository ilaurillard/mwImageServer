import '../cac/ValidatorID.dart';
import '../cac/ValidationResultCode.dart';
import '../cac/ValidationDate.dart';
import '../cac/ValidationTime.dart';
import '../cac/ValidateProcess.dart';
import '../cac/ValidateTool.dart';
import '../cac/ValidateToolVersion.dart';
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
}

