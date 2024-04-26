import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Model/CrossIndustryInvoice.dart';
import 'package:xml/xml.dart';

class Invoice {
  XmlDocument? facturx;

  Invoice({
    this.facturx,
  });

  static Invoice fromJson(
    Dict json,
    State state,
  ) {
    return Invoice(
      facturx: json.isNotEmpty
          ? CrossIndustryInvoice.fromJson(
              json,
            ).toXml()
          : null,
    );
  }
}
