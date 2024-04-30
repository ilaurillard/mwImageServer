import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
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
import '../cac/ActualPickupTransportEvent.dart';
import '../cac/ActualDeliveryTransportEvent.dart';
import '../cac/Status.dart';
import '../cac/ChildConsignment.dart';
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
import '../cac/OfficeOfEntryLocation.dart';
import '../cac/OfficeOfSubSequentiallyEntryLocation.dart';
import '../cac/OfficeOfExitLocation.dart';
import '../cac/OfficeOfDepartureLocation.dart';
import '../cac/OfficeOfDestinationLocation.dart';
import '../cac/OfficeOfImportLocation.dart';
import '../cac/OfficeOfExportLocation.dart';
import '../cac/DocumentReference.dart';

// A class to describe an identifiable collection of one or more goods items to be transported between the consignor and the consignee. This information may be defined within a transport contract. A consignment may comprise more than one shipment (e.g., when consolidated by a freight forwarder).
class Consignment {


  // An identifier assigned to a collection of goods for both import and export.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // The actual pickup of this consignment by the party responsible for providing the transportation service (the transport service provider).
  final ActualPickupTransportEvent? actualPickupTransportEvent;

  // The actual delivery of this consignment by the party responsible for providing the transportation service (the transport service provider).
  final ActualDeliveryTransportEvent? actualDeliveryTransportEvent;

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

  // The location of the office of entry of this consignment.
  final OfficeOfEntryLocation? officeOfEntryLocation;

  // The location of the office of the subsequentially entry of this consignment.
  final OfficeOfSubSequentiallyEntryLocation? officeOfSubSequentiallyEntryLocation;

  // The location of the office of exit of this consignment.
  final OfficeOfExitLocation? officeOfExitLocation;

  // The location of the office of departure of this consignment.
  final OfficeOfDepartureLocation? officeOfDepartureLocation;

  // The location of the office of destination of this consignment.
  final OfficeOfDestinationLocation? officeOfDestinationLocation;

  // The location of the office of import of this consignment.
  final OfficeOfImportLocation? officeOfImportLocation;

  // The location of the office of export of this consignment.
  final OfficeOfExportLocation? officeOfExportLocation;

  // A reference to a document related to or relevant for this consignment.
  final List<DocumentReference> documentReference;

  Consignment ({
    required this.iD,
    this.uBLExtensions,
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
    this.actualPickupTransportEvent,
    this.actualDeliveryTransportEvent,
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
    this.officeOfEntryLocation,
    this.officeOfSubSequentiallyEntryLocation,
    this.officeOfExitLocation,
    this.officeOfDepartureLocation,
    this.officeOfDestinationLocation,
    this.officeOfImportLocation,
    this.officeOfExportLocation,
    this.documentReference = const [],
  });

