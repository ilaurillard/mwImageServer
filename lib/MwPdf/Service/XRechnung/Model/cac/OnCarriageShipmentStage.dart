import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/TransportModeCode.dart';
import '../cbc/TransportMeansTypeCode.dart';
import '../cbc/TransitDirectionCode.dart';
import '../cbc/PreCarriageIndicator.dart';
import '../cbc/OnCarriageIndicator.dart';
import '../cbc/EstimatedDeliveryDate.dart';
import '../cbc/EstimatedDeliveryTime.dart';
import '../cbc/RequiredDeliveryDate.dart';
import '../cbc/RequiredDeliveryTime.dart';
import '../cbc/LoadingSequenceID.dart';
import '../cbc/SuccessiveSequenceID.dart';
import '../cbc/Instructions.dart';
import '../cbc/DemurrageInstructions.dart';
import '../cbc/CrewQuantity.dart';
import '../cbc/PassengerQuantity.dart';
import '../cac/TransitPeriod.dart';
import '../cac/CarrierParty.dart';
import '../cac/TransportMeans.dart';
import '../cac/LoadingPortLocation.dart';
import '../cac/UnloadingPortLocation.dart';
import '../cac/TransshipPortLocation.dart';
import '../cac/LoadingTransportEvent.dart';
import '../cac/ExaminationTransportEvent.dart';
import '../cac/AvailabilityTransportEvent.dart';
import '../cac/ExportationTransportEvent.dart';
import '../cac/DischargeTransportEvent.dart';
import '../cac/WarehousingTransportEvent.dart';
import '../cac/TakeoverTransportEvent.dart';
import '../cac/OptionalTakeoverTransportEvent.dart';
import '../cac/DropoffTransportEvent.dart';
import '../cac/ActualPickupTransportEvent.dart';
import '../cac/DeliveryTransportEvent.dart';
import '../cac/ReceiptTransportEvent.dart';
import '../cac/StorageTransportEvent.dart';
import '../cac/AcceptanceTransportEvent.dart';
import '../cac/TerminalOperatorParty.dart';
import '../cac/CustomsAgentParty.dart';
import '../cac/EstimatedTransitPeriod.dart';
import '../cac/FreightAllowanceCharge.dart';
import '../cac/FreightChargeLocation.dart';
import '../cac/DetentionTransportEvent.dart';
import '../cac/RequestedDepartureTransportEvent.dart';
import '../cac/RequestedArrivalTransportEvent.dart';
import '../cac/RequestedWaypointTransportEvent.dart';
import '../cac/PlannedDepartureTransportEvent.dart';
import '../cac/PlannedArrivalTransportEvent.dart';
import '../cac/PlannedWaypointTransportEvent.dart';
import '../cac/ActualDepartureTransportEvent.dart';
import '../cac/ActualWaypointTransportEvent.dart';
import '../cac/ActualArrivalTransportEvent.dart';
import '../cac/TransportEvent.dart';
import '../cac/EstimatedDepartureTransportEvent.dart';
import '../cac/EstimatedArrivalTransportEvent.dart';
import '../cac/PassengerPerson.dart';
import '../cac/DriverPerson.dart';
import '../cac/ReportingPerson.dart';
import '../cac/CrewMemberPerson.dart';
import '../cac/SecurityOfficerPerson.dart';
import '../cac/MasterPerson.dart';
import '../cac/ShipsSurgeonPerson.dart';

// A class to describe one stage of movement in a transport of goods.
class OnCarriageShipmentStage {


  // An identifier for this shipment stage.
  final ID? iD;

  // A code signifying the method of transport used for this shipment stage.
  final TransportModeCode? transportModeCode;

  // A code signifying the kind of transport means (truck, vessel, etc.) used for this shipment stage.
  final TransportMeansTypeCode? transportMeansTypeCode;

  // A code signifying the direction of transit in this shipment stage.
  final TransitDirectionCode? transitDirectionCode;

  // An indicator that this stage takes place before the main carriage of the shipment (true) or not (false).
  final PreCarriageIndicator? preCarriageIndicator;

  // An indicator that this stage takes place after the main carriage of the shipment (true) or not (false).
  final OnCarriageIndicator? onCarriageIndicator;

  // The estimated date of delivery in this shipment stage.
  final EstimatedDeliveryDate? estimatedDeliveryDate;

  // The estimated time of delivery in this shipment stage.
  final EstimatedDeliveryTime? estimatedDeliveryTime;

