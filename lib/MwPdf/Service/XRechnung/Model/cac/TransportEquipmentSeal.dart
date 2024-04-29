import '../cac/ID.dart';
import '../cac/SealIssuerTypeCode.dart';
import '../cac/Condition.dart';
import '../cac/SealStatusCode.dart';
import '../cac/SealingPartyType.dart';

// A class to describe a device (a transport equipment seal) for securing the doors of a shipping container.
class TransportEquipmentSeal {


  // An identifier for this transport equipment seal.
  final ID iD;

  // A code signifying the type of party that issues and is responsible for this transport equipment seal.
  final SealIssuerTypeCode? sealIssuerTypeCode;

  // The condition of this transport equipment seal.
  final Condition? condition;

  // A code signifying the condition of this transport equipment seal.
  final SealStatusCode? sealStatusCode;

  // The role of the sealing party.
  final SealingPartyType? sealingPartyType;

  TransportEquipmentSeal ({
    required this.iD,
    this.sealIssuerTypeCode,
    this.condition,
    this.sealStatusCode,
    this.sealingPartyType,
  });
}

