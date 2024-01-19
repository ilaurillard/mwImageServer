import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DateTime.dart';
import 'package:xml/src/xml/builder.dart';

class Period {
  final DateTime startDatetime;
  final DateTime endDatetime;

  Period({
    required this.startDatetime,
    required this.endDatetime,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        startDatetime.toXml(builder, 'ram:StartDateTime');
        endDatetime.toXml(builder, 'ram:EndDateTime');
      },
    );
  }
}