  // The delivery date required by the buyer in this shipment stage.
  final RequiredDeliveryDate? requiredDeliveryDate;

  // The delivery time required by the buyer in this shipment stage.
  final RequiredDeliveryTime? requiredDeliveryTime;

  // An identifier for the loading sequence (of consignments) associated with this shipment stage.
  final LoadingSequenceID? loadingSequenceID;

  // Identifies the successive loading sequence (of consignments) associated with a shipment stage.
  final SuccessiveSequenceID? successiveSequenceID;

  // Text of instructions applicable to a shipment stage.
  final List<Instructions> instructions;

  // Text of instructions relating to demurrage (the case in which a vessel is prevented from loading or discharging cargo within the stipulated laytime).
  final List<DemurrageInstructions> demurrageInstructions;

  // The total number of crew aboard a transport means.
  final CrewQuantity? crewQuantity;

  // The total number of passengers aboard a transport means.
  final PassengerQuantity? passengerQuantity;

  // The period during which this shipment stage actually took place.
  final TransitPeriod? transitPeriod;

  // A carrier party responsible for this shipment stage.
  final List<CarrierParty> carrierParty;

  // The means of transport used in this shipment stage.
  final TransportMeans? transportMeans;

  // The location of loading for a shipment stage.
  final LoadingPortLocation? loadingPortLocation;

  // The location of unloading for a shipment stage.
  final UnloadingPortLocation? unloadingPortLocation;

  // The location of transshipment relating to a shipment stage.
  final TransshipPortLocation? transshipPortLocation;

  // The loading of goods in this shipment stage.
  final LoadingTransportEvent? loadingTransportEvent;

  // The examination of shipments in this shipment stage.
  final ExaminationTransportEvent? examinationTransportEvent;

  // The making available of shipments in this shipment stage.
  final AvailabilityTransportEvent? availabilityTransportEvent;

  // The export event associated with this shipment stage.
  final ExportationTransportEvent? exportationTransportEvent;

  // The discharge event associated with this shipment stage.
  final DischargeTransportEvent? dischargeTransportEvent;

  // The warehousing event associated with this shipment stage.
  final WarehousingTransportEvent? warehousingTransportEvent;

  // The receiver's takeover of the goods in this shipment stage.
  final TakeoverTransportEvent? takeoverTransportEvent;

  // The optional takeover of the goods in this shipment stage.
  final OptionalTakeoverTransportEvent? optionalTakeoverTransportEvent;

  // The dropping off of goods in this shipment stage.
  final DropoffTransportEvent? dropoffTransportEvent;

  // The pickup of goods in this shipment stage.
  final ActualPickupTransportEvent? actualPickupTransportEvent;

  // The delivery of goods in this shipment stage.
  final DeliveryTransportEvent? deliveryTransportEvent;

  // The receipt of goods in this shipment stage.
  final ReceiptTransportEvent? receiptTransportEvent;

  // The storage of goods in this shipment stage.
  final StorageTransportEvent? storageTransportEvent;

  // The acceptance of goods in this shipment stage.
  final AcceptanceTransportEvent? acceptanceTransportEvent;

  // A terminal operator associated with this shipment stage.
  final TerminalOperatorParty? terminalOperatorParty;

  // A customs agent associated with this shipment stage.
  final CustomsAgentParty? customsAgentParty;

  // The estimated transit period of this shipment stage.
  final EstimatedTransitPeriod? estimatedTransitPeriod;

  // A freight allowance charge for this shipment stage.
  final List<FreightAllowanceCharge> freightAllowanceCharge;

  // The location associated with a freight charge related to this shipment stage.
  final FreightChargeLocation? freightChargeLocation;

  // The detention of a transport means during loading and unloading operations.
  final List<DetentionTransportEvent> detentionTransportEvent;

  // The departure requested by the party requesting a transportation service.
  final RequestedDepartureTransportEvent? requestedDepartureTransportEvent;

  // The arrival requested by the party requesting a transportation service.
  final RequestedArrivalTransportEvent? requestedArrivalTransportEvent;

  // A waypoint requested by the party requesting a transportation service.
  final List<RequestedWaypointTransportEvent> requestedWaypointTransportEvent;

  // The departure planned by the party providing a transportation service.
  final PlannedDepartureTransportEvent? plannedDepartureTransportEvent;

  // The arrival planned by the party providing a transportation service.
  final PlannedArrivalTransportEvent? plannedArrivalTransportEvent;

