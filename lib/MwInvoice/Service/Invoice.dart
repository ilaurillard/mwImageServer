import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/ubl/Invoice.dart'
    as x_invoice;
import 'package:xml/xml.dart';

class Invoice {

  // cross industry invoice
  XmlDocument? cii;

  // universal business language
  XmlDocument? ubl;

  Invoice({
    this.cii,
    this.ubl,
  }) {
    if (cii != null && ubl != null) {
      throw Exception(
        'cannot be both cii *and* ubl',
      );
    }
  }

  static Invoice fromJson(
    Dict jsonCII,
    Dict jsonXR,
  ) {
    return Invoice(
      cii: jsonCII.isNotEmpty
          ? CrossIndustryInvoice.fromJson(
              jsonCII,
            ).toXml()
          : null,
      ubl: jsonXR.isNotEmpty
          ? x_invoice.Invoice.fromJson(
              jsonXR,
            )?.toXml()
          : null,
    );
  }

  XmlDocument? xml() {
    if (cii != null) {
      return cii;
    }
    return ubl;
  }
}
