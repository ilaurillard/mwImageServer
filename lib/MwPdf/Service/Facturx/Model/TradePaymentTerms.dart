import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/DateTime.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Util.dart';
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

  void toXml(XmlBuilder builder, String name) {
    builder.element(name, nest: () {
      Util.stringElement(builder, description, 'ram:Description');
      if (dueDate != null) {
        dueDate!.toXml(builder, 'ram:DueDateDateTime');
      }
      Util.stringElement(builder, directDebitMandateID, 'ram:DirectDebitMandateID');
    });
  }

  static TradePaymentTerms fromJson(Dict json) {
    return TradePaymentTerms(
      description: json['description'] as String?,
      dueDate: DateTime.fromJson(json['dueDate'] as Dict? ??{}),
      directDebitMandateID: json['directDebitMandateID'] as String?,
    );
  }
}
