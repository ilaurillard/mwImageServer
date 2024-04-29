import '../cac/ID.dart';
import '../cac/SpecialTerms.dart';
import '../cac/LossRiskResponsibilityCode.dart';
import '../cac/LossRisk.dart';
import '../cac/Amount.dart';
import '../cac/DeliveryLocation.dart';
import '../cac/AllowanceCharge.dart';

// A class for describing the terms and conditions applying to the delivery of goods.
class DeliveryTerms {


  // An identifier for this description of delivery terms.
  final ID? iD;

  // A description of any terms or conditions relating to the delivery items.
  final List<SpecialTerms> specialTerms;

  // A code that identifies one of various responsibilities for loss risk in the execution of the delivery.
  final LossRiskResponsibilityCode? lossRiskResponsibilityCode;

  // A description of responsibility for risk of loss in execution of the delivery, expressed as text.
  final List<LossRisk> lossRisk;

  // The monetary amount covered by these delivery terms.
  final Amount? amount;

  // The location for the contracted delivery.
  final DeliveryLocation? deliveryLocation;

  // An allowance or charge covered by these delivery terms.
  final AllowanceCharge? allowanceCharge;

  DeliveryTerms ({
    this.iD,
    this.specialTerms = const [],
    this.lossRiskResponsibilityCode,
    this.lossRisk = const [],
    this.amount,
    this.deliveryLocation,
    this.allowanceCharge,
  });
}

