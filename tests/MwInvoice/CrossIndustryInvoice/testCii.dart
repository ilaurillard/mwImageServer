import 'dart:io';

import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:xml/xml.dart';

Future<void> main(
  List<String> arguments,
) async {
  String source = '';

  if (arguments.isNotEmpty) {
    source = arguments.first;
  }

  if (source.isNotEmpty) {
    String dest = source + '.xxx';

    String xml = File(
      source,
    ).readAsStringSync();

    CrossIndustryInvoice? i = CrossIndustryInvoice.fromXmlString(xml);
    XmlDocument xml2 = i!.toXml();

    // print(Util.prettyXml(xml2));

    File f = await File(
      dest,
    ).create();
    f.writeAsString(
      Util.prettyXml(xml2),
      flush: true,
    );
  }
}
