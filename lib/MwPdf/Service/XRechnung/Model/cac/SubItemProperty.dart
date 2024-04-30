import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Name.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/NameCode.dart';
import '../cbc/TestMethod.dart';
import '../cbc/Value.dart';
import '../cbc/ValueQuantity.dart';
import '../cbc/ValueQualifier.dart';
import '../cbc/ImportanceCode.dart';
import '../cbc/ListValue.dart';
import '../cac/UsabilityPeriod.dart';
import '../cac/ItemPropertyGroup.dart';
import '../cac/RangeDimension.dart';
import '../cac/ItemPropertyRange.dart';
import '../cac/StandardPropertyIdentification.dart';

// A class to describe a specific property of an item.
class SubItemProperty {


  // The name of this item property.
  final Name name;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this property of an item.
  final ID? iD;

  // The name of this item property, expressed as a code.
  final NameCode? nameCode;

  // The method of testing the value of this item property.
  final TestMethod? testMethod;

  // The value of this item property, expressed as text.
  final Value? value;

  // The value of this item property, expressed as a quantity.
  final ValueQuantity? valueQuantity;

  // Text qualifying the value of the property.
  final List<ValueQualifier> valueQualifier;

  // A code signifying the importance of this property in using it to describe a related Item.
  final ImportanceCode? importanceCode;

  // The value expressed as a text in case the property is a value in a list. For example, a colour.
  final List<ListValue> listValue;

  // The period during which this item property is valid.
  final UsabilityPeriod? usabilityPeriod;

  // A description of the property group to which this item property belongs.
  final List<ItemPropertyGroup> itemPropertyGroup;

  // The range of values for the dimensions of this property.
  final RangeDimension? rangeDimension;

  // A range of values for this item property.
  final ItemPropertyRange? itemPropertyRange;

  // Identifying information for this property, assigned according to a standard system.
  final StandardPropertyIdentification? standardPropertyIdentification;

  // A property subsidiary to this property.
  final List<SubItemProperty> subItemProperty;

  SubItemProperty ({
    required this.name,
    this.uBLExtensions,
    this.iD,
    this.nameCode,
    this.testMethod,
    this.value,
    this.valueQuantity,
    this.valueQualifier = const [],
    this.importanceCode,
    this.listValue = const [],
    this.usabilityPeriod,
    this.itemPropertyGroup = const [],
    this.rangeDimension,
    this.itemPropertyRange,
    this.standardPropertyIdentification,
    this.subItemProperty = const [],
  });

  static SubItemProperty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SubItemProperty (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?)!,
      nameCode: NameCode.fromJson(json['nameCode'] as Map<String, dynamic>?),
      testMethod: TestMethod.fromJson(json['testMethod'] as Map<String, dynamic>?),
      value: Value.fromJson(json['value'] as Map<String, dynamic>?),
      valueQuantity: ValueQuantity.fromJson(json['valueQuantity'] as Map<String, dynamic>?),
      valueQualifier: (json['valueQualifier'] as List? ?? []).map((dynamic d) => ValueQualifier.fromJson(d as Map<String, dynamic>?)!).toList(),
      importanceCode: ImportanceCode.fromJson(json['importanceCode'] as Map<String, dynamic>?),
      listValue: (json['listValue'] as List? ?? []).map((dynamic d) => ListValue.fromJson(d as Map<String, dynamic>?)!).toList(),
      usabilityPeriod: UsabilityPeriod.fromJson(json['usabilityPeriod'] as Map<String, dynamic>?),
      itemPropertyGroup: (json['itemPropertyGroup'] as List? ?? []).map((dynamic d) => ItemPropertyGroup.fromJson(d as Map<String, dynamic>?)!).toList(),
      rangeDimension: RangeDimension.fromJson(json['rangeDimension'] as Map<String, dynamic>?),
      itemPropertyRange: ItemPropertyRange.fromJson(json['itemPropertyRange'] as Map<String, dynamic>?),
      standardPropertyIdentification: StandardPropertyIdentification.fromJson(json['standardPropertyIdentification'] as Map<String, dynamic>?),
      subItemProperty: (json['subItemProperty'] as List? ?? []).map((dynamic d) => SubItemProperty.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'name': name.toJson(),
      'nameCode': nameCode?.toJson(),
      'testMethod': testMethod?.toJson(),
      'value': value?.toJson(),
      'valueQuantity': valueQuantity?.toJson(),
      'valueQualifier': valueQualifier.map((e) => e.toJson()).toList(),
      'importanceCode': importanceCode?.toJson(),
      'listValue': listValue.map((e) => e.toJson()).toList(),
      'usabilityPeriod': usabilityPeriod?.toJson(),
      'itemPropertyGroup': itemPropertyGroup.map((e) => e.toJson()).toList(),
      'rangeDimension': rangeDimension?.toJson(),
      'itemPropertyRange': itemPropertyRange?.toJson(),
      'standardPropertyIdentification': standardPropertyIdentification?.toJson(),
      'subItemProperty': subItemProperty.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static SubItemProperty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SubItemProperty (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull)!,
      nameCode: NameCode.fromXml(xml.findElements('cbc:NameCode').singleOrNull),
      testMethod: TestMethod.fromXml(xml.findElements('cbc:TestMethod').singleOrNull),
      value: Value.fromXml(xml.findElements('cbc:Value').singleOrNull),
      valueQuantity: ValueQuantity.fromXml(xml.findElements('cbc:ValueQuantity').singleOrNull),
      valueQualifier: xml.findElements('cbc:ValueQualifier').map((XmlElement e) => ValueQualifier.fromXml(e)!).toList(),
      importanceCode: ImportanceCode.fromXml(xml.findElements('cbc:ImportanceCode').singleOrNull),
      listValue: xml.findElements('cbc:ListValue').map((XmlElement e) => ListValue.fromXml(e)!).toList(),
      usabilityPeriod: UsabilityPeriod.fromXml(xml.findElements('cac:UsabilityPeriod').singleOrNull),
      itemPropertyGroup: xml.findElements('cac:ItemPropertyGroup').map((XmlElement e) => ItemPropertyGroup.fromXml(e)!).toList(),
      rangeDimension: RangeDimension.fromXml(xml.findElements('cac:RangeDimension').singleOrNull),
      itemPropertyRange: ItemPropertyRange.fromXml(xml.findElements('cac:ItemPropertyRange').singleOrNull),
      standardPropertyIdentification: StandardPropertyIdentification.fromXml(xml.findElements('cac:StandardPropertyIdentification').singleOrNull),
      subItemProperty: xml.findElements('cac:SubItemProperty').map((XmlElement e) => SubItemProperty.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      name.toXml(),
      nameCode?.toXml(),
      testMethod?.toXml(),
      value?.toXml(),
      valueQuantity?.toXml(),
      ...valueQualifier.map((ValueQualifier e) => e.toXml()).toList(),
      importanceCode?.toXml(),
      ...listValue.map((ListValue e) => e.toXml()).toList(),
      usabilityPeriod?.toXml(),
      ...itemPropertyGroup.map((ItemPropertyGroup e) => e.toXml()).toList(),
      rangeDimension?.toXml(),
      itemPropertyRange?.toXml(),
      standardPropertyIdentification?.toXml(),
      ...subItemProperty.map((SubItemProperty e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'SubItemProperty',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

