import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
import 'package:xml/src/xml/builder.dart';

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
        Util.stringElement(builder, name, 'ram:Name');
      },
    );
  }
}
