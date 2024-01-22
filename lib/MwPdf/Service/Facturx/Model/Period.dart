import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/DateTime.dart';
import 'package:xml/xml.dart';

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

  static Period? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return Period(
        startDatetime:
            DateTime.fromJson(json['startDatetime'] as Dict? ?? {}) ??
                DateTime.empty(),
        endDatetime: DateTime.fromJson(json['endDatetime'] as Dict? ?? {}) ??
            DateTime.empty(),
      );
    }
    return null;
  }
}
