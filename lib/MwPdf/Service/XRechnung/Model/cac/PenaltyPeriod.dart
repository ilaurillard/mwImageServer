import 'dart:convert';
import '../cbc/StartDate.dart';
import '../cbc/StartTime.dart';
import '../cbc/EndDate.dart';
import '../cbc/EndTime.dart';
import '../cbc/DurationMeasure.dart';
import '../cbc/DescriptionCode.dart';
import '../cbc/Description.dart';

// A class to describe a period of time.
class PenaltyPeriod {


  // The date on which this period begins.
  final StartDate? startDate;

  // The time at which this period begins.
  final StartTime? startTime;

  // The date on which this period ends.
  final EndDate? endDate;

  // The time at which this period ends.
  final EndTime? endTime;

  // The duration of this period, expressed as an ISO 8601 code.
  final DurationMeasure? durationMeasure;

  // A description of this period, expressed as a code.
  final List<DescriptionCode> descriptionCode;

  // A description of this period, expressed as text.
  final List<Description> description;

  PenaltyPeriod ({
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.durationMeasure,
    this.descriptionCode = const [],
    this.description = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'startDate': startDate?.toJson(),
     'startTime': startTime?.toJson(),
     'endDate': endDate?.toJson(),
     'endTime': endTime?.toJson(),
     'durationMeasure': durationMeasure?.toJson(),
     'descriptionCode': descriptionCode.map((e) => e.toJson()).toList(),
     'description': description.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

