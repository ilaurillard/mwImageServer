import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/AddressInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/CombinedAddress.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/StructuredAddress.dart';
import 'package:mwcdn/MwInvoice/Service/StringModifier.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';

abstract class Address {
  static const int MAX_CHARS_PER_LINE_ON_RECEIPT = 40;

  static String normalizeString(String? string) {
    if (string == null) {
      return '';
    }

    string = string.trim();
    string = StringModifier.ctrlToWhitespace(string);
    return StringModifier.collapseWhitespace(string);
  }

  static List<String> clearMultilines(
    List<String> lines,
  ) {
    int noOfLongLines = 0;
    for (String l in lines) {
      if (Address.willBeMoreThanOneLineOnReceipt(l)) {
        noOfLongLines++;
      }
    }
    if (noOfLongLines > 0) {
      if (lines.length > 2) {
        lines.removeAt(2);
      }
    }
    if (noOfLongLines > 1) {
      if (lines.length > 3) {
        lines.removeAt(3);
      }
    }
    return lines;
  }

  static bool willBeMoreThanOneLineOnReceipt(
    String string,
  ) {
    return string.length > Address.MAX_CHARS_PER_LINE_ON_RECEIPT;
  }

  static AddressInterface fromJson(
    Dict json,
  ) {
    String name = json['name'] as String? ?? '';
    String country = json['country'] as String? ?? '';
    String street = json['street'] as String? ?? '';
    String city = json['city'] as String? ?? '';
    String postalCode = json['postalCode'] as String? ?? '';
    String buildingNumber = json['buildingNumber'] as String? ?? '';
    String addressLine1 = json['addressLine1'] as String? ?? '';
    String addressLine2 = json['addressLine2'] as String? ?? '';

    if (street.isNotEmpty) {
      return StructuredAddress(
        name: name,
        street: street,
        buildingNumber: buildingNumber,
        postalCode: postalCode,
        city: city,
        country: country,
      );
    } else {
      return CombinedAddress(
        name: name,
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        country: country,
      );
    }
  }
}
