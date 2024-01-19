import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:xml/src/xml/builder.dart';

class UniversalCommunication {
  final String? completeNumber;
  final Id? uriid;

  UniversalCommunication({
    this.completeNumber,
    this.uriid,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        if (completeNumber != null) {
          builder.element(
            'ram:CompleteNumber',
            nest: () {
              builder.text(completeNumber!);
            },
          );
        }
        if (uriid != null) {
          uriid!.toXml(builder, 'ram:URIID');
        }
      },
    );
  }
}
