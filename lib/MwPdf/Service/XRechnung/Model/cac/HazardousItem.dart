import '../cac/ID.dart';
import '../cac/PlacardNotation.dart';
import '../cac/PlacardEndorsement.dart';
import '../cac/AdditionalInformation.dart';
import '../cac/UNDGCode.dart';
import '../cac/EmergencyProceduresCode.dart';
import '../cac/MedicalFirstAidGuideCode.dart';
import '../cac/TechnicalName.dart';
import '../cac/CategoryName.dart';
import '../cac/HazardousCategoryCode.dart';
import '../cac/UpperOrangeHazardPlacardID.dart';
import '../cac/LowerOrangeHazardPlacardID.dart';
import '../cac/MarkingID.dart';
import '../cac/HazardClassID.dart';
import '../cac/NetWeightMeasure.dart';
import '../cac/NetVolumeMeasure.dart';
import '../cac/Quantity.dart';
import '../cac/ContactParty.dart';
import '../cac/SecondaryHazard.dart';
import '../cac/HazardousGoodsTransit.dart';
import '../cac/EmergencyTemperature.dart';
import '../cac/FlashpointTemperature.dart';
import '../cac/AdditionalTemperature.dart';

// A class to describe a hazardous item.
class HazardousItem {


  // An identifier for this hazardous item.
  final ID? iD;

  // Text of the placard notation corresponding to the hazard class of this hazardous item. Can also be the hazard identification number of the orange placard (upper part) required on the means of transport.
  final PlacardNotation? placardNotation;

  // Text of the placard endorsement that is to be shown on the shipping papers for this hazardous item. Can also be used for the number of the orange placard (lower part) required on the means of transport.
  final PlacardEndorsement? placardEndorsement;

  // Text providing further information about the hazardous substance.
  final List<AdditionalInformation> additionalInformation;

  // The UN code for this kind of hazardous item.
  final UNDGCode? uNDGCode;

  // A code signifying the emergency procedures for this hazardous item.
  final EmergencyProceduresCode? emergencyProceduresCode;

  // A code signifying a medical first aid guide appropriate to this hazardous item.
  final MedicalFirstAidGuideCode? medicalFirstAidGuideCode;

  // The full technical name of a specific hazardous substance contained in this goods item.
  final TechnicalName? technicalName;

  // The name of the category of hazard that applies to the Item.
  final CategoryName? categoryName;

  // A code signifying a kind of hazard for a material.
  final HazardousCategoryCode? hazardousCategoryCode;

  // The number for the upper part of the orange hazard placard required on the means of transport.
  final UpperOrangeHazardPlacardID? upperOrangeHazardPlacardID;

  // The number for the lower part of the orange hazard placard required on the means of transport.
  final LowerOrangeHazardPlacardID? lowerOrangeHazardPlacardID;

  // An identifier to the marking of the Hazardous Item
  final MarkingID? markingID;

  // An identifier for the hazard class applicable to this hazardous item as defined by the relevant regulation authority (e.g., the IMDG Class Number of the SOLAS Convention of IMO and the ADR/RID Class Number for the road/rail environment).
  final HazardClassID? hazardClassID;

  // The net weight of this hazardous item, excluding packaging.
  final NetWeightMeasure? netWeightMeasure;

  // The volume of this hazardous item, excluding packaging and transport equipment.
  final NetVolumeMeasure? netVolumeMeasure;

  // The quantity of goods items in this hazardous item that are hazardous.
  final Quantity? quantity;

  // The individual, group, or body to be contacted in case of a hazardous incident associated with this item.
  final ContactParty? contactParty;

  // A secondary hazard associated with this hazardous item.
  final List<SecondaryHazard> secondaryHazard;

  // Information related to the transit of this kind of hazardous goods.
  final List<HazardousGoodsTransit> hazardousGoodsTransit;

  // The threshold temperature at which emergency procedures apply in the handling of temperature-controlled goods.
  final EmergencyTemperature? emergencyTemperature;

  // The flashpoint temperature of this hazardous item; i.e., the lowest temperature at which vapors above a volatile combustible substance ignite in air when exposed to flame.
  final FlashpointTemperature? flashpointTemperature;

  // Another temperature relevant to the handling of this hazardous item.
  final List<AdditionalTemperature> additionalTemperature;

  HazardousItem ({
    this.iD,
    this.placardNotation,
    this.placardEndorsement,
    this.additionalInformation = const [],
    this.uNDGCode,
    this.emergencyProceduresCode,
    this.medicalFirstAidGuideCode,
    this.technicalName,
    this.categoryName,
    this.hazardousCategoryCode,
    this.upperOrangeHazardPlacardID,
    this.lowerOrangeHazardPlacardID,
    this.markingID,
    this.hazardClassID,
    this.netWeightMeasure,
    this.netVolumeMeasure,
    this.quantity,
    this.contactParty,
    this.secondaryHazard = const [],
    this.hazardousGoodsTransit = const [],
    this.emergencyTemperature,
    this.flashpointTemperature,
    this.additionalTemperature = const [],
  });
}

