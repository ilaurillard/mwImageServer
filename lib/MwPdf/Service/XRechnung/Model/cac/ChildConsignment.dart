import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cbc/CarrierAssignedID.dart';
import '../cbc/ConsigneeAssignedID.dart';
import '../cbc/ConsignorAssignedID.dart';
import '../cbc/FreightForwarderAssignedID.dart';
import '../cbc/BrokerAssignedID.dart';
import '../cbc/ContractedCarrierAssignedID.dart';
import '../cbc/PerformingCarrierAssignedID.dart';
import '../cbc/SummaryDescription.dart';
import '../cbc/TotalInvoiceAmount.dart';
import '../cbc/DeclaredCustomsValueAmount.dart';
import '../cbc/TariffDescription.dart';
import '../cbc/TariffCode.dart';
import '../cbc/InsurancePremiumAmount.dart';
import '../cbc/GrossWeightMeasure.dart';
import '../cbc/NetWeightMeasure.dart';
import '../cbc/NetNetWeightMeasure.dart';
import '../cbc/ChargeableWeightMeasure.dart';
import '../cbc/GrossVolumeMeasure.dart';
import '../cbc/NetVolumeMeasure.dart';
import '../cbc/LoadingLengthMeasure.dart';
import '../cbc/Remarks.dart';
import '../cbc/HazardousRiskIndicator.dart';
import '../cbc/AnimalFoodIndicator.dart';
import '../cbc/HumanFoodIndicator.dart';
import '../cbc/LivestockIndicator.dart';
import '../cbc/BulkCargoIndicator.dart';
import '../cbc/ContainerizedIndicator.dart';
import '../cbc/GeneralCargoIndicator.dart';
import '../cbc/SpecialSecurityIndicator.dart';
import '../cbc/ThirdPartyPayerIndicator.dart';
import '../cbc/CarrierServiceInstructions.dart';
import '../cbc/CustomsClearanceServiceInstructions.dart';
import '../cbc/ForwarderServiceInstructions.dart';
import '../cbc/SpecialServiceInstructions.dart';
import '../cbc/SequenceID.dart';
import '../cbc/ShippingPriorityLevelCode.dart';
import '../cbc/HandlingCode.dart';
import '../cbc/HandlingInstructions.dart';
import '../cbc/Information.dart';
import '../cbc/TotalGoodsItemQuantity.dart';
import '../cbc/TotalTransportHandlingUnitQuantity.dart';
import '../cbc/InsuranceValueAmount.dart';
import '../cbc/DeclaredForCarriageValueAmount.dart';
import '../cbc/DeclaredStatisticsValueAmount.dart';
import '../cbc/FreeOnBoardValueAmount.dart';
import '../cbc/SpecialInstructions.dart';
import '../cbc/SplitConsignmentIndicator.dart';
import '../cbc/DeliveryInstructions.dart';
import '../cbc/ConsignmentQuantity.dart';
import '../cbc/ConsolidatableIndicator.dart';
import '../cbc/HaulageInstructions.dart';
import '../cbc/LoadingSequenceID.dart';
import '../cbc/ChildConsignmentQuantity.dart';
import '../cbc/TotalPackagesQuantity.dart';
import '../cac/ConsolidatedShipment.dart';
import '../cac/CustomsDeclaration.dart';
import '../cac/RequestedPickupTransportEvent.dart';
import '../cac/RequestedDeliveryTransportEvent.dart';
import '../cac/PlannedPickupTransportEvent.dart';
import '../cac/PlannedDeliveryTransportEvent.dart';
import '../cac/Status.dart';
import '../cac/ConsigneeParty.dart';
import '../cac/ExporterParty.dart';
import '../cac/ConsignorParty.dart';
import '../cac/ImporterParty.dart';
import '../cac/CarrierParty.dart';
import '../cac/FreightForwarderParty.dart';
import '../cac/NotifyParty.dart';
import '../cac/OriginalDespatchParty.dart';
import '../cac/FinalDeliveryParty.dart';
import '../cac/PerformingCarrierParty.dart';
import '../cac/SubstituteCarrierParty.dart';
import '../cac/LogisticsOperatorParty.dart';
import '../cac/TransportAdvisorParty.dart';
import '../cac/HazardousItemNotificationParty.dart';
import '../cac/InsuranceParty.dart';
import '../cac/MortgageHolderParty.dart';
import '../cac/BillOfLadingHolderParty.dart';
import '../cac/OriginalDepartureCountry.dart';
import '../cac/FinalDestinationCountry.dart';
import '../cac/TransitCountry.dart';
import '../cac/TransportContract.dart';
import '../cac/TransportEvent.dart';
import '../cac/OriginalDespatchTransportationService.dart';
import '../cac/FinalDeliveryTransportationService.dart';
import '../cac/DeliveryTerms.dart';
import '../cac/PaymentTerms.dart';
import '../cac/CollectPaymentTerms.dart';
import '../cac/DisbursementPaymentTerms.dart';
import '../cac/PrepaidPaymentTerms.dart';
import '../cac/FreightAllowanceCharge.dart';
import '../cac/ExtraAllowanceCharge.dart';
import '../cac/MainCarriageShipmentStage.dart';
import '../cac/PreCarriageShipmentStage.dart';
import '../cac/OnCarriageShipmentStage.dart';
import '../cac/TransportHandlingUnit.dart';
import '../cac/FirstArrivalPortLocation.dart';
import '../cac/LastExitPortLocation.dart';

