import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/ShipmentStageTypeCode.dart';
import '../cbc/ShipmentStageType.dart';
import '../cbc/TransportModeCode.dart';
import '../cbc/TransportMeansTypeCode.dart';
import '../cbc/TransitDirectionCode.dart';
import '../cbc/PreCarriageIndicator.dart';
import '../cbc/OnCarriageIndicator.dart';
import '../cbc/CabotageIndicator.dart';
import '../cbc/HazardousRiskIndicator.dart';
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
import '../cac/DestinationPortCall.dart';
import '../cac/ShipStoreArticle.dart';
import '../cac/CrewPersonEffect.dart';
import '../cac/MaritimeWaste.dart';
import '../cac/BallastWaterSummary.dart';
import '../cac/ISPSRequirements.dart';
import '../cac/MaritimeHealthDeclaration.dart';

// A class to describe one stage of movement in a transport of goods.
class OnCarriageShipmentStage {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this shipment stage.
  final ID? iD;

  // The type of shipment stage, expressed as a code.
  final ShipmentStageTypeCode? shipmentStageTypeCode;

  // The type of shipment stage, expressed as text.
  final List<ShipmentStageType> shipmentStageType;

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

  // An indicator that cabotage applies for this shipment stage (true) or not (false).
  final CabotageIndicator? cabotageIndicator;

  // An indicator that the transported goods in this shipment stage are subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

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

  // A destination port call for this shipment stage.
  final DestinationPortCall? destinationPortCall;

  // The ship store articles for this shipment stage.
  final List<ShipStoreArticle> shipStoreArticle;

  // The crew person effects for this shipment stage.
  final List<CrewPersonEffect> crewPersonEffect;

  // The maritime waste for this shipment stage.
  final List<MaritimeWaste> maritimeWaste;

  // A ballast water summary for this shipment stage.
  final BallastWaterSummary? ballastWaterSummary;

  // The ISPS (International Ship and Port Facility Security Code) requirements for this shipment stage.
  final ISPSRequirements? iSPSRequirements;

  // A maritime declaration of health for this shipment stage.
  final MaritimeHealthDeclaration? maritimeHealthDeclaration;

  OnCarriageShipmentStage ({
    this.uBLExtensions,
    this.iD,
    this.shipmentStageTypeCode,
    this.shipmentStageType = const [],
    this.transportModeCode,
    this.transportMeansTypeCode,
    this.transitDirectionCode,
    this.preCarriageIndicator,
    this.onCarriageIndicator,
    this.cabotageIndicator,
    this.hazardousRiskIndicator,
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
    this.destinationPortCall,
    this.shipStoreArticle = const [],
    this.crewPersonEffect = const [],
    this.maritimeWaste = const [],
    this.ballastWaterSummary,
    this.iSPSRequirements,
    this.maritimeHealthDeclaration,
  });

