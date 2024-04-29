import '../cac/AttributeID.dart';
import '../cac/PositionCode.dart';
import '../cac/DescriptionCode.dart';
import '../cac/Description.dart';

// A class to describe a physical attribute.
class PhysicalAttribute {


  // An identifier for this physical attribute.
  final AttributeID attributeID;

  // A code signifying the position of this physical attribute.
  final PositionCode? positionCode;

  // A description of the physical attribute, expressed as a code.
  final DescriptionCode? descriptionCode;

  // A description of the physical attribute, expressed as text.
  final List<Description> description;

  PhysicalAttribute ({
    required this.attributeID,
    this.positionCode,
    this.descriptionCode,
    this.description = const [],
  });
}

