import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DateTime.dart';
import 'package:xml/xml.dart';

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

  static SupplyChainEvent? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return SupplyChainEvent(
        date: DateTime.fromJson(json['date'] as Dict? ?? {}),
      );
    }
    return null;
  }
}
