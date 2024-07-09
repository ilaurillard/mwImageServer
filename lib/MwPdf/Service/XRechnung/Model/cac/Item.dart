// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Description.dart';
import '../cbc/PackQuantity.dart';
import '../cbc/PackSizeNumeric.dart';
import '../cbc/CatalogueIndicator.dart';
import '../cbc/Name.dart';
import '../cbc/ItemTypeCode.dart';
import '../cbc/HazardousRiskIndicator.dart';
import '../cbc/AdditionalInformation.dart';
import '../cbc/Keyword.dart';
import '../cbc/BrandName.dart';
import '../cbc/ModelName.dart';
import '../cbc/WarrantyInformation.dart';
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
import '../cac/EnvironmentalEmission.dart';

// A class to describe an item of trade. It includes a generic description applicable to all examples of the item together with optional subsidiary descriptions of any number of actual instances of the type.
class Item {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // A code indicating the type of the item (eg., service, product, etc.).
  final ItemTypeCode? itemTypeCode;

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

  // Text describing the warranty for this item.
  final List<WarrantyInformation> warrantyInformation;

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

  // One or more environmental emissions of this item.
  final List<EnvironmentalEmission> environmentalEmission;

  Item ({
    this.uBLExtensions,
    this.description = const [],
    this.packQuantity,
    this.packSizeNumeric,
    this.catalogueIndicator,
    this.name,
    this.itemTypeCode,
    this.hazardousRiskIndicator,
    this.additionalInformation = const [],
    this.keyword = const [],
    this.brandName = const [],
    this.modelName = const [],
    this.warrantyInformation = const [],
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
    this.environmentalEmission = const [],
  });

