import '../cac/MinimumValue.dart';
import '../cac/MaximumValue.dart';

// A class to describe a range of values for an item property.
class ItemPropertyRange {


  // The minimum value in this range of values.
  final MinimumValue? minimumValue;

  // The maximum value in this range of values.
  final MaximumValue? maximumValue;

  ItemPropertyRange ({
    this.minimumValue,
    this.maximumValue,
  });
}