  // A waypoint planned by the party providing a transportation service.
  final List<PlannedWaypointTransportEvent> plannedWaypointTransportEvent;

  // The actual departure from a specific location during a transportation service.
  final ActualDepartureTransportEvent? actualDepartureTransportEvent;

  // The location of an actual waypoint during a transportation service.
  final ActualWaypointTransportEvent? actualWaypointTransportEvent;

  // The actual arrival at a specific location during a transportation service.
  final ActualArrivalTransportEvent? actualArrivalTransportEvent;

  // A significant occurrence in the course of this shipment of goods.
  final List<TransportEvent> transportEvent;

  // Describes an estimated departure at a location during a transport service.
  final EstimatedDepartureTransportEvent? estimatedDepartureTransportEvent;

  // Describes an estimated arrival at a location during a transport service.
  final EstimatedArrivalTransportEvent? estimatedArrivalTransportEvent;

  // A person who travels in a conveyance without participating in its operation.
  final List<PassengerPerson> passengerPerson;

  // Describes a person responsible for driving the transport means.
  final List<DriverPerson> driverPerson;

  // Describes a person being responsible for providing the required administrative reporting relating to a transport.
  final ReportingPerson? reportingPerson;

  // A person operating or serving aboard a transport means.
  final List<CrewMemberPerson> crewMemberPerson;

  // The person on board the vessel, accountable to the master, designated by the company as responsible for the security of the ship, including implementation and maintenance of the ship security plan and for the liaison with the company security officer and the port facility security officers.
  final SecurityOfficerPerson? securityOfficerPerson;

  // The person responsible for the ship's safe and efficient operation, including cargo operations, navigation, crew management and for ensuring that the vessel complies with local and international laws, as well as company and flag state policies.
  final MasterPerson? masterPerson;

  // The person responsible for the health of the people aboard a ship at sea.
  final ShipsSurgeonPerson? shipsSurgeonPerson;