  static Item? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Item (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      packQuantity: PackQuantity.fromJson(json['packQuantity'] as Map<String, dynamic>?),
      packSizeNumeric: PackSizeNumeric.fromJson(json['packSizeNumeric'] as Map<String, dynamic>?),
      catalogueIndicator: CatalogueIndicator.fromJson(json['catalogueIndicator'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      itemTypeCode: ItemTypeCode.fromJson(json['itemTypeCode'] as Map<String, dynamic>?),
      hazardousRiskIndicator: HazardousRiskIndicator.fromJson(json['hazardousRiskIndicator'] as Map<String, dynamic>?),
      additionalInformation: (json['additionalInformation'] as List? ?? []).map((dynamic d) => AdditionalInformation.fromJson(d as Map<String, dynamic>?)!).toList(),
      keyword: (json['keyword'] as List? ?? []).map((dynamic d) => Keyword.fromJson(d as Map<String, dynamic>?)!).toList(),
      brandName: (json['brandName'] as List? ?? []).map((dynamic d) => BrandName.fromJson(d as Map<String, dynamic>?)!).toList(),
      modelName: (json['modelName'] as List? ?? []).map((dynamic d) => ModelName.fromJson(d as Map<String, dynamic>?)!).toList(),
      warrantyInformation: (json['warrantyInformation'] as List? ?? []).map((dynamic d) => WarrantyInformation.fromJson(d as Map<String, dynamic>?)!).toList(),
      buyersItemIdentification: BuyersItemIdentification.fromJson(json['buyersItemIdentification'] as Map<String, dynamic>?),
      sellersItemIdentification: SellersItemIdentification.fromJson(json['sellersItemIdentification'] as Map<String, dynamic>?),
      manufacturersItemIdentification: (json['manufacturersItemIdentification'] as List? ?? []).map((dynamic d) => ManufacturersItemIdentification.fromJson(d as Map<String, dynamic>?)!).toList(),
      standardItemIdentification: StandardItemIdentification.fromJson(json['standardItemIdentification'] as Map<String, dynamic>?),
      catalogueItemIdentification: CatalogueItemIdentification.fromJson(json['catalogueItemIdentification'] as Map<String, dynamic>?),
      additionalItemIdentification: (json['additionalItemIdentification'] as List? ?? []).map((dynamic d) => AdditionalItemIdentification.fromJson(d as Map<String, dynamic>?)!).toList(),
      catalogueDocumentReference: CatalogueDocumentReference.fromJson(json['catalogueDocumentReference'] as Map<String, dynamic>?),
      itemSpecificationDocumentReference: (json['itemSpecificationDocumentReference'] as List? ?? []).map((dynamic d) => ItemSpecificationDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      originCountry: OriginCountry.fromJson(json['originCountry'] as Map<String, dynamic>?),
      commodityClassification: (json['commodityClassification'] as List? ?? []).map((dynamic d) => CommodityClassification.fromJson(d as Map<String, dynamic>?)!).toList(),
      transactionConditions: (json['transactionConditions'] as List? ?? []).map((dynamic d) => TransactionConditions.fromJson(d as Map<String, dynamic>?)!).toList(),
      hazardousItem: (json['hazardousItem'] as List? ?? []).map((dynamic d) => HazardousItem.fromJson(d as Map<String, dynamic>?)!).toList(),
      classifiedTaxCategory: (json['classifiedTaxCategory'] as List? ?? []).map((dynamic d) => ClassifiedTaxCategory.fromJson(d as Map<String, dynamic>?)!).toList(),
      additionalItemProperty: (json['additionalItemProperty'] as List? ?? []).map((dynamic d) => AdditionalItemProperty.fromJson(d as Map<String, dynamic>?)!).toList(),
      manufacturerParty: (json['manufacturerParty'] as List? ?? []).map((dynamic d) => ManufacturerParty.fromJson(d as Map<String, dynamic>?)!).toList(),
      informationContentProviderParty: InformationContentProviderParty.fromJson(json['informationContentProviderParty'] as Map<String, dynamic>?),
      originAddress: (json['originAddress'] as List? ?? []).map((dynamic d) => OriginAddress.fromJson(d as Map<String, dynamic>?)!).toList(),
      itemInstance: (json['itemInstance'] as List? ?? []).map((dynamic d) => ItemInstance.fromJson(d as Map<String, dynamic>?)!).toList(),
      certificate: (json['certificate'] as List? ?? []).map((dynamic d) => Certificate.fromJson(d as Map<String, dynamic>?)!).toList(),
      dimension: (json['dimension'] as List? ?? []).map((dynamic d) => Dimension.fromJson(d as Map<String, dynamic>?)!).toList(),
      environmentalEmission: (json['environmentalEmission'] as List? ?? []).map((dynamic d) => EnvironmentalEmission.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'packQuantity': packQuantity?.toJson(),
      'packSizeNumeric': packSizeNumeric?.toJson(),
      'catalogueIndicator': catalogueIndicator?.toJson(),
      'name': name?.toJson(),
      'itemTypeCode': itemTypeCode?.toJson(),
      'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
      'additionalInformation': additionalInformation.map((e) => e.toJson()).toList(),
      'keyword': keyword.map((e) => e.toJson()).toList(),
      'brandName': brandName.map((e) => e.toJson()).toList(),
      'modelName': modelName.map((e) => e.toJson()).toList(),
      'warrantyInformation': warrantyInformation.map((e) => e.toJson()).toList(),
      'buyersItemIdentification': buyersItemIdentification?.toJson(),
      'sellersItemIdentification': sellersItemIdentification?.toJson(),
      'manufacturersItemIdentification': manufacturersItemIdentification.map((e) => e.toJson()).toList(),
      'standardItemIdentification': standardItemIdentification?.toJson(),
      'catalogueItemIdentification': catalogueItemIdentification?.toJson(),
      'additionalItemIdentification': additionalItemIdentification.map((e) => e.toJson()).toList(),
      'catalogueDocumentReference': catalogueDocumentReference?.toJson(),
      'itemSpecificationDocumentReference': itemSpecificationDocumentReference.map((e) => e.toJson()).toList(),
      'originCountry': originCountry?.toJson(),
      'commodityClassification': commodityClassification.map((e) => e.toJson()).toList(),
      'transactionConditions': transactionConditions.map((e) => e.toJson()).toList(),
      'hazardousItem': hazardousItem.map((e) => e.toJson()).toList(),
      'classifiedTaxCategory': classifiedTaxCategory.map((e) => e.toJson()).toList(),
      'additionalItemProperty': additionalItemProperty.map((e) => e.toJson()).toList(),
      'manufacturerParty': manufacturerParty.map((e) => e.toJson()).toList(),
      'informationContentProviderParty': informationContentProviderParty?.toJson(),
      'originAddress': originAddress.map((e) => e.toJson()).toList(),
      'itemInstance': itemInstance.map((e) => e.toJson()).toList(),
      'certificate': certificate.map((e) => e.toJson()).toList(),
      'dimension': dimension.map((e) => e.toJson()).toList(),
      'environmentalEmission': environmentalEmission.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Item? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return Item (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      packQuantity: PackQuantity.fromXml(xml.findElements('cbc:PackQuantity').singleOrNull),
      packSizeNumeric: PackSizeNumeric.fromXml(xml.findElements('cbc:PackSizeNumeric').singleOrNull),
      catalogueIndicator: CatalogueIndicator.fromXml(xml.findElements('cbc:CatalogueIndicator').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      itemTypeCode: ItemTypeCode.fromXml(xml.findElements('cbc:ItemTypeCode').singleOrNull),
      hazardousRiskIndicator: HazardousRiskIndicator.fromXml(xml.findElements('cbc:HazardousRiskIndicator').singleOrNull),
      additionalInformation: xml.findElements('cbc:AdditionalInformation').map((XmlElement e) => AdditionalInformation.fromXml(e)!).toList(),
      keyword: xml.findElements('cbc:Keyword').map((XmlElement e) => Keyword.fromXml(e)!).toList(),
      brandName: xml.findElements('cbc:BrandName').map((XmlElement e) => BrandName.fromXml(e)!).toList(),
      modelName: xml.findElements('cbc:ModelName').map((XmlElement e) => ModelName.fromXml(e)!).toList(),
      warrantyInformation: xml.findElements('cbc:WarrantyInformation').map((XmlElement e) => WarrantyInformation.fromXml(e)!).toList(),
      buyersItemIdentification: BuyersItemIdentification.fromXml(xml.findElements('cac:BuyersItemIdentification').singleOrNull),
      sellersItemIdentification: SellersItemIdentification.fromXml(xml.findElements('cac:SellersItemIdentification').singleOrNull),
      manufacturersItemIdentification: xml.findElements('cac:ManufacturersItemIdentification').map((XmlElement e) => ManufacturersItemIdentification.fromXml(e)!).toList(),
      standardItemIdentification: StandardItemIdentification.fromXml(xml.findElements('cac:StandardItemIdentification').singleOrNull),
      catalogueItemIdentification: CatalogueItemIdentification.fromXml(xml.findElements('cac:CatalogueItemIdentification').singleOrNull),
      additionalItemIdentification: xml.findElements('cac:AdditionalItemIdentification').map((XmlElement e) => AdditionalItemIdentification.fromXml(e)!).toList(),
      catalogueDocumentReference: CatalogueDocumentReference.fromXml(xml.findElements('cac:CatalogueDocumentReference').singleOrNull),
      itemSpecificationDocumentReference: xml.findElements('cac:ItemSpecificationDocumentReference').map((XmlElement e) => ItemSpecificationDocumentReference.fromXml(e)!).toList(),
      originCountry: OriginCountry.fromXml(xml.findElements('cac:OriginCountry').singleOrNull),
      commodityClassification: xml.findElements('cac:CommodityClassification').map((XmlElement e) => CommodityClassification.fromXml(e)!).toList(),
      transactionConditions: xml.findElements('cac:TransactionConditions').map((XmlElement e) => TransactionConditions.fromXml(e)!).toList(),
      hazardousItem: xml.findElements('cac:HazardousItem').map((XmlElement e) => HazardousItem.fromXml(e)!).toList(),
      classifiedTaxCategory: xml.findElements('cac:ClassifiedTaxCategory').map((XmlElement e) => ClassifiedTaxCategory.fromXml(e)!).toList(),
      additionalItemProperty: xml.findElements('cac:AdditionalItemProperty').map((XmlElement e) => AdditionalItemProperty.fromXml(e)!).toList(),
      manufacturerParty: xml.findElements('cac:ManufacturerParty').map((XmlElement e) => ManufacturerParty.fromXml(e)!).toList(),
      informationContentProviderParty: InformationContentProviderParty.fromXml(xml.findElements('cac:InformationContentProviderParty').singleOrNull),
      originAddress: xml.findElements('cac:OriginAddress').map((XmlElement e) => OriginAddress.fromXml(e)!).toList(),
      itemInstance: xml.findElements('cac:ItemInstance').map((XmlElement e) => ItemInstance.fromXml(e)!).toList(),
      certificate: xml.findElements('cac:Certificate').map((XmlElement e) => Certificate.fromXml(e)!).toList(),
      dimension: xml.findElements('cac:Dimension').map((XmlElement e) => Dimension.fromXml(e)!).toList(),
      environmentalEmission: xml.findElements('cac:EnvironmentalEmission').map((XmlElement e) => EnvironmentalEmission.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      ...description.map((Description e) => e.toXml()),
      packQuantity?.toXml(),
      packSizeNumeric?.toXml(),
      catalogueIndicator?.toXml(),
      name?.toXml(),
      itemTypeCode?.toXml(),
      hazardousRiskIndicator?.toXml(),
      ...additionalInformation.map((AdditionalInformation e) => e.toXml()),
      ...keyword.map((Keyword e) => e.toXml()),
      ...brandName.map((BrandName e) => e.toXml()),
      ...modelName.map((ModelName e) => e.toXml()),
      ...warrantyInformation.map((WarrantyInformation e) => e.toXml()),
      buyersItemIdentification?.toXml(),
      sellersItemIdentification?.toXml(),
      ...manufacturersItemIdentification.map((ManufacturersItemIdentification e) => e.toXml()),
      standardItemIdentification?.toXml(),
      catalogueItemIdentification?.toXml(),
      ...additionalItemIdentification.map((AdditionalItemIdentification e) => e.toXml()),
      catalogueDocumentReference?.toXml(),
      ...itemSpecificationDocumentReference.map((ItemSpecificationDocumentReference e) => e.toXml()),
      originCountry?.toXml(),
      ...commodityClassification.map((CommodityClassification e) => e.toXml()),
      ...transactionConditions.map((TransactionConditions e) => e.toXml()),
      ...hazardousItem.map((HazardousItem e) => e.toXml()),
      ...classifiedTaxCategory.map((ClassifiedTaxCategory e) => e.toXml()),
      ...additionalItemProperty.map((AdditionalItemProperty e) => e.toXml()),
      ...manufacturerParty.map((ManufacturerParty e) => e.toXml()),
      informationContentProviderParty?.toXml(),
      ...originAddress.map((OriginAddress e) => e.toXml()),
      ...itemInstance.map((ItemInstance e) => e.toXml()),
      ...certificate.map((Certificate e) => e.toXml()),
      ...dimension.map((Dimension e) => e.toXml()),
      ...environmentalEmission.map((EnvironmentalEmission e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'Item',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