// A class to describe an identifiable collection of one or more goods items to be transported between the consignor and the consignee. This information may be defined within a transport contract. A consignment may comprise more than one shipment (e.g., when consolidated by a freight forwarder).
class ChildConsignment {


  // An identifier assigned to a collection of goods for both import and export.
  final ID iD;

  // An identifier for this consignment, assigned by the carrier.
  final CarrierAssignedID? carrierAssignedID;

  // An identifier for this consignment, assigned by the consignee.
  final ConsigneeAssignedID? consigneeAssignedID;

  // An identifier for this consignment, assigned by the consignor.
  final ConsignorAssignedID? consignorAssignedID;

  // An identifier for this consignment, assigned by the freight forwarder.
  final FreightForwarderAssignedID? freightForwarderAssignedID;

  // An identifier for this consignment, assigned by the broker.
  final BrokerAssignedID? brokerAssignedID;

  // An identifier for this consignment, assigned by the contracted carrier.
  final ContractedCarrierAssignedID? contractedCarrierAssignedID;

  // An identifier for this consignment, assigned by the performing carrier.
  final PerformingCarrierAssignedID? performingCarrierAssignedID;

  // A textual summary description of the consignment.
  final List<SummaryDescription> summaryDescription;

  // The total of all invoice amounts declared in this consignment.
  final TotalInvoiceAmount? totalInvoiceAmount;

  // The total declared value for customs purposes of all the goods in this consignment, regardless of whether they are subject to the same customs procedure, tariff/statistical categorization, country information, or duty regime.
  final DeclaredCustomsValueAmount? declaredCustomsValueAmount;

  // Text describing the tariff applied to this consignment.
  final List<TariffDescription> tariffDescription;

  // A code signifying the tariff applied to this consignment.
  final TariffCode? tariffCode;

  // The amount of the premium payable to an insurance company for insuring the goods contained in this consignment.
  final InsurancePremiumAmount? insurancePremiumAmount;

  // The total declared weight of the goods in this consignment, including packaging but excluding the carrier's equipment.
  final GrossWeightMeasure? grossWeightMeasure;

  // The total net weight of all the goods items referred to as one consignment.
  final NetWeightMeasure? netWeightMeasure;

  // The total net weight of the goods in this consignment, exclusive of packaging.
  final NetNetWeightMeasure? netNetWeightMeasure;

  // The weight upon which a charge is to be based.
  final ChargeableWeightMeasure? chargeableWeightMeasure;

  // The total volume of the goods referred to as one consignment.
  final GrossVolumeMeasure? grossVolumeMeasure;

  // The total net volume of all goods items referred to as one consignment.
  final NetVolumeMeasure? netVolumeMeasure;

  // The total length in a means of transport or a piece of transport equipment which, given the width and height of the transport means, will accommodate all of the consignments in a single consolidation.
  final LoadingLengthMeasure? loadingLengthMeasure;

  // Remarks concerning the complete consignment, to be printed on the transport document.
  final List<Remarks> remarks;

  // An indication that the transported goods in this consignment are subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  // An indication that the transported goods in this consignment are animal foodstuffs (true) or not (false).
  final AnimalFoodIndicator? animalFoodIndicator;

