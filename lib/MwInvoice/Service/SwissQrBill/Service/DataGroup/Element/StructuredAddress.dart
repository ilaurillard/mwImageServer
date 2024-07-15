import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/AddressInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/Address.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';

final class StructuredAddress extends Address
    implements
        AddressInterface,
        QrCodeableInterface // SelfValidatableInterface, QrCodeableInterface
{
  // use SelfValidatableTrait;

  static const String ADDRESS_TYPE = 'S';

  /// Name or company
  late final String name;

  /// Street / P.O. box
  ///
  /// May not include building or house number.
  late final String street;

  /// Building number
  late final String buildingNumber;

  /// Postal code without country code
  late final String postalCode;

  /// City
  late final String city;

  /// Country (ISO 3166-1 alpha-2)
  late final String country;

  StructuredAddress({
    required String name,
    required String street,
    required String buildingNumber,
    required String postalCode,
    required String city,
    required String country,
  }) {
    this.name = Address.normalizeString(name);
    this.street = Address.normalizeString(street);
    this.buildingNumber = Address.normalizeString(buildingNumber);
    this.postalCode = Address.normalizeString(postalCode);
    this.city = Address.normalizeString(city);
    this.country = Address.normalizeString(country).toUpperCase();
  }

  @override
  String getName() {
    return name;
  }

  @override
  String getCountry() {
    return country;
  }

  @override
  String getFullAddress({
    bool forReceipt = false,
  }) {
    List<String> lines = [];
    lines.add('');
    lines.add(name);

    if (street.isNotEmpty) {
      if (buildingNumber.isNotEmpty) {
        lines.add(
          '$street $buildingNumber',
        );
      } else {
        lines.add(street);
      }
    }
    //
    if ('CH' == country) {
      lines.add('$postalCode $city');
    } else {
      lines.add('$country-$postalCode $city');
    }

    if (forReceipt) {
      lines = Address.clearMultilines(lines);
    }

    return lines.join('\n');
  }

  @override
  List<String> getQrCodeData() {
    return [
      city.isNotEmpty ? StructuredAddress.ADDRESS_TYPE : '',
      name,
      street,
      buildingNumber,
      postalCode,
      city,
      country
    ];
  }

  @override
  List<String> errors() {
    List<String> errors = [];

    if (name.isEmpty || name.length > 70) {
      errors.add('Invalid name');
    }

    if (street.length > 70) {
      errors.add('Invalid street');
    }

    if (buildingNumber.length > 16) {
      errors.add('Invalid buildingNumber');
    }

    if (postalCode.length > 16 || postalCode.isEmpty) {
      errors.add('Invalid postalCode');
    }

    if (city.length > 35 || city.isEmpty) {
      errors.add('Invalid city');
    }

    if (country.isEmpty) {
      errors.add('Invalid country');
    }
    // TODO check valid country code

    return errors;
  }

// public static function loadValidatorMetadata(ClassMetadata $metadata): void
// {
//     $metadata->addPropertyConstraints('name', [
//         new Assert\NotBlank(),
//         new Assert\Length([
//             'max' => 70
//         ])
//     ]);
//
//     $metadata->addPropertyConstraints('street', [
//         new Assert\Length([
//             'max' => 70
//         ])
//     ]);
//
//     $metadata->addPropertyConstraints('buildingNumber', [
//         new Assert\Length([
//             'max' => 16
//         ])
//     ]);
//
//     $metadata->addPropertyConstraints('postalCode', [
//         new Assert\NotBlank(),
//         new Assert\Length([
//             'max' => 16
//         ])
//     ]);
//
//     $metadata->addPropertyConstraints('city', [
//         new Assert\NotBlank(),
//         new Assert\Length([
//             'max' => 35
//         ])
//     ]);
//
//     $metadata->addPropertyConstraints('country', [
//         new Assert\NotBlank(),
//         new Assert\Country()
//     ]);
// }
}
