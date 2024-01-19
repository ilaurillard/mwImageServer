import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DateTime.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
import 'package:xml/src/xml/builder.dart';

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
}