  // An indication that the transported goods in this consignment are for human consumption (true) or not (false).
  final HumanFoodIndicator? humanFoodIndicator;

  // An indication that the transported goods are livestock (true) or not (false).
  final LivestockIndicator? livestockIndicator;

  // An indication that the transported goods in this consignment are bulk cargoes (true) or not (false).
  final BulkCargoIndicator? bulkCargoIndicator;

  // An indication that the transported goods in this consignment are containerized cargoes (true) or not (false).
  final ContainerizedIndicator? containerizedIndicator;

  // An indication that the transported goods in this consignment are general cargoes (true) or not (false).
  final GeneralCargoIndicator? generalCargoIndicator;

  // An indication that the transported goods in this consignment require special security (true) or not (false).
  final SpecialSecurityIndicator? specialSecurityIndicator;

  // An indication that this consignment will be paid for by a third party (true) or not (false).
  final ThirdPartyPayerIndicator? thirdPartyPayerIndicator;

  // Service instructions to the carrier, expressed as text.
  final List<CarrierServiceInstructions> carrierServiceInstructions;

  // Service instructions for customs clearance, expressed as text.
  final List<CustomsClearanceServiceInstructions> customsClearanceServiceInstructions;

  // Service instructions for the forwarder, expressed as text.
  final List<ForwarderServiceInstructions> forwarderServiceInstructions;

  // Special service instructions, expressed as text.
  final List<SpecialServiceInstructions> specialServiceInstructions;

  // A sequence identifier for this consignment.
  final SequenceID? sequenceID;

  // A code signifying the priority or level of service required for this consignment.
  final ShippingPriorityLevelCode? shippingPriorityLevelCode;

  // The handling required for this consignment, expressed as a code.
  final HandlingCode? handlingCode;

  // The handling required for this consignment, expressed as text.
  final List<HandlingInstructions> handlingInstructions;

  // Free-form text pertinent to this consignment, conveying information that is not contained explicitly in other structures.
  final List<Information> information;

  // The total number of goods items in this consignment.
  final TotalGoodsItemQuantity? totalGoodsItemQuantity;

  // The number of pieces of transport handling equipment (pallets, boxes, cases, etc.) in this consignment.
  final TotalTransportHandlingUnitQuantity? totalTransportHandlingUnitQuantity;

  // The amount covered by insurance for this consignment.
  final InsuranceValueAmount? insuranceValueAmount;

  // The value of this consignment, declared by the shipper or his agent solely for the purpose of varying the carrier's level of liability from that provided in the contract of carriage, in case of loss or damage to goods or delayed delivery.
  final DeclaredForCarriageValueAmount? declaredForCarriageValueAmount;

  // The value, declared for statistical purposes, of those goods in this consignment that have the same statistical heading.
  final DeclaredStatisticsValueAmount? declaredStatisticsValueAmount;

  // The monetary amount that has to be or has been paid as calculated under the applicable trade delivery.
  final FreeOnBoardValueAmount? freeOnBoardValueAmount;

  // Special instructions relating to this consignment.
  final List<SpecialInstructions> specialInstructions;

  // An indicator that this consignment has been split in transit (true) or not (false).
  final SplitConsignmentIndicator? splitConsignmentIndicator;

  // A set of delivery instructions relating to this consignment.
  final List<DeliveryInstructions> deliveryInstructions;

  // The count in this consignment considering goods items, child consignments, shipments
  final ConsignmentQuantity? consignmentQuantity;

  // An indicator that this consignment can be consolidated (true) or not (false).
  final ConsolidatableIndicator? consolidatableIndicator;

  // Instructions regarding haulage of this consignment, expressed as text.
  final List<HaulageInstructions> haulageInstructions;

  // An identifier for the loading sequence of this consignment.
  final LoadingSequenceID? loadingSequenceID;

  // The quantity of (consolidated) child consignments
  final ChildConsignmentQuantity? childConsignmentQuantity;

  // The total number of packages associated with a Consignment.
  final TotalPackagesQuantity? totalPackagesQuantity;

  // A consolidated shipment (a shipment created by an act of consolidation).
  final List<ConsolidatedShipment> consolidatedShipment;

  // A class describing identifiers or references relating to customs procedures.
  final List<CustomsDeclaration> customsDeclaration;

  // The pickup of this consignment requested by the party requesting a transportation service (the transport user).
  final RequestedPickupTransportEvent? requestedPickupTransportEvent;