  OnCarriageShipmentStage ({
    this.iD,
    this.transportModeCode,
    this.transportMeansTypeCode,
    this.transitDirectionCode,
    this.preCarriageIndicator,
    this.onCarriageIndicator,
    this.estimatedDeliveryDate,
    this.estimatedDeliveryTime,
    this.requiredDeliveryDate,
    this.requiredDeliveryTime,
    this.loadingSequenceID,
    this.successiveSequenceID,
    this.instructions = const [],
    this.demurrageInstructions = const [],
    this.crewQuantity,
    this.passengerQuantity,
    this.transitPeriod,
    this.carrierParty = const [],
    this.transportMeans,
    this.loadingPortLocation,
    this.unloadingPortLocation,
    this.transshipPortLocation,
    this.loadingTransportEvent,
    this.examinationTransportEvent,
    this.availabilityTransportEvent,
    this.exportationTransportEvent,
    this.dischargeTransportEvent,
    this.warehousingTransportEvent,
    this.takeoverTransportEvent,
    this.optionalTakeoverTransportEvent,
    this.dropoffTransportEvent,
    this.actualPickupTransportEvent,
    this.deliveryTransportEvent,
    this.receiptTransportEvent,
    this.storageTransportEvent,
    this.acceptanceTransportEvent,
    this.terminalOperatorParty,
    this.customsAgentParty,
    this.estimatedTransitPeriod,
    this.freightAllowanceCharge = const [],
    this.freightChargeLocation,
    this.detentionTransportEvent = const [],
    this.requestedDepartureTransportEvent,
    this.requestedArrivalTransportEvent,
    this.requestedWaypointTransportEvent = const [],
    this.plannedDepartureTransportEvent,
    this.plannedArrivalTransportEvent,
    this.plannedWaypointTransportEvent = const [],
    this.actualDepartureTransportEvent,
    this.actualWaypointTransportEvent,
    this.actualArrivalTransportEvent,
    this.transportEvent = const [],
    this.estimatedDepartureTransportEvent,
    this.estimatedArrivalTransportEvent,
    this.passengerPerson = const [],
    this.driverPerson = const [],
    this.reportingPerson,
    this.crewMemberPerson = const [],
    this.securityOfficerPerson,
    this.masterPerson,
    this.shipsSurgeonPerson,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'transportModeCode': transportModeCode?.toJson(),
     'transportMeansTypeCode': transportMeansTypeCode?.toJson(),
     'transitDirectionCode': transitDirectionCode?.toJson(),
     'preCarriageIndicator': preCarriageIndicator?.toJson(),
     'onCarriageIndicator': onCarriageIndicator?.toJson(),
     'estimatedDeliveryDate': estimatedDeliveryDate?.toJson(),
     'estimatedDeliveryTime': estimatedDeliveryTime?.toJson(),
     'requiredDeliveryDate': requiredDeliveryDate?.toJson(),
     'requiredDeliveryTime': requiredDeliveryTime?.toJson(),
     'loadingSequenceID': loadingSequenceID?.toJson(),
     'successiveSequenceID': successiveSequenceID?.toJson(),
     'instructions': instructions.map((e) => e.toJson()).toList(),
     'demurrageInstructions': demurrageInstructions.map((e) => e.toJson()).toList(),
     'crewQuantity': crewQuantity?.toJson(),
     'passengerQuantity': passengerQuantity?.toJson(),
     'transitPeriod': transitPeriod?.toJson(),
     'carrierParty': carrierParty.map((e) => e.toJson()).toList(),
     'transportMeans': transportMeans?.toJson(),
     'loadingPortLocation': loadingPortLocation?.toJson(),
     'unloadingPortLocation': unloadingPortLocation?.toJson(),
     'transshipPortLocation': transshipPortLocation?.toJson(),
     'loadingTransportEvent': loadingTransportEvent?.toJson(),
     'examinationTransportEvent': examinationTransportEvent?.toJson(),
     'availabilityTransportEvent': availabilityTransportEvent?.toJson(),
     'exportationTransportEvent': exportationTransportEvent?.toJson(),
     'dischargeTransportEvent': dischargeTransportEvent?.toJson(),
     'warehousingTransportEvent': warehousingTransportEvent?.toJson(),
     'takeoverTransportEvent': takeoverTransportEvent?.toJson(),
     'optionalTakeoverTransportEvent': optionalTakeoverTransportEvent?.toJson(),
     'dropoffTransportEvent': dropoffTransportEvent?.toJson(),
     'actualPickupTransportEvent': actualPickupTransportEvent?.toJson(),
     'deliveryTransportEvent': deliveryTransportEvent?.toJson(),
     'receiptTransportEvent': receiptTransportEvent?.toJson(),
     'storageTransportEvent': storageTransportEvent?.toJson(),
     'acceptanceTransportEvent': acceptanceTransportEvent?.toJson(),
     'terminalOperatorParty': terminalOperatorParty?.toJson(),
     'customsAgentParty': customsAgentParty?.toJson(),
     'estimatedTransitPeriod': estimatedTransitPeriod?.toJson(),
     'freightAllowanceCharge': freightAllowanceCharge.map((e) => e.toJson()).toList(),
     'freightChargeLocation': freightChargeLocation?.toJson(),
     'detentionTransportEvent': detentionTransportEvent.map((e) => e.toJson()).toList(),
     'requestedDepartureTransportEvent': requestedDepartureTransportEvent?.toJson(),
     'requestedArrivalTransportEvent': requestedArrivalTransportEvent?.toJson(),
     'requestedWaypointTransportEvent': requestedWaypointTransportEvent.map((e) => e.toJson()).toList(),
     'plannedDepartureTransportEvent': plannedDepartureTransportEvent?.toJson(),
     'plannedArrivalTransportEvent': plannedArrivalTransportEvent?.toJson(),
     'plannedWaypointTransportEvent': plannedWaypointTransportEvent.map((e) => e.toJson()).toList(),
     'actualDepartureTransportEvent': actualDepartureTransportEvent?.toJson(),
     'actualWaypointTransportEvent': actualWaypointTransportEvent?.toJson(),
     'actualArrivalTransportEvent': actualArrivalTransportEvent?.toJson(),
     'transportEvent': transportEvent.map((e) => e.toJson()).toList(),
     'estimatedDepartureTransportEvent': estimatedDepartureTransportEvent?.toJson(),
     'estimatedArrivalTransportEvent': estimatedArrivalTransportEvent?.toJson(),
     'passengerPerson': passengerPerson.map((e) => e.toJson()).toList(),
     'driverPerson': driverPerson.map((e) => e.toJson()).toList(),
     'reportingPerson': reportingPerson?.toJson(),
     'crewMemberPerson': crewMemberPerson.map((e) => e.toJson()).toList(),
     'securityOfficerPerson': securityOfficerPerson?.toJson(),
     'masterPerson': masterPerson?.toJson(),
     'shipsSurgeonPerson': shipsSurgeonPerson?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

