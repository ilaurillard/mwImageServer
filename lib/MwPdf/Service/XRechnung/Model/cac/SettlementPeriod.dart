import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/StartDate.dart';
import '../cbc/StartTime.dart';
import '../cbc/EndDate.dart';
import '../cbc/EndTime.dart';
import '../cbc/DurationMeasure.dart';
import '../cbc/DescriptionCode.dart';
import '../cbc/Description.dart';

// A class to describe a period of time.
class SettlementPeriod {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  SettlementPeriod ({
    this.uBLExtensions,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.durationMeasure,
    this.descriptionCode = const [],
    this.description = const [],
  });

  static SettlementPeriod? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SettlementPeriod (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      startDate: StartDate.fromJson(json['startDate'] as Map<String, dynamic>?),
      startTime: StartTime.fromJson(json['startTime'] as Map<String, dynamic>?),
      endDate: EndDate.fromJson(json['endDate'] as Map<String, dynamic>?),
      endTime: EndTime.fromJson(json['endTime'] as Map<String, dynamic>?),
      durationMeasure: DurationMeasure.fromJson(json['durationMeasure'] as Map<String, dynamic>?),
      descriptionCode: (json['descriptionCode'] as List? ?? []).map((dynamic d) => DescriptionCode.fromJson(d as Map<String, dynamic>?)!).toList(),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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

  static SettlementPeriod? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SettlementPeriod (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      startDate: StartDate.fromXml(xml.findElements('cbc:StartDate').singleOrNull),
      startTime: StartTime.fromXml(xml.findElements('cbc:StartTime').singleOrNull),
      endDate: EndDate.fromXml(xml.findElements('cbc:EndDate').singleOrNull),
      endTime: EndTime.fromXml(xml.findElements('cbc:EndTime').singleOrNull),
      durationMeasure: DurationMeasure.fromXml(xml.findElements('cbc:DurationMeasure').singleOrNull),
      descriptionCode: xml.findElements('cbc:DescriptionCode').map((XmlElement e) => DescriptionCode.fromXml(e)!).toList(),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      startDate?.toXml(),
      startTime?.toXml(),
      endDate?.toXml(),
      endTime?.toXml(),
      durationMeasure?.toXml(),
      ...descriptionCode.map((DescriptionCode e) => e.toXml()).toList(),
      ...description.map((Description e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'SettlementPeriod',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

