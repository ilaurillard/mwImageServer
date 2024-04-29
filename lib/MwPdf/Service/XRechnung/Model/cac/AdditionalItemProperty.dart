import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/Name.dart';
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

// A class to describe a specific property of an item.
class AdditionalItemProperty {


  // The name of this item property.
  final Name name;

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

  AdditionalItemProperty ({
    required this.name,
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
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  AdditionalItemProperty fromJson(Map<String, dynamic> json) {
    return AdditionalItemProperty (
    );
  }

}

