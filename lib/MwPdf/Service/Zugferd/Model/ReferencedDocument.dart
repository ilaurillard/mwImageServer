import 'package:mwcdn/MwPdf/Service/Zugferd/Model/BinaryObject.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/FormattedDateTime.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
import 'package:xml/src/xml/builder.dart';

class ReferencedDocument {
  final Id issuerAssignedID;
  final Id? uriid;
  final String? typeCode;
  final String? name;
  final BinaryObject? attachmentBinaryObject;
  final FormattedDateTime? formattedIssueDateTime;

  ReferencedDocument({
    required this.issuerAssignedID,
    this.uriid,
    this.typeCode,
    this.name,
    this.attachmentBinaryObject,
    this.formattedIssueDateTime,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        issuerAssignedID.toXml(builder, 'ram:IssuerAssignedID');
        if (uriid != null) {
          uriid!.toXml(builder, 'ram:URIID');
        }
        Util.stringElement(builder, typeCode, 'ram:TypeCode');
        Util.stringElement(builder, name, 'ram:Name');
        if (attachmentBinaryObject != null) {
          attachmentBinaryObject!.toXml(builder, 'ram:AttachmentBinaryObject');
        }
        if (formattedIssueDateTime != null) {
          formattedIssueDateTime!.toXml(builder, 'ram:FormattedIssueDateTime');
        }
      },
    );
  }
}
