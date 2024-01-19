import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
import 'package:xml/xml.dart';

class TradeAddress {
  final String? postcode;
  final String? lineOne;
  final String? lineTwo;
  final String? lineThree;
  final String? city;
  final String? countryCode;
  final String? countrySubDivisionName;

  TradeAddress({
    this.postcode,
    this.lineOne,
    this.lineTwo,
    this.lineThree,
    this.city,
    this.countryCode,
    this.countrySubDivisionName,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        Util.stringElement(builder, postcode, 'ram:PostcodeCode');
        Util.stringElement(builder, lineOne, 'ram:LineOne');
        Util.stringElement(builder, lineTwo, 'ram:LineTwo');
        Util.stringElement(builder, lineThree, 'ram:LineThree');
        Util.stringElement(builder, city, 'ram:CityName');
        Util.stringElement(builder, countryCode, 'ram:CountryID');
        Util.stringElement(builder, countrySubDivisionName, 'ram:CountrySubDivisionName');
      },
    );
  }

  static TradeAddress? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return TradeAddress();
    }
    return null;
  }
}
