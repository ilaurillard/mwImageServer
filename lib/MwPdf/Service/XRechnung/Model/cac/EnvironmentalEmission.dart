import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/EnvironmentalEmissionTypeCode.dart';
import '../cbc/ValueMeasure.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Description.dart';
import '../cac/EmissionCalculationMethod.dart';

// A class to describe an environmental emission.
class EnvironmentalEmission {


  // A code specifying the type of environmental emission.
  final EnvironmentalEmissionTypeCode environmentalEmissionTypeCode;

  // A value measurement for the environmental emission.
  final ValueMeasure valueMeasure;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // Text describing this environmental emission.
  final List<Description> description;

  // A method used to calculate the amount of this emission.
  final List<EmissionCalculationMethod> emissionCalculationMethod;

  EnvironmentalEmission ({
    required this.environmentalEmissionTypeCode,
    required this.valueMeasure,
    this.uBLExtensions,
    this.description = const [],
    this.emissionCalculationMethod = const [],
  });

  static EnvironmentalEmission? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EnvironmentalEmission (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      environmentalEmissionTypeCode: EnvironmentalEmissionTypeCode.fromJson(json['environmentalEmissionTypeCode'] as Map<String, dynamic>?)!,
      valueMeasure: ValueMeasure.fromJson(json['valueMeasure'] as Map<String, dynamic>?)!,
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      emissionCalculationMethod: (json['emissionCalculationMethod'] as List? ?? []).map((dynamic d) => EmissionCalculationMethod.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'environmentalEmissionTypeCode': environmentalEmissionTypeCode.toJson(),
      'valueMeasure': valueMeasure.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'emissionCalculationMethod': emissionCalculationMethod.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EnvironmentalEmission? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return EnvironmentalEmission (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      environmentalEmissionTypeCode: EnvironmentalEmissionTypeCode.fromXml(xml.findElements('cbc:EnvironmentalEmissionTypeCode').singleOrNull)!,
      valueMeasure: ValueMeasure.fromXml(xml.findElements('cbc:ValueMeasure').singleOrNull)!,
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      emissionCalculationMethod: xml.findElements('cac:EmissionCalculationMethod').map((XmlElement e) => EmissionCalculationMethod.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      environmentalEmissionTypeCode.toXml(),
      valueMeasure.toXml(),
      ...description.map((Description e) => e.toXml()).toList(),
      ...emissionCalculationMethod.map((EmissionCalculationMethod e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'EnvironmentalEmission',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

