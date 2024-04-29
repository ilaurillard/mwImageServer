import '../cac/BatchQuantity.dart';
import '../cac/ConsumerUnitQuantity.dart';
import '../cac/HazardousRiskIndicator.dart';

// A class to describe a delivery unit.
class MinimumDeliveryUnit {


  // The quantity of ordered Items that constitutes a batch for delivery purposes.
  final BatchQuantity batchQuantity;

  // The quantity of units in the Delivery Unit expressed in the units used by the consumer.
  final ConsumerUnitQuantity? consumerUnitQuantity;

  // An indication that the transported goods are subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  MinimumDeliveryUnit ({
    required this.batchQuantity,
    this.consumerUnitQuantity,
    this.hazardousRiskIndicator,
  });
}

