import '../cac/Description.dart';
import '../cac/PackQuantity.dart';
import '../cac/PackSizeNumeric.dart';
import '../cac/CatalogueIndicator.dart';
import '../cac/Name.dart';
import '../cac/HazardousRiskIndicator.dart';
import '../cac/AdditionalInformation.dart';
import '../cac/Keyword.dart';
import '../cac/BrandName.dart';
import '../cac/ModelName.dart';
import '../cac/BuyersItemIdentification.dart';
import '../cac/SellersItemIdentification.dart';
import '../cac/ManufacturersItemIdentification.dart';
import '../cac/StandardItemIdentification.dart';
import '../cac/CatalogueItemIdentification.dart';
import '../cac/AdditionalItemIdentification.dart';
import '../cac/CatalogueDocumentReference.dart';
import '../cac/ItemSpecificationDocumentReference.dart';
import '../cac/OriginCountry.dart';
import '../cac/CommodityClassification.dart';
import '../cac/TransactionConditions.dart';
import '../cac/HazardousItem.dart';
import '../cac/ClassifiedTaxCategory.dart';
import '../cac/AdditionalItemProperty.dart';
import '../cac/ManufacturerParty.dart';
import '../cac/InformationContentProviderParty.dart';
import '../cac/OriginAddress.dart';
import '../cac/ItemInstance.dart';
import '../cac/Certificate.dart';
import '../cac/Dimension.dart';

// A class to describe an item of trade. It includes a generic description applicable to all examples of the item together with optional subsidiary descriptions of any number of actual instances of the type.
class Item {


  // Text describing this item.
  final List<Description> description;

  // The unit packaging quantity; the number of subunits making up this item.
  final PackQuantity? packQuantity;

  // The number of items in a pack of this item.
  final PackSizeNumeric? packSizeNumeric;

  // An indicator that this item was ordered from a catalogue (true) or not (false).
  final CatalogueIndicator? catalogueIndicator;

  // A short name optionally given to this item, such as a name from a catalogue, as distinct from a description.
  final Name? name;

  // An indication that the transported item, as delivered, is subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  // Further details regarding this item (e.g., the URL of a relevant web page).
  final List<AdditionalInformation> additionalInformation;

  // A keyword (search string) for this item, assigned by the seller party. Can also be a synonym for the name of the item.
  final List<Keyword> keyword;

  // A brand name of this item.
  final List<BrandName> brandName;

  // A model name of this item.
  final List<ModelName> modelName;

  // Identifying information for this item, assigned by the buyer.
  final BuyersItemIdentification? buyersItemIdentification;

  // Identifying information for this item, assigned by the seller.
  final SellersItemIdentification? sellersItemIdentification;

  // Identifying information for this item, assigned by the manufacturer.
  final List<ManufacturersItemIdentification> manufacturersItemIdentification;

  // Identifying information for this item, assigned according to a standard system.
  final StandardItemIdentification? standardItemIdentification;

  // Identifying information for this item, assigned according to a cataloguing system.
  final CatalogueItemIdentification? catalogueItemIdentification;

  // An additional identifier for this item.
  final List<AdditionalItemIdentification> additionalItemIdentification;

  // A reference to the catalogue in which this item appears.
  final CatalogueDocumentReference? catalogueDocumentReference;

  // A reference to a specification document for this item.
  final List<ItemSpecificationDocumentReference> itemSpecificationDocumentReference;

  // The country of origin of this item.
  final OriginCountry? originCountry;

  // A classification of this item according to a specific system for classifying commodities.
  final List<CommodityClassification> commodityClassification;

  // A set of sales conditions applying to this item.
  final List<TransactionConditions> transactionConditions;

  // Information pertaining to this item as a hazardous item.
  final List<HazardousItem> hazardousItem;

  // A tax category applicable to this item.
  final List<ClassifiedTaxCategory> classifiedTaxCategory;

  // An additional property of this item.
  final List<AdditionalItemProperty> additionalItemProperty;

  // The manufacturer of this item.
  final List<ManufacturerParty> manufacturerParty;

  // The party responsible for specification of this item.
  final InformationContentProviderParty? informationContentProviderParty;

  // A region (not country) of origin of this item.
  final List<OriginAddress> originAddress;

  // A trackable, unique instantiation of this item.
  final List<ItemInstance> itemInstance;

  // A certificate associated with this item.
  final List<Certificate> certificate;

  // One of the measurable dimensions (length, mass, weight, or volume) of this item.
  final List<Dimension> dimension;

  Item ({
    this.description = const [],
    this.packQuantity,
    this.packSizeNumeric,
    this.catalogueIndicator,
    this.name,
    this.hazardousRiskIndicator,
    this.additionalInformation = const [],
    this.keyword = const [],
    this.brandName = const [],
    this.modelName = const [],
    this.buyersItemIdentification,
    this.sellersItemIdentification,
    this.manufacturersItemIdentification = const [],
    this.standardItemIdentification,
    this.catalogueItemIdentification,
    this.additionalItemIdentification = const [],
    this.catalogueDocumentReference,
    this.itemSpecificationDocumentReference = const [],
    this.originCountry,
    this.commodityClassification = const [],
    this.transactionConditions = const [],
    this.hazardousItem = const [],
    this.classifiedTaxCategory = const [],
    this.additionalItemProperty = const [],
    this.manufacturerParty = const [],
    this.informationContentProviderParty,
    this.originAddress = const [],
    this.itemInstance = const [],
    this.certificate = const [],
    this.dimension = const [],
  });
}

