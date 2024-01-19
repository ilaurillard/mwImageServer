import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DateTime.dart';
import 'package:xml/src/xml/builder.dart';

class SupplyChainEvent {
  final DateTime date;

  SupplyChainEvent({
    required this.date,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        date.toXml(builder, 'ram:OccurrenceDateTime');
      },
    );
  }
}
