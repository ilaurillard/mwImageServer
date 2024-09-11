import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DateTime.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradePaymentTerms {
  final String? description;
  final DateTime? dueDate;
  final String? directDebitMandateID;

  TradePaymentTerms({
    this.description,
    this.dueDate,
    this.directDebitMandateID,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(name, nest: () {
      Util.stringElement(
        builder,
        description,
        'ram:Description',
      );
      if (dueDate != null) {
        dueDate!.toXml(
          builder,
          'ram:DueDateDateTime',
        );
      }
      Util.stringElement(
        builder,
        directDebitMandateID,
        'ram:DirectDebitMandateID',
      );
    });
  }

  static TradePaymentTerms? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return TradePaymentTerms(
      description: Util.innerTextOf(xml, 'ram:Description'),
      dueDate: DateTime.fromXml(
        xml.findElements('ram:DueDateDateTime').singleOrNull,
      ),
      directDebitMandateID: Util.innerTextOf(xml, 'ram:DirectDebitMandateID'),
    );
  }

  static TradePaymentTerms fromJson(
    Dict json,
  ) {
    return TradePaymentTerms(
      description: json['description'] as String?,
      dueDate: DateTime.fromJson(json['dueDate'] as Dict? ?? {}),
      directDebitMandateID: json['directDebitMandateID'] as String?,
    );
  }
}
