import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/ubl/Invoice.dart'
    as x_invoice;
import 'package:xml/xml.dart';

class Invoice {
  XmlDocument? cii;
  XmlDocument? xrechnung;

  Invoice({
    this.cii,
    this.xrechnung,
  }) {
    if (cii != null && xrechnung != null) {
      throw Exception(
        'cannot be both cii *and* xrechnung',
      );
    }
  }

  static Invoice fromJson(
    Dict jsonCII,
    Dict jsonXR,
    State state,
  ) {
    return Invoice(
      cii: jsonCII.isNotEmpty
          ? CrossIndustryInvoice.fromJson(
              jsonCII,
            ).toXml()
          : null,
      xrechnung: jsonXR.isNotEmpty
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
    return xrechnung;
  }
}
