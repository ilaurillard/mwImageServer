import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/BinaryObject.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/FormattedDateTime.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:xml/xml.dart';

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
        Util.stringElement(builder, this.name, 'ram:Name');
        if (attachmentBinaryObject != null) {
          attachmentBinaryObject!.toXml(builder, 'ram:AttachmentBinaryObject');
        }
        if (formattedIssueDateTime != null) {
          formattedIssueDateTime!.toXml(builder, 'ram:FormattedIssueDateTime');
        }
      },
    );
  }

  static ReferencedDocument? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return ReferencedDocument(
        issuerAssignedID:
            Id.fromJson(json['issuerAssignedID'] as Dict? ?? {}) ?? Id.empty(),
        uriid: Id.fromJson(json['uriid'] as Dict? ?? {}),
        typeCode: json['typeCode'] as String?,
        name: json['name'] as String?,
        attachmentBinaryObject: BinaryObject.fromJson(
            json['attachmentBinaryObject'] as Dict? ?? {}),
        formattedIssueDateTime: FormattedDateTime.fromJson(
            json['formattedIssueDateTime'] as Dict? ?? {}),
      );
    }
    return null;
  }

  static ReferencedDocument empty() {
    return ReferencedDocument(
      issuerAssignedID: Id.empty(),
    );
  }
}
