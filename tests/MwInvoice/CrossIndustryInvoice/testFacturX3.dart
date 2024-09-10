import 'dart:convert';
import 'dart:io';

import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:xml/xml.dart';

Future<void> main() async {

  CrossIndustryInvoice i = CrossIndustryInvoice.fromJson(
    (json.decode(
      File(
        'tests/MwPdf/examples/pdf_reisswolf.json',
      ).readAsStringSync(),
    ) as Dict)['facturx'] as Dict,
  );

  XmlDocument xml = i.toXml();
  print(Util.prettyXml(xml));

  File f = await File('reisswolf2.xml').create();
  f.writeAsString(
    Util.prettyXml(xml),
    flush: true,
  );
}
