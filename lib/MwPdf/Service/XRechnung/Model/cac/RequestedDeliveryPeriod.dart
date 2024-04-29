import '../cac/StartDate.dart';
import '../cac/StartTime.dart';
import '../cac/EndDate.dart';
import '../cac/EndTime.dart';
import '../cac/DurationMeasure.dart';
import '../cac/DescriptionCode.dart';
import '../cac/Description.dart';

// A class to describe a period of time.
class RequestedDeliveryPeriod {


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

  RequestedDeliveryPeriod ({
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.durationMeasure,
    this.descriptionCode = const [],
    this.description = const [],
  });
}

