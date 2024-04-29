import '../cac/ID.dart';
import '../cac/Quantity.dart';
import '../cac/TransportEquipment.dart';

// A class defining how goods items are split across transport equipment.
class GoodsItemContainer {


  // An identifier for this goods item container.
  final ID iD;

  // The number of goods items loaded into or onto one piece of transport equipment as a total consignment or part of a consignment.
  final Quantity? quantity;

  // A piece of transport equipment used to contain a single goods item.
  final List<TransportEquipment> transportEquipment;

  GoodsItemContainer ({
    required this.iD,
    this.quantity,
    this.transportEquipment = const [],
  });
}

