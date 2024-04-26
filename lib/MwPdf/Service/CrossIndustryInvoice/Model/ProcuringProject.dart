import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/CrossIndustryInvoice/Util.dart';
import 'package:xml/xml.dart';

class ProcuringProject {
  final String id;
  final String name;

  ProcuringProject({
    required this.id,
    required this.name,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        Util.stringElement(builder, id, 'ram:ID');
        Util.stringElement(builder, this.name, 'ram:Name');
      },
    );
  }

  static ProcuringProject fromJson(Dict json) {
    return ProcuringProject(
      id: json['id'] as String? ?? '?',
      name: json['name'] as String? ?? '?',
    );
  }
}
