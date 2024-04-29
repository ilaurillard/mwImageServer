import '../cac/ID.dart';
import '../cac/Name.dart';
import '../cac/ImportanceCode.dart';

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
}

