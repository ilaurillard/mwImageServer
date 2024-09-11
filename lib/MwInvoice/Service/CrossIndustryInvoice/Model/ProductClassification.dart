import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CodeType.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class ProductClassification {
  final CodeType classCode;

  ProductClassification({
    required this.classCode,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        classCode.toXml(
          builder,
          'ram:ClassCode',
        );
      },
    );
  }

  static ProductClassification? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return ProductClassification(
      classCode: CodeType.fromXml(
        xml.findElements('ram:ClassCode').singleOrNull,
      )!,
    );
  }

  static ProductClassification? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return ProductClassification(
        classCode: CodeType.fromJson(
          json['classCode'] as Dict? ?? {},
        )!,
      );
    }
    return null;
  }
}