  static Consignment? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Consignment (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      carrierAssignedID: CarrierAssignedID.fromJson(json['carrierAssignedID'] as Map<String, dynamic>?),
      consigneeAssignedID: ConsigneeAssignedID.fromJson(json['consigneeAssignedID'] as Map<String, dynamic>?),
      consignorAssignedID: ConsignorAssignedID.fromJson(json['consignorAssignedID'] as Map<String, dynamic>?),
      freightForwarderAssignedID: FreightForwarderAssignedID.fromJson(json['freightForwarderAssignedID'] as Map<String, dynamic>?),
      brokerAssignedID: BrokerAssignedID.fromJson(json['brokerAssignedID'] as Map<String, dynamic>?),
      contractedCarrierAssignedID: ContractedCarrierAssignedID.fromJson(json['contractedCarrierAssignedID'] as Map<String, dynamic>?),
      performingCarrierAssignedID: PerformingCarrierAssignedID.fromJson(json['performingCarrierAssignedID'] as Map<String, dynamic>?),
      summaryDescription: (json['summaryDescription'] as List? ?? []).map((dynamic d) => SummaryDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      totalInvoiceAmount: TotalInvoiceAmount.fromJson(json['totalInvoiceAmount'] as Map<String, dynamic>?),
      declaredCustomsValueAmount: DeclaredCustomsValueAmount.fromJson(json['declaredCustomsValueAmount'] as Map<String, dynamic>?),
      tariffDescription: (json['tariffDescription'] as List? ?? []).map((dynamic d) => TariffDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      tariffCode: TariffCode.fromJson(json['tariffCode'] as Map<String, dynamic>?),
      insurancePremiumAmount: InsurancePremiumAmount.fromJson(json['insurancePremiumAmount'] as Map<String, dynamic>?),
      grossWeightMeasure: GrossWeightMeasure.fromJson(json['grossWeightMeasure'] as Map<String, dynamic>?),
      netWeightMeasure: NetWeightMeasure.fromJson(json['netWeightMeasure'] as Map<String, dynamic>?),
      netNetWeightMeasure: NetNetWeightMeasure.fromJson(json['netNetWeightMeasure'] as Map<String, dynamic>?),
      chargeableWeightMeasure: ChargeableWeightMeasure.fromJson(json['chargeableWeightMeasure'] as Map<String, dynamic>?),
      grossVolumeMeasure: GrossVolumeMeasure.fromJson(json['grossVolumeMeasure'] as Map<String, dynamic>?),
      netVolumeMeasure: NetVolumeMeasure.fromJson(json['netVolumeMeasure'] as Map<String, dynamic>?),
      loadingLengthMeasure: LoadingLengthMeasure.fromJson(json['loadingLengthMeasure'] as Map<String, dynamic>?),
      remarks: (json['remarks'] as List? ?? []).map((dynamic d) => Remarks.fromJson(d as Map<String, dynamic>?)!).toList(),
      hazardousRiskIndicator: HazardousRiskIndicator.fromJson(json['hazardousRiskIndicator'] as Map<String, dynamic>?),
      animalFoodIndicator: AnimalFoodIndicator.fromJson(json['animalFoodIndicator'] as Map<String, dynamic>?),
      humanFoodIndicator: HumanFoodIndicator.fromJson(json['humanFoodIndicator'] as Map<String, dynamic>?),
      livestockIndicator: LivestockIndicator.fromJson(json['livestockIndicator'] as Map<String, dynamic>?),
      bulkCargoIndicator: BulkCargoIndicator.fromJson(json['bulkCargoIndicator'] as Map<String, dynamic>?),
      containerizedIndicator: ContainerizedIndicator.fromJson(json['containerizedIndicator'] as Map<String, dynamic>?),
      generalCargoIndicator: GeneralCargoIndicator.fromJson(json['generalCargoIndicator'] as Map<String, dynamic>?),
      specialSecurityIndicator: SpecialSecurityIndicator.fromJson(json['specialSecurityIndicator'] as Map<String, dynamic>?),
      thirdPartyPayerIndicator: ThirdPartyPayerIndicator.fromJson(json['thirdPartyPayerIndicator'] as Map<String, dynamic>?),
      carrierServiceInstructions: (json['carrierServiceInstructions'] as List? ?? []).map((dynamic d) => CarrierServiceInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      customsClearanceServiceInstructions: (json['customsClearanceServiceInstructions'] as List? ?? []).map((dynamic d) => CustomsClearanceServiceInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      forwarderServiceInstructions: (json['forwarderServiceInstructions'] as List? ?? []).map((dynamic d) => ForwarderServiceInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      specialServiceInstructions: (json['specialServiceInstructions'] as List? ?? []).map((dynamic d) => SpecialServiceInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      sequenceID: SequenceID.fromJson(json['sequenceID'] as Map<String, dynamic>?),
      shippingPriorityLevelCode: ShippingPriorityLevelCode.fromJson(json['shippingPriorityLevelCode'] as Map<String, dynamic>?),
      handlingCode: HandlingCode.fromJson(json['handlingCode'] as Map<String, dynamic>?),
      handlingInstructions: (json['handlingInstructions'] as List? ?? []).map((dynamic d) => HandlingInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      information: (json['information'] as List? ?? []).map((dynamic d) => Information.fromJson(d as Map<String, dynamic>?)!).toList(),
      totalGoodsItemQuantity: TotalGoodsItemQuantity.fromJson(json['totalGoodsItemQuantity'] as Map<String, dynamic>?),
      totalTransportHandlingUnitQuantity: TotalTransportHandlingUnitQuantity.fromJson(json['totalTransportHandlingUnitQuantity'] as Map<String, dynamic>?),
      insuranceValueAmount: InsuranceValueAmount.fromJson(json['insuranceValueAmount'] as Map<String, dynamic>?),
      declaredForCarriageValueAmount: DeclaredForCarriageValueAmount.fromJson(json['declaredForCarriageValueAmount'] as Map<String, dynamic>?),
      declaredStatisticsValueAmount: DeclaredStatisticsValueAmount.fromJson(json['declaredStatisticsValueAmount'] as Map<String, dynamic>?),
      freeOnBoardValueAmount: FreeOnBoardValueAmount.fromJson(json['freeOnBoardValueAmount'] as Map<String, dynamic>?),
      specialInstructions: (json['specialInstructions'] as List? ?? []).map((dynamic d) => SpecialInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      splitConsignmentIndicator: SplitConsignmentIndicator.fromJson(json['splitConsignmentIndicator'] as Map<String, dynamic>?),
      deliveryInstructions: (json['deliveryInstructions'] as List? ?? []).map((dynamic d) => DeliveryInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      consignmentQuantity: ConsignmentQuantity.fromJson(json['consignmentQuantity'] as Map<String, dynamic>?),
      consolidatableIndicator: ConsolidatableIndicator.fromJson(json['consolidatableIndicator'] as Map<String, dynamic>?),
      haulageInstructions: (json['haulageInstructions'] as List? ?? []).map((dynamic d) => HaulageInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      loadingSequenceID: LoadingSequenceID.fromJson(json['loadingSequenceID'] as Map<String, dynamic>?),
      childConsignmentQuantity: ChildConsignmentQuantity.fromJson(json['childConsignmentQuantity'] as Map<String, dynamic>?),
      totalPackagesQuantity: TotalPackagesQuantity.fromJson(json['totalPackagesQuantity'] as Map<String, dynamic>?),
      consolidatedShipment: (json['consolidatedShipment'] as List? ?? []).map((dynamic d) => ConsolidatedShipment.fromJson(d as Map<String, dynamic>?)!).toList(),
      customsDeclaration: (json['customsDeclaration'] as List? ?? []).map((dynamic d) => CustomsDeclaration.fromJson(d as Map<String, dynamic>?)!).toList(),
      requestedPickupTransportEvent: RequestedPickupTransportEvent.fromJson(json['requestedPickupTransportEvent'] as Map<String, dynamic>?),
      requestedDeliveryTransportEvent: RequestedDeliveryTransportEvent.fromJson(json['requestedDeliveryTransportEvent'] as Map<String, dynamic>?),
      plannedPickupTransportEvent: PlannedPickupTransportEvent.fromJson(json['plannedPickupTransportEvent'] as Map<String, dynamic>?),
      plannedDeliveryTransportEvent: PlannedDeliveryTransportEvent.fromJson(json['plannedDeliveryTransportEvent'] as Map<String, dynamic>?),
      actualPickupTransportEvent: ActualPickupTransportEvent.fromJson(json['actualPickupTransportEvent'] as Map<String, dynamic>?),
      actualDeliveryTransportEvent: ActualDeliveryTransportEvent.fromJson(json['actualDeliveryTransportEvent'] as Map<String, dynamic>?),
      status: (json['status'] as List? ?? []).map((dynamic d) => Status.fromJson(d as Map<String, dynamic>?)!).toList(),
      childConsignment: (json['childConsignment'] as List? ?? []).map((dynamic d) => ChildConsignment.fromJson(d as Map<String, dynamic>?)!).toList(),
      consigneeParty: ConsigneeParty.fromJson(json['consigneeParty'] as Map<String, dynamic>?),
      exporterParty: ExporterParty.fromJson(json['exporterParty'] as Map<String, dynamic>?),
      consignorParty: ConsignorParty.fromJson(json['consignorParty'] as Map<String, dynamic>?),
      importerParty: ImporterParty.fromJson(json['importerParty'] as Map<String, dynamic>?),
      carrierParty: CarrierParty.fromJson(json['carrierParty'] as Map<String, dynamic>?),
      freightForwarderParty: FreightForwarderParty.fromJson(json['freightForwarderParty'] as Map<String, dynamic>?),
      notifyParty: NotifyParty.fromJson(json['notifyParty'] as Map<String, dynamic>?),
      originalDespatchParty: OriginalDespatchParty.fromJson(json['originalDespatchParty'] as Map<String, dynamic>?),
      finalDeliveryParty: FinalDeliveryParty.fromJson(json['finalDeliveryParty'] as Map<String, dynamic>?),
      performingCarrierParty: PerformingCarrierParty.fromJson(json['performingCarrierParty'] as Map<String, dynamic>?),
      substituteCarrierParty: SubstituteCarrierParty.fromJson(json['substituteCarrierParty'] as Map<String, dynamic>?),
      logisticsOperatorParty: LogisticsOperatorParty.fromJson(json['logisticsOperatorParty'] as Map<String, dynamic>?),
      transportAdvisorParty: TransportAdvisorParty.fromJson(json['transportAdvisorParty'] as Map<String, dynamic>?),
      hazardousItemNotificationParty: HazardousItemNotificationParty.fromJson(json['hazardousItemNotificationParty'] as Map<String, dynamic>?),
      insuranceParty: InsuranceParty.fromJson(json['insuranceParty'] as Map<String, dynamic>?),
      mortgageHolderParty: MortgageHolderParty.fromJson(json['mortgageHolderParty'] as Map<String, dynamic>?),
      billOfLadingHolderParty: BillOfLadingHolderParty.fromJson(json['billOfLadingHolderParty'] as Map<String, dynamic>?),
      originalDepartureCountry: OriginalDepartureCountry.fromJson(json['originalDepartureCountry'] as Map<String, dynamic>?),
      finalDestinationCountry: FinalDestinationCountry.fromJson(json['finalDestinationCountry'] as Map<String, dynamic>?),
      transitCountry: (json['transitCountry'] as List? ?? []).map((dynamic d) => TransitCountry.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportContract: TransportContract.fromJson(json['transportContract'] as Map<String, dynamic>?),
      transportEvent: (json['transportEvent'] as List? ?? []).map((dynamic d) => TransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      originalDespatchTransportationService: OriginalDespatchTransportationService.fromJson(json['originalDespatchTransportationService'] as Map<String, dynamic>?),
      finalDeliveryTransportationService: FinalDeliveryTransportationService.fromJson(json['finalDeliveryTransportationService'] as Map<String, dynamic>?),
      deliveryTerms: DeliveryTerms.fromJson(json['deliveryTerms'] as Map<String, dynamic>?),
      paymentTerms: PaymentTerms.fromJson(json['paymentTerms'] as Map<String, dynamic>?),
      collectPaymentTerms: CollectPaymentTerms.fromJson(json['collectPaymentTerms'] as Map<String, dynamic>?),
      disbursementPaymentTerms: DisbursementPaymentTerms.fromJson(json['disbursementPaymentTerms'] as Map<String, dynamic>?),
      prepaidPaymentTerms: PrepaidPaymentTerms.fromJson(json['prepaidPaymentTerms'] as Map<String, dynamic>?),
      freightAllowanceCharge: (json['freightAllowanceCharge'] as List? ?? []).map((dynamic d) => FreightAllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      extraAllowanceCharge: (json['extraAllowanceCharge'] as List? ?? []).map((dynamic d) => ExtraAllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      mainCarriageShipmentStage: (json['mainCarriageShipmentStage'] as List? ?? []).map((dynamic d) => MainCarriageShipmentStage.fromJson(d as Map<String, dynamic>?)!).toList(),
      preCarriageShipmentStage: (json['preCarriageShipmentStage'] as List? ?? []).map((dynamic d) => PreCarriageShipmentStage.fromJson(d as Map<String, dynamic>?)!).toList(),
      onCarriageShipmentStage: (json['onCarriageShipmentStage'] as List? ?? []).map((dynamic d) => OnCarriageShipmentStage.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportHandlingUnit: (json['transportHandlingUnit'] as List? ?? []).map((dynamic d) => TransportHandlingUnit.fromJson(d as Map<String, dynamic>?)!).toList(),
      firstArrivalPortLocation: FirstArrivalPortLocation.fromJson(json['firstArrivalPortLocation'] as Map<String, dynamic>?),
      lastExitPortLocation: LastExitPortLocation.fromJson(json['lastExitPortLocation'] as Map<String, dynamic>?),
      officeOfEntryLocation: OfficeOfEntryLocation.fromJson(json['officeOfEntryLocation'] as Map<String, dynamic>?),
      officeOfSubSequentiallyEntryLocation: OfficeOfSubSequentiallyEntryLocation.fromJson(json['officeOfSubSequentiallyEntryLocation'] as Map<String, dynamic>?),
      officeOfExitLocation: OfficeOfExitLocation.fromJson(json['officeOfExitLocation'] as Map<String, dynamic>?),
      officeOfDepartureLocation: OfficeOfDepartureLocation.fromJson(json['officeOfDepartureLocation'] as Map<String, dynamic>?),
      officeOfDestinationLocation: OfficeOfDestinationLocation.fromJson(json['officeOfDestinationLocation'] as Map<String, dynamic>?),
      officeOfImportLocation: OfficeOfImportLocation.fromJson(json['officeOfImportLocation'] as Map<String, dynamic>?),
      officeOfExportLocation: OfficeOfExportLocation.fromJson(json['officeOfExportLocation'] as Map<String, dynamic>?),
      documentReference: (json['documentReference'] as List? ?? []).map((dynamic d) => DocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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
      'actualPickupTransportEvent': actualPickupTransportEvent?.toJson(),
      'actualDeliveryTransportEvent': actualDeliveryTransportEvent?.toJson(),
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
      'officeOfEntryLocation': officeOfEntryLocation?.toJson(),
      'officeOfSubSequentiallyEntryLocation': officeOfSubSequentiallyEntryLocation?.toJson(),
      'officeOfExitLocation': officeOfExitLocation?.toJson(),
      'officeOfDepartureLocation': officeOfDepartureLocation?.toJson(),
      'officeOfDestinationLocation': officeOfDestinationLocation?.toJson(),
      'officeOfImportLocation': officeOfImportLocation?.toJson(),
      'officeOfExportLocation': officeOfExportLocation?.toJson(),
      'documentReference': documentReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Consignment? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return Consignment (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      carrierAssignedID: CarrierAssignedID.fromXml(xml.findElements('cbc:CarrierAssignedID').singleOrNull),
      consigneeAssignedID: ConsigneeAssignedID.fromXml(xml.findElements('cbc:ConsigneeAssignedID').singleOrNull),
      consignorAssignedID: ConsignorAssignedID.fromXml(xml.findElements('cbc:ConsignorAssignedID').singleOrNull),
      freightForwarderAssignedID: FreightForwarderAssignedID.fromXml(xml.findElements('cbc:FreightForwarderAssignedID').singleOrNull),
      brokerAssignedID: BrokerAssignedID.fromXml(xml.findElements('cbc:BrokerAssignedID').singleOrNull),
      contractedCarrierAssignedID: ContractedCarrierAssignedID.fromXml(xml.findElements('cbc:ContractedCarrierAssignedID').singleOrNull),
      performingCarrierAssignedID: PerformingCarrierAssignedID.fromXml(xml.findElements('cbc:PerformingCarrierAssignedID').singleOrNull),
      summaryDescription: xml.findElements('cbc:SummaryDescription').map((XmlElement e) => SummaryDescription.fromXml(e)!).toList(),
      totalInvoiceAmount: TotalInvoiceAmount.fromXml(xml.findElements('cbc:TotalInvoiceAmount').singleOrNull),
      declaredCustomsValueAmount: DeclaredCustomsValueAmount.fromXml(xml.findElements('cbc:DeclaredCustomsValueAmount').singleOrNull),
      tariffDescription: xml.findElements('cbc:TariffDescription').map((XmlElement e) => TariffDescription.fromXml(e)!).toList(),
      tariffCode: TariffCode.fromXml(xml.findElements('cbc:TariffCode').singleOrNull),
      insurancePremiumAmount: InsurancePremiumAmount.fromXml(xml.findElements('cbc:InsurancePremiumAmount').singleOrNull),
      grossWeightMeasure: GrossWeightMeasure.fromXml(xml.findElements('cbc:GrossWeightMeasure').singleOrNull),
      netWeightMeasure: NetWeightMeasure.fromXml(xml.findElements('cbc:NetWeightMeasure').singleOrNull),
      netNetWeightMeasure: NetNetWeightMeasure.fromXml(xml.findElements('cbc:NetNetWeightMeasure').singleOrNull),
      chargeableWeightMeasure: ChargeableWeightMeasure.fromXml(xml.findElements('cbc:ChargeableWeightMeasure').singleOrNull),
      grossVolumeMeasure: GrossVolumeMeasure.fromXml(xml.findElements('cbc:GrossVolumeMeasure').singleOrNull),
      netVolumeMeasure: NetVolumeMeasure.fromXml(xml.findElements('cbc:NetVolumeMeasure').singleOrNull),
      loadingLengthMeasure: LoadingLengthMeasure.fromXml(xml.findElements('cbc:LoadingLengthMeasure').singleOrNull),
      remarks: xml.findElements('cbc:Remarks').map((XmlElement e) => Remarks.fromXml(e)!).toList(),
      hazardousRiskIndicator: HazardousRiskIndicator.fromXml(xml.findElements('cbc:HazardousRiskIndicator').singleOrNull),
      animalFoodIndicator: AnimalFoodIndicator.fromXml(xml.findElements('cbc:AnimalFoodIndicator').singleOrNull),
      humanFoodIndicator: HumanFoodIndicator.fromXml(xml.findElements('cbc:HumanFoodIndicator').singleOrNull),
      livestockIndicator: LivestockIndicator.fromXml(xml.findElements('cbc:LivestockIndicator').singleOrNull),
      bulkCargoIndicator: BulkCargoIndicator.fromXml(xml.findElements('cbc:BulkCargoIndicator').singleOrNull),
      containerizedIndicator: ContainerizedIndicator.fromXml(xml.findElements('cbc:ContainerizedIndicator').singleOrNull),
      generalCargoIndicator: GeneralCargoIndicator.fromXml(xml.findElements('cbc:GeneralCargoIndicator').singleOrNull),
      specialSecurityIndicator: SpecialSecurityIndicator.fromXml(xml.findElements('cbc:SpecialSecurityIndicator').singleOrNull),
      thirdPartyPayerIndicator: ThirdPartyPayerIndicator.fromXml(xml.findElements('cbc:ThirdPartyPayerIndicator').singleOrNull),
      carrierServiceInstructions: xml.findElements('cbc:CarrierServiceInstructions').map((XmlElement e) => CarrierServiceInstructions.fromXml(e)!).toList(),
      customsClearanceServiceInstructions: xml.findElements('cbc:CustomsClearanceServiceInstructions').map((XmlElement e) => CustomsClearanceServiceInstructions.fromXml(e)!).toList(),
      forwarderServiceInstructions: xml.findElements('cbc:ForwarderServiceInstructions').map((XmlElement e) => ForwarderServiceInstructions.fromXml(e)!).toList(),
      specialServiceInstructions: xml.findElements('cbc:SpecialServiceInstructions').map((XmlElement e) => SpecialServiceInstructions.fromXml(e)!).toList(),
      sequenceID: SequenceID.fromXml(xml.findElements('cbc:SequenceID').singleOrNull),
      shippingPriorityLevelCode: ShippingPriorityLevelCode.fromXml(xml.findElements('cbc:ShippingPriorityLevelCode').singleOrNull),
      handlingCode: HandlingCode.fromXml(xml.findElements('cbc:HandlingCode').singleOrNull),
      handlingInstructions: xml.findElements('cbc:HandlingInstructions').map((XmlElement e) => HandlingInstructions.fromXml(e)!).toList(),
      information: xml.findElements('cbc:Information').map((XmlElement e) => Information.fromXml(e)!).toList(),
      totalGoodsItemQuantity: TotalGoodsItemQuantity.fromXml(xml.findElements('cbc:TotalGoodsItemQuantity').singleOrNull),
      totalTransportHandlingUnitQuantity: TotalTransportHandlingUnitQuantity.fromXml(xml.findElements('cbc:TotalTransportHandlingUnitQuantity').singleOrNull),
      insuranceValueAmount: InsuranceValueAmount.fromXml(xml.findElements('cbc:InsuranceValueAmount').singleOrNull),
      declaredForCarriageValueAmount: DeclaredForCarriageValueAmount.fromXml(xml.findElements('cbc:DeclaredForCarriageValueAmount').singleOrNull),
      declaredStatisticsValueAmount: DeclaredStatisticsValueAmount.fromXml(xml.findElements('cbc:DeclaredStatisticsValueAmount').singleOrNull),
      freeOnBoardValueAmount: FreeOnBoardValueAmount.fromXml(xml.findElements('cbc:FreeOnBoardValueAmount').singleOrNull),
      specialInstructions: xml.findElements('cbc:SpecialInstructions').map((XmlElement e) => SpecialInstructions.fromXml(e)!).toList(),
      splitConsignmentIndicator: SplitConsignmentIndicator.fromXml(xml.findElements('cbc:SplitConsignmentIndicator').singleOrNull),
      deliveryInstructions: xml.findElements('cbc:DeliveryInstructions').map((XmlElement e) => DeliveryInstructions.fromXml(e)!).toList(),
      consignmentQuantity: ConsignmentQuantity.fromXml(xml.findElements('cbc:ConsignmentQuantity').singleOrNull),
      consolidatableIndicator: ConsolidatableIndicator.fromXml(xml.findElements('cbc:ConsolidatableIndicator').singleOrNull),
      haulageInstructions: xml.findElements('cbc:HaulageInstructions').map((XmlElement e) => HaulageInstructions.fromXml(e)!).toList(),
      loadingSequenceID: LoadingSequenceID.fromXml(xml.findElements('cbc:LoadingSequenceID').singleOrNull),
      childConsignmentQuantity: ChildConsignmentQuantity.fromXml(xml.findElements('cbc:ChildConsignmentQuantity').singleOrNull),
      totalPackagesQuantity: TotalPackagesQuantity.fromXml(xml.findElements('cbc:TotalPackagesQuantity').singleOrNull),
      consolidatedShipment: xml.findElements('cac:ConsolidatedShipment').map((XmlElement e) => ConsolidatedShipment.fromXml(e)!).toList(),
      customsDeclaration: xml.findElements('cac:CustomsDeclaration').map((XmlElement e) => CustomsDeclaration.fromXml(e)!).toList(),
      requestedPickupTransportEvent: RequestedPickupTransportEvent.fromXml(xml.findElements('cac:RequestedPickupTransportEvent').singleOrNull),
      requestedDeliveryTransportEvent: RequestedDeliveryTransportEvent.fromXml(xml.findElements('cac:RequestedDeliveryTransportEvent').singleOrNull),
      plannedPickupTransportEvent: PlannedPickupTransportEvent.fromXml(xml.findElements('cac:PlannedPickupTransportEvent').singleOrNull),
      plannedDeliveryTransportEvent: PlannedDeliveryTransportEvent.fromXml(xml.findElements('cac:PlannedDeliveryTransportEvent').singleOrNull),
      actualPickupTransportEvent: ActualPickupTransportEvent.fromXml(xml.findElements('cac:ActualPickupTransportEvent').singleOrNull),
      actualDeliveryTransportEvent: ActualDeliveryTransportEvent.fromXml(xml.findElements('cac:ActualDeliveryTransportEvent').singleOrNull),
      status: xml.findElements('cac:Status').map((XmlElement e) => Status.fromXml(e)!).toList(),
      childConsignment: xml.findElements('cac:ChildConsignment').map((XmlElement e) => ChildConsignment.fromXml(e)!).toList(),
      consigneeParty: ConsigneeParty.fromXml(xml.findElements('cac:ConsigneeParty').singleOrNull),
      exporterParty: ExporterParty.fromXml(xml.findElements('cac:ExporterParty').singleOrNull),
      consignorParty: ConsignorParty.fromXml(xml.findElements('cac:ConsignorParty').singleOrNull),
      importerParty: ImporterParty.fromXml(xml.findElements('cac:ImporterParty').singleOrNull),
      carrierParty: CarrierParty.fromXml(xml.findElements('cac:CarrierParty').singleOrNull),
      freightForwarderParty: FreightForwarderParty.fromXml(xml.findElements('cac:FreightForwarderParty').singleOrNull),
      notifyParty: NotifyParty.fromXml(xml.findElements('cac:NotifyParty').singleOrNull),
      originalDespatchParty: OriginalDespatchParty.fromXml(xml.findElements('cac:OriginalDespatchParty').singleOrNull),
      finalDeliveryParty: FinalDeliveryParty.fromXml(xml.findElements('cac:FinalDeliveryParty').singleOrNull),
      performingCarrierParty: PerformingCarrierParty.fromXml(xml.findElements('cac:PerformingCarrierParty').singleOrNull),
      substituteCarrierParty: SubstituteCarrierParty.fromXml(xml.findElements('cac:SubstituteCarrierParty').singleOrNull),
      logisticsOperatorParty: LogisticsOperatorParty.fromXml(xml.findElements('cac:LogisticsOperatorParty').singleOrNull),
      transportAdvisorParty: TransportAdvisorParty.fromXml(xml.findElements('cac:TransportAdvisorParty').singleOrNull),
      hazardousItemNotificationParty: HazardousItemNotificationParty.fromXml(xml.findElements('cac:HazardousItemNotificationParty').singleOrNull),
      insuranceParty: InsuranceParty.fromXml(xml.findElements('cac:InsuranceParty').singleOrNull),
      mortgageHolderParty: MortgageHolderParty.fromXml(xml.findElements('cac:MortgageHolderParty').singleOrNull),
      billOfLadingHolderParty: BillOfLadingHolderParty.fromXml(xml.findElements('cac:BillOfLadingHolderParty').singleOrNull),
      originalDepartureCountry: OriginalDepartureCountry.fromXml(xml.findElements('cac:OriginalDepartureCountry').singleOrNull),
      finalDestinationCountry: FinalDestinationCountry.fromXml(xml.findElements('cac:FinalDestinationCountry').singleOrNull),
      transitCountry: xml.findElements('cac:TransitCountry').map((XmlElement e) => TransitCountry.fromXml(e)!).toList(),
      transportContract: TransportContract.fromXml(xml.findElements('cac:TransportContract').singleOrNull),
      transportEvent: xml.findElements('cac:TransportEvent').map((XmlElement e) => TransportEvent.fromXml(e)!).toList(),
      originalDespatchTransportationService: OriginalDespatchTransportationService.fromXml(xml.findElements('cac:OriginalDespatchTransportationService').singleOrNull),
      finalDeliveryTransportationService: FinalDeliveryTransportationService.fromXml(xml.findElements('cac:FinalDeliveryTransportationService').singleOrNull),
      deliveryTerms: DeliveryTerms.fromXml(xml.findElements('cac:DeliveryTerms').singleOrNull),
      paymentTerms: PaymentTerms.fromXml(xml.findElements('cac:PaymentTerms').singleOrNull),
      collectPaymentTerms: CollectPaymentTerms.fromXml(xml.findElements('cac:CollectPaymentTerms').singleOrNull),
      disbursementPaymentTerms: DisbursementPaymentTerms.fromXml(xml.findElements('cac:DisbursementPaymentTerms').singleOrNull),
      prepaidPaymentTerms: PrepaidPaymentTerms.fromXml(xml.findElements('cac:PrepaidPaymentTerms').singleOrNull),
      freightAllowanceCharge: xml.findElements('cac:FreightAllowanceCharge').map((XmlElement e) => FreightAllowanceCharge.fromXml(e)!).toList(),
      extraAllowanceCharge: xml.findElements('cac:ExtraAllowanceCharge').map((XmlElement e) => ExtraAllowanceCharge.fromXml(e)!).toList(),
      mainCarriageShipmentStage: xml.findElements('cac:MainCarriageShipmentStage').map((XmlElement e) => MainCarriageShipmentStage.fromXml(e)!).toList(),
      preCarriageShipmentStage: xml.findElements('cac:PreCarriageShipmentStage').map((XmlElement e) => PreCarriageShipmentStage.fromXml(e)!).toList(),
      onCarriageShipmentStage: xml.findElements('cac:OnCarriageShipmentStage').map((XmlElement e) => OnCarriageShipmentStage.fromXml(e)!).toList(),
      transportHandlingUnit: xml.findElements('cac:TransportHandlingUnit').map((XmlElement e) => TransportHandlingUnit.fromXml(e)!).toList(),
      firstArrivalPortLocation: FirstArrivalPortLocation.fromXml(xml.findElements('cac:FirstArrivalPortLocation').singleOrNull),
      lastExitPortLocation: LastExitPortLocation.fromXml(xml.findElements('cac:LastExitPortLocation').singleOrNull),
      officeOfEntryLocation: OfficeOfEntryLocation.fromXml(xml.findElements('cac:OfficeOfEntryLocation').singleOrNull),
      officeOfSubSequentiallyEntryLocation: OfficeOfSubSequentiallyEntryLocation.fromXml(xml.findElements('cac:OfficeOfSubSequentiallyEntryLocation').singleOrNull),
      officeOfExitLocation: OfficeOfExitLocation.fromXml(xml.findElements('cac:OfficeOfExitLocation').singleOrNull),
      officeOfDepartureLocation: OfficeOfDepartureLocation.fromXml(xml.findElements('cac:OfficeOfDepartureLocation').singleOrNull),
      officeOfDestinationLocation: OfficeOfDestinationLocation.fromXml(xml.findElements('cac:OfficeOfDestinationLocation').singleOrNull),
      officeOfImportLocation: OfficeOfImportLocation.fromXml(xml.findElements('cac:OfficeOfImportLocation').singleOrNull),
      officeOfExportLocation: OfficeOfExportLocation.fromXml(xml.findElements('cac:OfficeOfExportLocation').singleOrNull),
      documentReference: xml.findElements('cac:DocumentReference').map((XmlElement e) => DocumentReference.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'Consignment',
        'cac',
      ),
    );
  }
}

