import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DateTime.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class SupplyChainEvent {
  final DateTime date;

  SupplyChainEvent({
    required this.date,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        date.toXml(
          builder,
          'ram:OccurrenceDateTime',
        );
      },
    );
  }

  static SupplyChainEvent? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return SupplyChainEvent(
      date: DateTime.fromXml(
            xml.findElements('ram:OccurrenceDateTime').singleOrNull,
          ) ??
          DateTime.empty(),
    );
  }

  static SupplyChainEvent? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return SupplyChainEvent(
        date:
            DateTime.fromJson(json['date'] as Dict? ?? {}) ?? DateTime.empty(),
      );
    }
    return null;
  }
}
