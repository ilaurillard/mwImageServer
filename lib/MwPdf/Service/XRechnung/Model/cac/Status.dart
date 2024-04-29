import '../cac/ConditionCode.dart';
import '../cac/ReferenceDate.dart';
import '../cac/ReferenceTime.dart';
import '../cac/Description.dart';
import '../cac/StatusReasonCode.dart';
import '../cac/StatusReason.dart';
import '../cac/SequenceID.dart';
import '../cac/Text.dart';
import '../cac/IndicationIndicator.dart';
import '../cac/Percent.dart';
import '../cac/ReliabilityPercent.dart';
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
}

