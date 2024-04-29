import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/ImportanceCode.dart';

// A class to describe a property group or classification.
class ItemPropertyGroup {


  // An identifier for this group of item properties.
  final ID iD;

  // The name of this item property group.
  final Name? name;

  // A code signifying the importance of this property group in using it to describe a required Item.
  final ImportanceCode? importanceCode;

  ItemPropertyGroup ({
    required this.iD,
    this.name,
    this.importanceCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD.toJson(),
     'name': name?.toJson(),
     'importanceCode': importanceCode?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ItemPropertyGroup fromJson(Map<String, dynamic> json) {
    return ItemPropertyGroup (
    );
  }

}