  // The delivery of this consignment requested by the party requesting a transportation service (the transport user).
  final RequestedDeliveryTransportEvent? requestedDeliveryTransportEvent;

  // The pickup of this consignment planned by the party responsible for providing the transportation service (the transport service provider).
  final PlannedPickupTransportEvent? plannedPickupTransportEvent;

  // The delivery of this consignment planned by the party responsible for providing the transportation service (the transport service provider).
  final PlannedDeliveryTransportEvent? plannedDeliveryTransportEvent;

  // The status of a particular condition associated with this consignment.
  final List<Status> status;

  // One of the child consignments of which a consolidated consignment is composed.
  final List<ChildConsignment> childConsignment;

  // A party to which goods are consigned.
  final ConsigneeParty? consigneeParty;

  // The party that makes the export declaration, or on behalf of which the export declaration is made, and that is the owner of the goods in this consignment or has similar right of disposal over them at the time when the declaration is accepted.
  final ExporterParty? exporterParty;

  // The party consigning goods, as stipulated in the transport contract by the party ordering transport.
  final ConsignorParty? consignorParty;

  // The party that makes an import declaration regarding this consignment, or on behalf of which a customs clearing agent or other authorized person makes an import declaration regarding this consignment. This may include a person who has possession of the goods or to whom the goods are consigned.
  final ImporterParty? importerParty;

  // The party providing the transport of goods in this consignment between named points.
  final CarrierParty? carrierParty;

  // The party combining individual smaller consignments into a single larger shipment (the consolidated shipment), which is sent to a counterpart that mirrors the consolidator's activity by dividing the consolidated consignment into its original components.
  final FreightForwarderParty? freightForwarderParty;

  // The party to be notified upon arrival of goods and when special occurrences (usually pre-defined) take place during a transportation service.
  final NotifyParty? notifyParty;

  // The original despatch (sender) party for this consignment.
  final OriginalDespatchParty? originalDespatchParty;

  // The final delivery party for this consignment.
  final FinalDeliveryParty? finalDeliveryParty;

  // The party performing the carriage of this consignment.
  final PerformingCarrierParty? performingCarrierParty;

  // A substitute party performing the carriage of this consignment.
  final SubstituteCarrierParty? substituteCarrierParty;

  // The logistics operator party for this consignment.
  final LogisticsOperatorParty? logisticsOperatorParty;

  // The party providing transport advice this consignment.
  final TransportAdvisorParty? transportAdvisorParty;

  // The party that would be notified of a hazardous item in this consignment.
  final HazardousItemNotificationParty? hazardousItemNotificationParty;

  // The party holding the insurance for this consignment.
  final InsuranceParty? insuranceParty;

  // The party holding the mortgage for this consignment.
  final MortgageHolderParty? mortgageHolderParty;

  // The party holding the bill of lading for this consignment.
  final BillOfLadingHolderParty? billOfLadingHolderParty;

  // The country from which the goods in this consignment were originally exported, without any commercial transaction taking place in intermediate countries.
  final OriginalDepartureCountry? originalDepartureCountry;

  // The country in which the goods in this consignment are to be delivered to the final consignee or buyer.
  final FinalDestinationCountry? finalDestinationCountry;

  // One of the countries through which goods or passengers in this consignment are routed between the country of original departure and the country of final destination.
  final List<TransitCountry> transitCountry;

  // A transport contract relating to this consignment.
  final TransportContract? transportContract;

  // A class describing a significant occurrence or happening related to the transportation of goods.
  final List<TransportEvent> transportEvent;

  // The service for pickup from the consignor under the transport contract for this consignment.
  final OriginalDespatchTransportationService? originalDespatchTransportationService;

  // The service for delivery to the consignee under the transport contract for this consignment.
  final FinalDeliveryTransportationService? finalDeliveryTransportationService;

  // The conditions agreed upon between a seller and a buyer with regard to the delivery of goods and/or services (e.g., CIF, FOB, or EXW from the INCOTERMS Terms of Delivery).
  final DeliveryTerms? deliveryTerms;

  // The terms of payment between the parties (such as logistics service client, logistics service provider) in a transaction.
  final PaymentTerms? paymentTerms;

  // The terms of payment that apply to the collection of this consignment.
  final CollectPaymentTerms? collectPaymentTerms;

