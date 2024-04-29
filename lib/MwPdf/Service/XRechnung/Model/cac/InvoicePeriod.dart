import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/StartDate.dart';
import '../cbc/StartTime.dart';
import '../cbc/EndDate.dart';
import '../cbc/EndTime.dart';
import '../cbc/DurationMeasure.dart';
import '../cbc/DescriptionCode.dart';
import '../cbc/Description.dart';

// A class to describe a period of time.
class InvoicePeriod {


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

  InvoicePeriod ({
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

  static InvoicePeriod? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return InvoicePeriod (
      startDate: StartDate.fromJson(json['startDate'] as Map<String, dynamic>?),
      startTime: StartTime.fromJson(json['startTime'] as Map<String, dynamic>?),
      endDate: EndDate.fromJson(json['endDate'] as Map<String, dynamic>?),
      endTime: EndTime.fromJson(json['endTime'] as Map<String, dynamic>?),
      durationMeasure: DurationMeasure.fromJson(json['durationMeasure'] as Map<String, dynamic>?),
      descriptionCode: (json['descriptionCode'] as List? ?? []).map((dynamic d) => DescriptionCode.fromJson(d as Map<String, dynamic>?)!).toList(),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static InvoicePeriod? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return InvoicePeriod (
      startDate: null,
      startTime: null,
      endDate: null,
      endTime: null,
      durationMeasure: null,
      descriptionCode: null,
      description: null,
    );
  }

}