  static OnCarriageShipmentStage? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OnCarriageShipmentStage (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      shipmentStageTypeCode: ShipmentStageTypeCode.fromJson(json['shipmentStageTypeCode'] as Map<String, dynamic>?),
      shipmentStageType: (json['shipmentStageType'] as List? ?? []).map((dynamic d) => ShipmentStageType.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportModeCode: TransportModeCode.fromJson(json['transportModeCode'] as Map<String, dynamic>?),
      transportMeansTypeCode: TransportMeansTypeCode.fromJson(json['transportMeansTypeCode'] as Map<String, dynamic>?),
      transitDirectionCode: TransitDirectionCode.fromJson(json['transitDirectionCode'] as Map<String, dynamic>?),
      preCarriageIndicator: PreCarriageIndicator.fromJson(json['preCarriageIndicator'] as Map<String, dynamic>?),
      onCarriageIndicator: OnCarriageIndicator.fromJson(json['onCarriageIndicator'] as Map<String, dynamic>?),
      cabotageIndicator: CabotageIndicator.fromJson(json['cabotageIndicator'] as Map<String, dynamic>?),
      hazardousRiskIndicator: HazardousRiskIndicator.fromJson(json['hazardousRiskIndicator'] as Map<String, dynamic>?),
      estimatedDeliveryDate: EstimatedDeliveryDate.fromJson(json['estimatedDeliveryDate'] as Map<String, dynamic>?),
      estimatedDeliveryTime: EstimatedDeliveryTime.fromJson(json['estimatedDeliveryTime'] as Map<String, dynamic>?),
      requiredDeliveryDate: RequiredDeliveryDate.fromJson(json['requiredDeliveryDate'] as Map<String, dynamic>?),
      requiredDeliveryTime: RequiredDeliveryTime.fromJson(json['requiredDeliveryTime'] as Map<String, dynamic>?),
      loadingSequenceID: LoadingSequenceID.fromJson(json['loadingSequenceID'] as Map<String, dynamic>?),
      successiveSequenceID: SuccessiveSequenceID.fromJson(json['successiveSequenceID'] as Map<String, dynamic>?),
      instructions: (json['instructions'] as List? ?? []).map((dynamic d) => Instructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      demurrageInstructions: (json['demurrageInstructions'] as List? ?? []).map((dynamic d) => DemurrageInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      crewQuantity: CrewQuantity.fromJson(json['crewQuantity'] as Map<String, dynamic>?),
      passengerQuantity: PassengerQuantity.fromJson(json['passengerQuantity'] as Map<String, dynamic>?),
      transitPeriod: TransitPeriod.fromJson(json['transitPeriod'] as Map<String, dynamic>?),
      carrierParty: (json['carrierParty'] as List? ?? []).map((dynamic d) => CarrierParty.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportMeans: TransportMeans.fromJson(json['transportMeans'] as Map<String, dynamic>?),
      loadingPortLocation: LoadingPortLocation.fromJson(json['loadingPortLocation'] as Map<String, dynamic>?),
      unloadingPortLocation: UnloadingPortLocation.fromJson(json['unloadingPortLocation'] as Map<String, dynamic>?),
      transshipPortLocation: TransshipPortLocation.fromJson(json['transshipPortLocation'] as Map<String, dynamic>?),
      loadingTransportEvent: LoadingTransportEvent.fromJson(json['loadingTransportEvent'] as Map<String, dynamic>?),
      examinationTransportEvent: ExaminationTransportEvent.fromJson(json['examinationTransportEvent'] as Map<String, dynamic>?),
      availabilityTransportEvent: AvailabilityTransportEvent.fromJson(json['availabilityTransportEvent'] as Map<String, dynamic>?),
      exportationTransportEvent: ExportationTransportEvent.fromJson(json['exportationTransportEvent'] as Map<String, dynamic>?),
      dischargeTransportEvent: DischargeTransportEvent.fromJson(json['dischargeTransportEvent'] as Map<String, dynamic>?),
      warehousingTransportEvent: WarehousingTransportEvent.fromJson(json['warehousingTransportEvent'] as Map<String, dynamic>?),
      takeoverTransportEvent: TakeoverTransportEvent.fromJson(json['takeoverTransportEvent'] as Map<String, dynamic>?),
      optionalTakeoverTransportEvent: OptionalTakeoverTransportEvent.fromJson(json['optionalTakeoverTransportEvent'] as Map<String, dynamic>?),
      dropoffTransportEvent: DropoffTransportEvent.fromJson(json['dropoffTransportEvent'] as Map<String, dynamic>?),
      actualPickupTransportEvent: ActualPickupTransportEvent.fromJson(json['actualPickupTransportEvent'] as Map<String, dynamic>?),
      deliveryTransportEvent: DeliveryTransportEvent.fromJson(json['deliveryTransportEvent'] as Map<String, dynamic>?),
      receiptTransportEvent: ReceiptTransportEvent.fromJson(json['receiptTransportEvent'] as Map<String, dynamic>?),
      storageTransportEvent: StorageTransportEvent.fromJson(json['storageTransportEvent'] as Map<String, dynamic>?),
      acceptanceTransportEvent: AcceptanceTransportEvent.fromJson(json['acceptanceTransportEvent'] as Map<String, dynamic>?),
      terminalOperatorParty: TerminalOperatorParty.fromJson(json['terminalOperatorParty'] as Map<String, dynamic>?),
      customsAgentParty: CustomsAgentParty.fromJson(json['customsAgentParty'] as Map<String, dynamic>?),
      estimatedTransitPeriod: EstimatedTransitPeriod.fromJson(json['estimatedTransitPeriod'] as Map<String, dynamic>?),
      freightAllowanceCharge: (json['freightAllowanceCharge'] as List? ?? []).map((dynamic d) => FreightAllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      freightChargeLocation: FreightChargeLocation.fromJson(json['freightChargeLocation'] as Map<String, dynamic>?),
      detentionTransportEvent: (json['detentionTransportEvent'] as List? ?? []).map((dynamic d) => DetentionTransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      requestedDepartureTransportEvent: RequestedDepartureTransportEvent.fromJson(json['requestedDepartureTransportEvent'] as Map<String, dynamic>?),
      requestedArrivalTransportEvent: RequestedArrivalTransportEvent.fromJson(json['requestedArrivalTransportEvent'] as Map<String, dynamic>?),
      requestedWaypointTransportEvent: (json['requestedWaypointTransportEvent'] as List? ?? []).map((dynamic d) => RequestedWaypointTransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      plannedDepartureTransportEvent: PlannedDepartureTransportEvent.fromJson(json['plannedDepartureTransportEvent'] as Map<String, dynamic>?),
      plannedArrivalTransportEvent: PlannedArrivalTransportEvent.fromJson(json['plannedArrivalTransportEvent'] as Map<String, dynamic>?),
      plannedWaypointTransportEvent: (json['plannedWaypointTransportEvent'] as List? ?? []).map((dynamic d) => PlannedWaypointTransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      actualDepartureTransportEvent: ActualDepartureTransportEvent.fromJson(json['actualDepartureTransportEvent'] as Map<String, dynamic>?),
      actualWaypointTransportEvent: ActualWaypointTransportEvent.fromJson(json['actualWaypointTransportEvent'] as Map<String, dynamic>?),
      actualArrivalTransportEvent: ActualArrivalTransportEvent.fromJson(json['actualArrivalTransportEvent'] as Map<String, dynamic>?),
      transportEvent: (json['transportEvent'] as List? ?? []).map((dynamic d) => TransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      estimatedDepartureTransportEvent: EstimatedDepartureTransportEvent.fromJson(json['estimatedDepartureTransportEvent'] as Map<String, dynamic>?),
      estimatedArrivalTransportEvent: EstimatedArrivalTransportEvent.fromJson(json['estimatedArrivalTransportEvent'] as Map<String, dynamic>?),
      passengerPerson: (json['passengerPerson'] as List? ?? []).map((dynamic d) => PassengerPerson.fromJson(d as Map<String, dynamic>?)!).toList(),
      driverPerson: (json['driverPerson'] as List? ?? []).map((dynamic d) => DriverPerson.fromJson(d as Map<String, dynamic>?)!).toList(),
      reportingPerson: ReportingPerson.fromJson(json['reportingPerson'] as Map<String, dynamic>?),
      crewMemberPerson: (json['crewMemberPerson'] as List? ?? []).map((dynamic d) => CrewMemberPerson.fromJson(d as Map<String, dynamic>?)!).toList(),
      securityOfficerPerson: SecurityOfficerPerson.fromJson(json['securityOfficerPerson'] as Map<String, dynamic>?),
      masterPerson: MasterPerson.fromJson(json['masterPerson'] as Map<String, dynamic>?),
      shipsSurgeonPerson: ShipsSurgeonPerson.fromJson(json['shipsSurgeonPerson'] as Map<String, dynamic>?),
      destinationPortCall: DestinationPortCall.fromJson(json['destinationPortCall'] as Map<String, dynamic>?),
      shipStoreArticle: (json['shipStoreArticle'] as List? ?? []).map((dynamic d) => ShipStoreArticle.fromJson(d as Map<String, dynamic>?)!).toList(),
      crewPersonEffect: (json['crewPersonEffect'] as List? ?? []).map((dynamic d) => CrewPersonEffect.fromJson(d as Map<String, dynamic>?)!).toList(),
      maritimeWaste: (json['maritimeWaste'] as List? ?? []).map((dynamic d) => MaritimeWaste.fromJson(d as Map<String, dynamic>?)!).toList(),
      ballastWaterSummary: BallastWaterSummary.fromJson(json['ballastWaterSummary'] as Map<String, dynamic>?),
      iSPSRequirements: ISPSRequirements.fromJson(json['iSPSRequirements'] as Map<String, dynamic>?),
      maritimeHealthDeclaration: MaritimeHealthDeclaration.fromJson(json['maritimeHealthDeclaration'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'shipmentStageTypeCode': shipmentStageTypeCode?.toJson(),
      'shipmentStageType': shipmentStageType.map((e) => e.toJson()).toList(),
      'transportModeCode': transportModeCode?.toJson(),
      'transportMeansTypeCode': transportMeansTypeCode?.toJson(),
      'transitDirectionCode': transitDirectionCode?.toJson(),
      'preCarriageIndicator': preCarriageIndicator?.toJson(),
      'onCarriageIndicator': onCarriageIndicator?.toJson(),
      'cabotageIndicator': cabotageIndicator?.toJson(),
      'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
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
      'destinationPortCall': destinationPortCall?.toJson(),
      'shipStoreArticle': shipStoreArticle.map((e) => e.toJson()).toList(),
      'crewPersonEffect': crewPersonEffect.map((e) => e.toJson()).toList(),
      'maritimeWaste': maritimeWaste.map((e) => e.toJson()).toList(),
      'ballastWaterSummary': ballastWaterSummary?.toJson(),
      'iSPSRequirements': iSPSRequirements?.toJson(),
      'maritimeHealthDeclaration': maritimeHealthDeclaration?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OnCarriageShipmentStage? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OnCarriageShipmentStage (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      shipmentStageTypeCode: ShipmentStageTypeCode.fromXml(xml.findElements('cbc:ShipmentStageTypeCode').singleOrNull),
      shipmentStageType: xml.findElements('cbc:ShipmentStageType').map((XmlElement e) => ShipmentStageType.fromXml(e)!).toList(),
      transportModeCode: TransportModeCode.fromXml(xml.findElements('cbc:TransportModeCode').singleOrNull),
      transportMeansTypeCode: TransportMeansTypeCode.fromXml(xml.findElements('cbc:TransportMeansTypeCode').singleOrNull),
      transitDirectionCode: TransitDirectionCode.fromXml(xml.findElements('cbc:TransitDirectionCode').singleOrNull),
      preCarriageIndicator: PreCarriageIndicator.fromXml(xml.findElements('cbc:PreCarriageIndicator').singleOrNull),
      onCarriageIndicator: OnCarriageIndicator.fromXml(xml.findElements('cbc:OnCarriageIndicator').singleOrNull),
      cabotageIndicator: CabotageIndicator.fromXml(xml.findElements('cbc:CabotageIndicator').singleOrNull),
      hazardousRiskIndicator: HazardousRiskIndicator.fromXml(xml.findElements('cbc:HazardousRiskIndicator').singleOrNull),
      estimatedDeliveryDate: EstimatedDeliveryDate.fromXml(xml.findElements('cbc:EstimatedDeliveryDate').singleOrNull),
      estimatedDeliveryTime: EstimatedDeliveryTime.fromXml(xml.findElements('cbc:EstimatedDeliveryTime').singleOrNull),
      requiredDeliveryDate: RequiredDeliveryDate.fromXml(xml.findElements('cbc:RequiredDeliveryDate').singleOrNull),
      requiredDeliveryTime: RequiredDeliveryTime.fromXml(xml.findElements('cbc:RequiredDeliveryTime').singleOrNull),
      loadingSequenceID: LoadingSequenceID.fromXml(xml.findElements('cbc:LoadingSequenceID').singleOrNull),
      successiveSequenceID: SuccessiveSequenceID.fromXml(xml.findElements('cbc:SuccessiveSequenceID').singleOrNull),
      instructions: xml.findElements('cbc:Instructions').map((XmlElement e) => Instructions.fromXml(e)!).toList(),
      demurrageInstructions: xml.findElements('cbc:DemurrageInstructions').map((XmlElement e) => DemurrageInstructions.fromXml(e)!).toList(),
      crewQuantity: CrewQuantity.fromXml(xml.findElements('cbc:CrewQuantity').singleOrNull),
      passengerQuantity: PassengerQuantity.fromXml(xml.findElements('cbc:PassengerQuantity').singleOrNull),
      transitPeriod: TransitPeriod.fromXml(xml.findElements('cac:TransitPeriod').singleOrNull),
      carrierParty: xml.findElements('cac:CarrierParty').map((XmlElement e) => CarrierParty.fromXml(e)!).toList(),
      transportMeans: TransportMeans.fromXml(xml.findElements('cac:TransportMeans').singleOrNull),
      loadingPortLocation: LoadingPortLocation.fromXml(xml.findElements('cac:LoadingPortLocation').singleOrNull),
      unloadingPortLocation: UnloadingPortLocation.fromXml(xml.findElements('cac:UnloadingPortLocation').singleOrNull),
      transshipPortLocation: TransshipPortLocation.fromXml(xml.findElements('cac:TransshipPortLocation').singleOrNull),
      loadingTransportEvent: LoadingTransportEvent.fromXml(xml.findElements('cac:LoadingTransportEvent').singleOrNull),
      examinationTransportEvent: ExaminationTransportEvent.fromXml(xml.findElements('cac:ExaminationTransportEvent').singleOrNull),
      availabilityTransportEvent: AvailabilityTransportEvent.fromXml(xml.findElements('cac:AvailabilityTransportEvent').singleOrNull),
      exportationTransportEvent: ExportationTransportEvent.fromXml(xml.findElements('cac:ExportationTransportEvent').singleOrNull),
      dischargeTransportEvent: DischargeTransportEvent.fromXml(xml.findElements('cac:DischargeTransportEvent').singleOrNull),
      warehousingTransportEvent: WarehousingTransportEvent.fromXml(xml.findElements('cac:WarehousingTransportEvent').singleOrNull),
      takeoverTransportEvent: TakeoverTransportEvent.fromXml(xml.findElements('cac:TakeoverTransportEvent').singleOrNull),
      optionalTakeoverTransportEvent: OptionalTakeoverTransportEvent.fromXml(xml.findElements('cac:OptionalTakeoverTransportEvent').singleOrNull),
      dropoffTransportEvent: DropoffTransportEvent.fromXml(xml.findElements('cac:DropoffTransportEvent').singleOrNull),
      actualPickupTransportEvent: ActualPickupTransportEvent.fromXml(xml.findElements('cac:ActualPickupTransportEvent').singleOrNull),
      deliveryTransportEvent: DeliveryTransportEvent.fromXml(xml.findElements('cac:DeliveryTransportEvent').singleOrNull),
      receiptTransportEvent: ReceiptTransportEvent.fromXml(xml.findElements('cac:ReceiptTransportEvent').singleOrNull),
      storageTransportEvent: StorageTransportEvent.fromXml(xml.findElements('cac:StorageTransportEvent').singleOrNull),
      acceptanceTransportEvent: AcceptanceTransportEvent.fromXml(xml.findElements('cac:AcceptanceTransportEvent').singleOrNull),
      terminalOperatorParty: TerminalOperatorParty.fromXml(xml.findElements('cac:TerminalOperatorParty').singleOrNull),
      customsAgentParty: CustomsAgentParty.fromXml(xml.findElements('cac:CustomsAgentParty').singleOrNull),
      estimatedTransitPeriod: EstimatedTransitPeriod.fromXml(xml.findElements('cac:EstimatedTransitPeriod').singleOrNull),
      freightAllowanceCharge: xml.findElements('cac:FreightAllowanceCharge').map((XmlElement e) => FreightAllowanceCharge.fromXml(e)!).toList(),
      freightChargeLocation: FreightChargeLocation.fromXml(xml.findElements('cac:FreightChargeLocation').singleOrNull),
      detentionTransportEvent: xml.findElements('cac:DetentionTransportEvent').map((XmlElement e) => DetentionTransportEvent.fromXml(e)!).toList(),
      requestedDepartureTransportEvent: RequestedDepartureTransportEvent.fromXml(xml.findElements('cac:RequestedDepartureTransportEvent').singleOrNull),
      requestedArrivalTransportEvent: RequestedArrivalTransportEvent.fromXml(xml.findElements('cac:RequestedArrivalTransportEvent').singleOrNull),
      requestedWaypointTransportEvent: xml.findElements('cac:RequestedWaypointTransportEvent').map((XmlElement e) => RequestedWaypointTransportEvent.fromXml(e)!).toList(),
      plannedDepartureTransportEvent: PlannedDepartureTransportEvent.fromXml(xml.findElements('cac:PlannedDepartureTransportEvent').singleOrNull),
      plannedArrivalTransportEvent: PlannedArrivalTransportEvent.fromXml(xml.findElements('cac:PlannedArrivalTransportEvent').singleOrNull),
      plannedWaypointTransportEvent: xml.findElements('cac:PlannedWaypointTransportEvent').map((XmlElement e) => PlannedWaypointTransportEvent.fromXml(e)!).toList(),
      actualDepartureTransportEvent: ActualDepartureTransportEvent.fromXml(xml.findElements('cac:ActualDepartureTransportEvent').singleOrNull),
      actualWaypointTransportEvent: ActualWaypointTransportEvent.fromXml(xml.findElements('cac:ActualWaypointTransportEvent').singleOrNull),
      actualArrivalTransportEvent: ActualArrivalTransportEvent.fromXml(xml.findElements('cac:ActualArrivalTransportEvent').singleOrNull),
      transportEvent: xml.findElements('cac:TransportEvent').map((XmlElement e) => TransportEvent.fromXml(e)!).toList(),
      estimatedDepartureTransportEvent: EstimatedDepartureTransportEvent.fromXml(xml.findElements('cac:EstimatedDepartureTransportEvent').singleOrNull),
      estimatedArrivalTransportEvent: EstimatedArrivalTransportEvent.fromXml(xml.findElements('cac:EstimatedArrivalTransportEvent').singleOrNull),
      passengerPerson: xml.findElements('cac:PassengerPerson').map((XmlElement e) => PassengerPerson.fromXml(e)!).toList(),
      driverPerson: xml.findElements('cac:DriverPerson').map((XmlElement e) => DriverPerson.fromXml(e)!).toList(),
      reportingPerson: ReportingPerson.fromXml(xml.findElements('cac:ReportingPerson').singleOrNull),
      crewMemberPerson: xml.findElements('cac:CrewMemberPerson').map((XmlElement e) => CrewMemberPerson.fromXml(e)!).toList(),
      securityOfficerPerson: SecurityOfficerPerson.fromXml(xml.findElements('cac:SecurityOfficerPerson').singleOrNull),
      masterPerson: MasterPerson.fromXml(xml.findElements('cac:MasterPerson').singleOrNull),
      shipsSurgeonPerson: ShipsSurgeonPerson.fromXml(xml.findElements('cac:ShipsSurgeonPerson').singleOrNull),
      destinationPortCall: DestinationPortCall.fromXml(xml.findElements('cac:DestinationPortCall').singleOrNull),
      shipStoreArticle: xml.findElements('cac:ShipStoreArticle').map((XmlElement e) => ShipStoreArticle.fromXml(e)!).toList(),
      crewPersonEffect: xml.findElements('cac:CrewPersonEffect').map((XmlElement e) => CrewPersonEffect.fromXml(e)!).toList(),
      maritimeWaste: xml.findElements('cac:MaritimeWaste').map((XmlElement e) => MaritimeWaste.fromXml(e)!).toList(),
      ballastWaterSummary: BallastWaterSummary.fromXml(xml.findElements('cac:BallastWaterSummary').singleOrNull),
      iSPSRequirements: ISPSRequirements.fromXml(xml.findElements('cac:ISPSRequirements').singleOrNull),
      maritimeHealthDeclaration: MaritimeHealthDeclaration.fromXml(xml.findElements('cac:MaritimeHealthDeclaration').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      shipmentStageTypeCode?.toXml(),
      ...shipmentStageType.map((ShipmentStageType e) => e.toXml()).toList(),
      transportModeCode?.toXml(),
      transportMeansTypeCode?.toXml(),
      transitDirectionCode?.toXml(),
      preCarriageIndicator?.toXml(),
      onCarriageIndicator?.toXml(),
      cabotageIndicator?.toXml(),
      hazardousRiskIndicator?.toXml(),
      estimatedDeliveryDate?.toXml(),
      estimatedDeliveryTime?.toXml(),
      requiredDeliveryDate?.toXml(),
      requiredDeliveryTime?.toXml(),
      loadingSequenceID?.toXml(),
      successiveSequenceID?.toXml(),
      ...instructions.map((Instructions e) => e.toXml()).toList(),
      ...demurrageInstructions.map((DemurrageInstructions e) => e.toXml()).toList(),
      crewQuantity?.toXml(),
      passengerQuantity?.toXml(),
      transitPeriod?.toXml(),
      ...carrierParty.map((CarrierParty e) => e.toXml()).toList(),
      transportMeans?.toXml(),
      loadingPortLocation?.toXml(),
      unloadingPortLocation?.toXml(),
      transshipPortLocation?.toXml(),
      loadingTransportEvent?.toXml(),
      examinationTransportEvent?.toXml(),
      availabilityTransportEvent?.toXml(),
      exportationTransportEvent?.toXml(),
      dischargeTransportEvent?.toXml(),
      warehousingTransportEvent?.toXml(),
      takeoverTransportEvent?.toXml(),
      optionalTakeoverTransportEvent?.toXml(),
      dropoffTransportEvent?.toXml(),
      actualPickupTransportEvent?.toXml(),
      deliveryTransportEvent?.toXml(),
      receiptTransportEvent?.toXml(),
      storageTransportEvent?.toXml(),
      acceptanceTransportEvent?.toXml(),
      terminalOperatorParty?.toXml(),
      customsAgentParty?.toXml(),
      estimatedTransitPeriod?.toXml(),
      ...freightAllowanceCharge.map((FreightAllowanceCharge e) => e.toXml()).toList(),
      freightChargeLocation?.toXml(),
      ...detentionTransportEvent.map((DetentionTransportEvent e) => e.toXml()).toList(),
      requestedDepartureTransportEvent?.toXml(),
      requestedArrivalTransportEvent?.toXml(),
      ...requestedWaypointTransportEvent.map((RequestedWaypointTransportEvent e) => e.toXml()).toList(),
      plannedDepartureTransportEvent?.toXml(),
      plannedArrivalTransportEvent?.toXml(),
      ...plannedWaypointTransportEvent.map((PlannedWaypointTransportEvent e) => e.toXml()).toList(),
      actualDepartureTransportEvent?.toXml(),
      actualWaypointTransportEvent?.toXml(),
      actualArrivalTransportEvent?.toXml(),
      ...transportEvent.map((TransportEvent e) => e.toXml()).toList(),
      estimatedDepartureTransportEvent?.toXml(),
      estimatedArrivalTransportEvent?.toXml(),
      ...passengerPerson.map((PassengerPerson e) => e.toXml()).toList(),
      ...driverPerson.map((DriverPerson e) => e.toXml()).toList(),
      reportingPerson?.toXml(),
      ...crewMemberPerson.map((CrewMemberPerson e) => e.toXml()).toList(),
      securityOfficerPerson?.toXml(),
      masterPerson?.toXml(),
      shipsSurgeonPerson?.toXml(),
      destinationPortCall?.toXml(),
      ...shipStoreArticle.map((ShipStoreArticle e) => e.toXml()).toList(),
      ...crewPersonEffect.map((CrewPersonEffect e) => e.toXml()).toList(),
      ...maritimeWaste.map((MaritimeWaste e) => e.toXml()).toList(),
      ballastWaterSummary?.toXml(),
      iSPSRequirements?.toXml(),
      maritimeHealthDeclaration?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'OnCarriageShipmentStage',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