  // The terms of payment for disbursement.
  final DisbursementPaymentTerms? disbursementPaymentTerms;

  // The terms of payment for prepayment.
  final PrepaidPaymentTerms? prepaidPaymentTerms;

  // A cost incurred by the shipper in moving goods, by whatever means, from one place to another under the terms of the contract of carriage for this consignment. In addition to transport costs, this may include such elements as packing, documentation, loading, unloading, and insurance to the extent that they relate to the freight costs.
  final List<FreightAllowanceCharge> freightAllowanceCharge;

  // A charge for extra allowance.
  final List<ExtraAllowanceCharge> extraAllowanceCharge;

  // A shipment stage during main carriage.
  final List<MainCarriageShipmentStage> mainCarriageShipmentStage;

  // A shipment stage during precarriage (usually refers to movement activity that takes place prior to the container being loaded at a port of loading).
  final List<PreCarriageShipmentStage> preCarriageShipmentStage;

  // A shipment stage during on-carriage (usually refers to movement activity that takes place after the container is discharged at a port of discharge).
  final List<OnCarriageShipmentStage> onCarriageShipmentStage;

  // A transport handling unit used for loose and containerized goods.
  final List<TransportHandlingUnit> transportHandlingUnit;

  // The first arrival location in a transport. This would be a port for sea, an airport for air, a terminal for rail, or a border post for land crossing.
  final FirstArrivalPortLocation? firstArrivalPortLocation;

  // The final exporting location in a transport. This would be a port for sea, an airport for air, a terminal for rail, or a border post for land crossing.
  final LastExitPortLocation? lastExitPortLocation;

