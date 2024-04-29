import 'dart:convert';
import '../cbc/ConditionCode.dart';
import '../cbc/ReferenceDate.dart';
import '../cbc/ReferenceTime.dart';
import '../cbc/Description.dart';
import '../cbc/StatusReasonCode.dart';
import '../cbc/StatusReason.dart';
import '../cbc/SequenceID.dart';
import '../cbc/Text.dart';
import '../cbc/IndicationIndicator.dart';
import '../cbc/Percent.dart';
import '../cbc/ReliabilityPercent.dart';
import '../cac/Condition.dart';

// A class to describe the condition or position of an object.
class Status {


  // Specifies the status condition of the related object.
  final ConditionCode? conditionCode;

  // The reference date for this status.
  final ReferenceDate? referenceDate;

  // The reference time for this status.
  final ReferenceTime? referenceTime;

  // Text describing this status.
  final List<Description> description;

  // The reason for this status condition or position, expressed as a code.
  final StatusReasonCode? statusReasonCode;

  // The reason for this status condition or position, expressed as text.
  final List<StatusReason> statusReason;

  // A sequence identifier for this status.
  final SequenceID? sequenceID;

  // Provides any textual information related to this status.
  final List<Text> text;

  // Specifies an indicator relevant to a specific status.
  final IndicationIndicator? indicationIndicator;

  // A percentage meaningful in the context of this status.
  final Percent? percent;

  // The reliability of this status, expressed as a percentage.
  final ReliabilityPercent? reliabilityPercent;

  // Measurements that quantify the condition of the objects covered by the status.
  final List<Condition> condition;

  Status ({
    this.conditionCode,
    this.referenceDate,
    this.referenceTime,
    this.description = const [],
    this.statusReasonCode,
    this.statusReason = const [],
    this.sequenceID,
    this.text = const [],
    this.indicationIndicator,
    this.percent,
    this.reliabilityPercent,
    this.condition = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'conditionCode': conditionCode?.toJson(),
     'referenceDate': referenceDate?.toJson(),
     'referenceTime': referenceTime?.toJson(),
     'description': description.map((e) => e.toJson()).toList(),
     'statusReasonCode': statusReasonCode?.toJson(),
     'statusReason': statusReason.map((e) => e.toJson()).toList(),
     'sequenceID': sequenceID?.toJson(),
     'text': text.map((e) => e.toJson()).toList(),
     'indicationIndicator': indicationIndicator?.toJson(),
     'percent': percent?.toJson(),
     'reliabilityPercent': reliabilityPercent?.toJson(),
     'condition': condition.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

