import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/AddressInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/Address.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/SelfValidatableInterface.dart';

class CombinedAddress extends Address
    implements
        AddressInterface,
        QrCodeableInterface,
        SelfValidatableInterface
{
  // use SelfValidatableTrait;
  //
  static const String ADDRESS_TYPE = 'K';


  /// Name or company
  late final String name;


  /// Address line 1
  ///
  /// Street and building number or P.O. Box
  late final String addressLine1;


  /// Address line 2
  ///
  /// Postal code and town
  late final String addressLine2;


  /// Country (ISO 3166-1 alpha-2)
  late final String country;

  CombinedAddress({
    required String name,
    required String addressLine1,
    required String addressLine2,
    required String country,
  }) {
    this.name = Address.normalizeString(name);
    this.addressLine1 = Address.normalizeString(addressLine1);
    this.addressLine2 = Address.normalizeString(addressLine2);
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

    if (addressLine1.isNotEmpty) {
      lines.add(addressLine1);
    }

    if ('CH' == country) {
      lines.add(addressLine2);
    } else {
      lines.add('$country-$addressLine2');
    }

    if (forReceipt) {
      lines = Address.clearMultilines(lines);
    }

    return lines.join('\n');
  }

  @override
  List<String> getQrCodeData() {
    return [
      addressLine2.isNotEmpty ? CombinedAddress.ADDRESS_TYPE : '',
      name,
      addressLine1,
      addressLine2,
      '',
      '',
      country
    ];
  }

  @override
  List<String> errors() {
    List<String> errors = [];

    if (name.isEmpty || name.length > 70) {
      errors.add('Invalid name');
    }

    if (addressLine1.length > 70) {
      errors.add('Invalid addressLine1');
    }

    if (addressLine2.isEmpty || addressLine2.length > 70) {
      errors.add('Invalid addressLine2');
    }

    if (country.isEmpty) {
      errors.add('Invalid country');
    }
    // TODO check valid country code

    return errors;
  }
}