  ChildConsignment ({
    required this.iD,
    this.carrierAssignedID,
    this.consigneeAssignedID,
    this.consignorAssignedID,
    this.freightForwarderAssignedID,
    this.brokerAssignedID,
    this.contractedCarrierAssignedID,
    this.performingCarrierAssignedID,
    this.summaryDescription = const [],
    this.totalInvoiceAmount,
    this.declaredCustomsValueAmount,
    this.tariffDescription = const [],
    this.tariffCode,
    this.insurancePremiumAmount,
    this.grossWeightMeasure,
    this.netWeightMeasure,
    this.netNetWeightMeasure,
    this.chargeableWeightMeasure,
    this.grossVolumeMeasure,
    this.netVolumeMeasure,
    this.loadingLengthMeasure,
    this.remarks = const [],
    this.hazardousRiskIndicator,
    this.animalFoodIndicator,
    this.humanFoodIndicator,
    this.livestockIndicator,
    this.bulkCargoIndicator,
    this.containerizedIndicator,
    this.generalCargoIndicator,
    this.specialSecurityIndicator,
    this.thirdPartyPayerIndicator,
    this.carrierServiceInstructions = const [],
    this.customsClearanceServiceInstructions = const [],
    this.forwarderServiceInstructions = const [],
    this.specialServiceInstructions = const [],
    this.sequenceID,
    this.shippingPriorityLevelCode,
    this.handlingCode,
    this.handlingInstructions = const [],
    this.information = const [],
    this.totalGoodsItemQuantity,
    this.totalTransportHandlingUnitQuantity,
    this.insuranceValueAmount,
    this.declaredForCarriageValueAmount,
    this.declaredStatisticsValueAmount,
    this.freeOnBoardValueAmount,
    this.specialInstructions = const [],
    this.splitConsignmentIndicator,
    this.deliveryInstructions = const [],
    this.consignmentQuantity,
    this.consolidatableIndicator,
    this.haulageInstructions = const [],
    this.loadingSequenceID,
    this.childConsignmentQuantity,
    this.totalPackagesQuantity,
    this.consolidatedShipment = const [],
    this.customsDeclaration = const [],
    this.requestedPickupTransportEvent,
    this.requestedDeliveryTransportEvent,
    this.plannedPickupTransportEvent,
    this.plannedDeliveryTransportEvent,
    this.status = const [],
    this.childConsignment = const [],
    this.consigneeParty,
    this.exporterParty,
    this.consignorParty,
    this.importerParty,
    this.carrierParty,
    this.freightForwarderParty,
    this.notifyParty,
    this.originalDespatchParty,
    this.finalDeliveryParty,
    this.performingCarrierParty,
    this.substituteCarrierParty,
    this.logisticsOperatorParty,
    this.transportAdvisorParty,
    this.hazardousItemNotificationParty,
    this.insuranceParty,
    this.mortgageHolderParty,
    this.billOfLadingHolderParty,
    this.originalDepartureCountry,
    this.finalDestinationCountry,
    this.transitCountry = const [],
    this.transportContract,
    this.transportEvent = const [],
    this.originalDespatchTransportationService,
    this.finalDeliveryTransportationService,
    this.deliveryTerms,
    this.paymentTerms,
    this.collectPaymentTerms,
    this.disbursementPaymentTerms,
    this.prepaidPaymentTerms,
    this.freightAllowanceCharge = const [],
    this.extraAllowanceCharge = const [],
    this.mainCarriageShipmentStage = const [],
    this.preCarriageShipmentStage = const [],
    this.onCarriageShipmentStage = const [],
    this.transportHandlingUnit = const [],
    this.firstArrivalPortLocation,
    this.lastExitPortLocation,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD.toJson(),
     'carrierAssignedID': carrierAssignedID?.toJson(),
     'consigneeAssignedID': consigneeAssignedID?.toJson(),
     'consignorAssignedID': consignorAssignedID?.toJson(),
     'freightForwarderAssignedID': freightForwarderAssignedID?.toJson(),
     'brokerAssignedID': brokerAssignedID?.toJson(),
     'contractedCarrierAssignedID': contractedCarrierAssignedID?.toJson(),
     'performingCarrierAssignedID': performingCarrierAssignedID?.toJson(),
     'summaryDescription': summaryDescription.map((e) => e.toJson()).toList(),
     'totalInvoiceAmount': totalInvoiceAmount?.toJson(),
     'declaredCustomsValueAmount': declaredCustomsValueAmount?.toJson(),
     'tariffDescription': tariffDescription.map((e) => e.toJson()).toList(),
     'tariffCode': tariffCode?.toJson(),
     'insurancePremiumAmount': insurancePremiumAmount?.toJson(),
     'grossWeightMeasure': grossWeightMeasure?.toJson(),
     'netWeightMeasure': netWeightMeasure?.toJson(),
     'netNetWeightMeasure': netNetWeightMeasure?.toJson(),
     'chargeableWeightMeasure': chargeableWeightMeasure?.toJson(),
     'grossVolumeMeasure': grossVolumeMeasure?.toJson(),
     'netVolumeMeasure': netVolumeMeasure?.toJson(),
     'loadingLengthMeasure': loadingLengthMeasure?.toJson(),
     'remarks': remarks.map((e) => e.toJson()).toList(),
     'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
     'animalFoodIndicator': animalFoodIndicator?.toJson(),
     'humanFoodIndicator': humanFoodIndicator?.toJson(),
     'livestockIndicator': livestockIndicator?.toJson(),
     'bulkCargoIndicator': bulkCargoIndicator?.toJson(),
     'containerizedIndicator': containerizedIndicator?.toJson(),
     'generalCargoIndicator': generalCargoIndicator?.toJson(),
     'specialSecurityIndicator': specialSecurityIndicator?.toJson(),
     'thirdPartyPayerIndicator': thirdPartyPayerIndicator?.toJson(),
     'carrierServiceInstructions': carrierServiceInstructions.map((e) => e.toJson()).toList(),
     'customsClearanceServiceInstructions': customsClearanceServiceInstructions.map((e) => e.toJson()).toList(),
     'forwarderServiceInstructions': forwarderServiceInstructions.map((e) => e.toJson()).toList(),
     'specialServiceInstructions': specialServiceInstructions.map((e) => e.toJson()).toList(),
     'sequenceID': sequenceID?.toJson(),
     'shippingPriorityLevelCode': shippingPriorityLevelCode?.toJson(),
     'handlingCode': handlingCode?.toJson(),
     'handlingInstructions': handlingInstructions.map((e) => e.toJson()).toList(),
     'information': information.map((e) => e.toJson()).toList(),
     'totalGoodsItemQuantity': totalGoodsItemQuantity?.toJson(),
     'totalTransportHandlingUnitQuantity': totalTransportHandlingUnitQuantity?.toJson(),
     'insuranceValueAmount': insuranceValueAmount?.toJson(),
     'declaredForCarriageValueAmount': declaredForCarriageValueAmount?.toJson(),
     'declaredStatisticsValueAmount': declaredStatisticsValueAmount?.toJson(),
     'freeOnBoardValueAmount': freeOnBoardValueAmount?.toJson(),
     'specialInstructions': specialInstructions.map((e) => e.toJson()).toList(),
     'splitConsignmentIndicator': splitConsignmentIndicator?.toJson(),
     'deliveryInstructions': deliveryInstructions.map((e) => e.toJson()).toList(),
     'consignmentQuantity': consignmentQuantity?.toJson(),
     'consolidatableIndicator': consolidatableIndicator?.toJson(),
     'haulageInstructions': haulageInstructions.map((e) => e.toJson()).toList(),
     'loadingSequenceID': loadingSequenceID?.toJson(),
     'childConsignmentQuantity': childConsignmentQuantity?.toJson(),
     'totalPackagesQuantity': totalPackagesQuantity?.toJson(),
     'consolidatedShipment': consolidatedShipment.map((e) => e.toJson()).toList(),
     'customsDeclaration': customsDeclaration.map((e) => e.toJson()).toList(),
     'requestedPickupTransportEvent': requestedPickupTransportEvent?.toJson(),
     'requestedDeliveryTransportEvent': requestedDeliveryTransportEvent?.toJson(),
     'plannedPickupTransportEvent': plannedPickupTransportEvent?.toJson(),
     'plannedDeliveryTransportEvent': plannedDeliveryTransportEvent?.toJson(),
     'status': status.map((e) => e.toJson()).toList(),
     'childConsignment': childConsignment.map((e) => e.toJson()).toList(),
     'consigneeParty': consigneeParty?.toJson(),
     'exporterParty': exporterParty?.toJson(),
     'consignorParty': consignorParty?.toJson(),
     'importerParty': importerParty?.toJson(),
     'carrierParty': carrierParty?.toJson(),
     'freightForwarderParty': freightForwarderParty?.toJson(),
     'notifyParty': notifyParty?.toJson(),
     'originalDespatchParty': originalDespatchParty?.toJson(),
     'finalDeliveryParty': finalDeliveryParty?.toJson(),
     'performingCarrierParty': performingCarrierParty?.toJson(),
     'substituteCarrierParty': substituteCarrierParty?.toJson(),
     'logisticsOperatorParty': logisticsOperatorParty?.toJson(),
     'transportAdvisorParty': transportAdvisorParty?.toJson(),
     'hazardousItemNotificationParty': hazardousItemNotificationParty?.toJson(),
     'insuranceParty': insuranceParty?.toJson(),
     'mortgageHolderParty': mortgageHolderParty?.toJson(),
     'billOfLadingHolderParty': billOfLadingHolderParty?.toJson(),
     'originalDepartureCountry': originalDepartureCountry?.toJson(),
     'finalDestinationCountry': finalDestinationCountry?.toJson(),
     'transitCountry': transitCountry.map((e) => e.toJson()).toList(),
     'transportContract': transportContract?.toJson(),
     'transportEvent': transportEvent.map((e) => e.toJson()).toList(),
     'originalDespatchTransportationService': originalDespatchTransportationService?.toJson(),
     'finalDeliveryTransportationService': finalDeliveryTransportationService?.toJson(),
     'deliveryTerms': deliveryTerms?.toJson(),
     'paymentTerms': paymentTerms?.toJson(),
     'collectPaymentTerms': collectPaymentTerms?.toJson(),
     'disbursementPaymentTerms': disbursementPaymentTerms?.toJson(),
     'prepaidPaymentTerms': prepaidPaymentTerms?.toJson(),
     'freightAllowanceCharge': freightAllowanceCharge.map((e) => e.toJson()).toList(),
     'extraAllowanceCharge': extraAllowanceCharge.map((e) => e.toJson()).toList(),
     'mainCarriageShipmentStage': mainCarriageShipmentStage.map((e) => e.toJson()).toList(),
     'preCarriageShipmentStage': preCarriageShipmentStage.map((e) => e.toJson()).toList(),
     'onCarriageShipmentStage': onCarriageShipmentStage.map((e) => e.toJson()).toList(),
     'transportHandlingUnit': transportHandlingUnit.map((e) => e.toJson()).toList(),
     'firstArrivalPortLocation': firstArrivalPortLocation?.toJson(),
     'lastExitPortLocation': lastExitPortLocation?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ChildConsignment fromJson(Map<String, dynamic> json) {
    return ChildConsignment (
    );
  }

}

