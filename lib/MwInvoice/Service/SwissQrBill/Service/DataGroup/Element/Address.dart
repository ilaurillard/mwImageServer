import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/String/StringModifier.dart';

abstract class Address {
  static const int MAX_CHARS_PER_LINE_ON_RECEIPT = 40;

  static String normalizeString(String? string) {
    if (string == null) {
      return '';
    }

    string = string.trim();
    string = StringModifier.replaceLineBreaksAndTabsWithSpaces(string);
    return StringModifier.replaceMultipleSpacesWithOne(string);
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
}
