import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/ubl/Invoice.dart'
    as x_invoice;
import 'package:xml/xml.dart';

class Invoice {
  XmlDocument? facturx;
  XmlDocument? xrechnung;

  Invoice({
    this.facturx,
    this.xrechnung,
  });

  static Invoice fromJson(
    Dict jsonCII,
    Dict jsonXR,
    State state,
  ) {
    return Invoice(
      facturx: jsonCII.isNotEmpty
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
    if (facturx != null) {
      return facturx;
    }
    return xrechnung;
  }
}
