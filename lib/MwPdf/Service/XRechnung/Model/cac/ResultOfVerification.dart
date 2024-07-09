// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
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


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
    this.uBLExtensions,
    this.validatorID,
    this.validationResultCode,
    this.validationDate,
    this.validationTime,
    this.validateProcess,
    this.validateTool,
    this.validateToolVersion,
    this.signatoryParty,
  });

  static ResultOfVerification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ResultOfVerification (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      validatorID: ValidatorID.fromJson(json['validatorID'] as Map<String, dynamic>?),
      validationResultCode: ValidationResultCode.fromJson(json['validationResultCode'] as Map<String, dynamic>?),
      validationDate: ValidationDate.fromJson(json['validationDate'] as Map<String, dynamic>?),
      validationTime: ValidationTime.fromJson(json['validationTime'] as Map<String, dynamic>?),
      validateProcess: ValidateProcess.fromJson(json['validateProcess'] as Map<String, dynamic>?),
      validateTool: ValidateTool.fromJson(json['validateTool'] as Map<String, dynamic>?),
      validateToolVersion: ValidateToolVersion.fromJson(json['validateToolVersion'] as Map<String, dynamic>?),
      signatoryParty: SignatoryParty.fromJson(json['signatoryParty'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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

  static ResultOfVerification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ResultOfVerification (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      validatorID: ValidatorID.fromXml(xml.findElements('cbc:ValidatorID').singleOrNull),
      validationResultCode: ValidationResultCode.fromXml(xml.findElements('cbc:ValidationResultCode').singleOrNull),
      validationDate: ValidationDate.fromXml(xml.findElements('cbc:ValidationDate').singleOrNull),
      validationTime: ValidationTime.fromXml(xml.findElements('cbc:ValidationTime').singleOrNull),
      validateProcess: ValidateProcess.fromXml(xml.findElements('cbc:ValidateProcess').singleOrNull),
      validateTool: ValidateTool.fromXml(xml.findElements('cbc:ValidateTool').singleOrNull),
      validateToolVersion: ValidateToolVersion.fromXml(xml.findElements('cbc:ValidateToolVersion').singleOrNull),
      signatoryParty: SignatoryParty.fromXml(xml.findElements('cac:SignatoryParty').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      validatorID?.toXml(),
      validationResultCode?.toXml(),
      validationDate?.toXml(),
      validationTime?.toXml(),
      validateProcess?.toXml(),
      validateTool?.toXml(),
      validateToolVersion?.toXml(),
      signatoryParty?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ResultOfVerification',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

