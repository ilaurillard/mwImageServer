import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/BinaryObject.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/FormattedDateTime.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class ReferencedDocument {
  final Id issuerAssignedID;
  final Id? uriid;
  final String? typeCode;
  final String? name;
  final BinaryObject? binaryObject;
  final FormattedDateTime? dateTime;

  ReferencedDocument({
    required this.issuerAssignedID,
    this.uriid,
    this.typeCode,
    this.name,
    this.binaryObject,
    this.dateTime,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        issuerAssignedID.toXml(
          builder,
          'ram:IssuerAssignedID',
        );
        if (uriid != null) {
          uriid!.toXml(
            builder,
            'ram:URIID',
          );
        }
        Util.stringElement(
          builder,
          typeCode,
          'ram:TypeCode',
        );
        Util.stringElement(
          builder,
          this.name,
          'ram:Name',
        );
        if (binaryObject != null) {
          binaryObject!.toXml(
            builder,
            'ram:AttachmentBinaryObject',
          );
        }
        if (dateTime != null) {
          dateTime!.toXml(
            builder,
            'ram:FormattedIssueDateTime',
          );
        }
      },
    );
  }

  static ReferencedDocument? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return ReferencedDocument(
      issuerAssignedID: Id.fromXml(
            xml.findElements('ram:IssuerAssignedID').singleOrNull,
          ) ??
          Id.empty(),
      uriid: Id.fromXml(
        xml.findElements('ram:URIID').singleOrNull,
      ),
      typeCode: xml.findElements('ram:TypeCode').singleOrNull?.innerText,
      name: xml.findElements('ram:Name').singleOrNull?.innerText,
      binaryObject: BinaryObject.fromXml(
        xml.findElements('ram:AttachmentBinaryObject').singleOrNull,
      ),
      dateTime: FormattedDateTime.fromXml(
        xml.findElements('ram:FormattedIssueDateTime').singleOrNull,
      ),
    );
  }

  static ReferencedDocument? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return ReferencedDocument(
        issuerAssignedID:
            Id.fromJson(json['issuerAssignedID'] as Dict? ?? {}) ?? Id.empty(),
        uriid: Id.fromJson(json['uriid'] as Dict? ?? {}),
        typeCode: json['typeCode'] as String?,
        name: json['name'] as String?,
        binaryObject:
            BinaryObject.fromJson(json['binaryObject'] as Dict? ?? {}),
        dateTime: FormattedDateTime.fromJson(json['dateTime'] as Dict? ?? {}),
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
