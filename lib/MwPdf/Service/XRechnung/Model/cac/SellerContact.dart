import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/JobTitle.dart';
import '../cbc/Department.dart';
import '../cbc/Telephone.dart';
import '../cbc/Telefax.dart';
import '../cbc/ElectronicMail.dart';
import '../cbc/Note.dart';
import '../cac/OtherCommunication.dart';

// A class to describe a contactable person or department in an organization.
class SellerContact {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this contact.
  final ID? iD;

  // The name of this contact. It is recommended that this be used for a functional name and not a personal name.
  final Name? name;

  // The job title or function of this contact
  final JobTitle? jobTitle;

  // The department where this contact works
  final Department? department;

  // The primary telephone number of this contact.
  final Telephone? telephone;

  // The primary fax number of this contact.
  final Telefax? telefax;

  // The primary email address of this contact.
  final ElectronicMail? electronicMail;

  // Free-form text conveying information that is not contained explicitly in other structures; in particular, a textual description of the circumstances under which this contact can be used (e.g., "emergency" or "after hours").
  final List<Note> note;

  // Another means of communication with this contact.
  final List<OtherCommunication> otherCommunication;

  SellerContact ({
    this.uBLExtensions,
    this.iD,
    this.name,
    this.jobTitle,
    this.department,
    this.telephone,
    this.telefax,
    this.electronicMail,
    this.note = const [],
    this.otherCommunication = const [],
  });

  static SellerContact? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SellerContact (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      jobTitle: JobTitle.fromJson(json['jobTitle'] as Map<String, dynamic>?),
      department: Department.fromJson(json['department'] as Map<String, dynamic>?),
      telephone: Telephone.fromJson(json['telephone'] as Map<String, dynamic>?),
      telefax: Telefax.fromJson(json['telefax'] as Map<String, dynamic>?),
      electronicMail: ElectronicMail.fromJson(json['electronicMail'] as Map<String, dynamic>?),
      note: (json['note'] as List? ?? []).map((dynamic d) => Note.fromJson(d as Map<String, dynamic>?)!).toList(),
      otherCommunication: (json['otherCommunication'] as List? ?? []).map((dynamic d) => OtherCommunication.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'jobTitle': jobTitle?.toJson(),
      'department': department?.toJson(),
      'telephone': telephone?.toJson(),
      'telefax': telefax?.toJson(),
      'electronicMail': electronicMail?.toJson(),
      'note': note.map((e) => e.toJson()).toList(),
      'otherCommunication': otherCommunication.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static SellerContact? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SellerContact (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      jobTitle: JobTitle.fromXml(xml.findElements('cbc:JobTitle').singleOrNull),
      department: Department.fromXml(xml.findElements('cbc:Department').singleOrNull),
      telephone: Telephone.fromXml(xml.findElements('cbc:Telephone').singleOrNull),
      telefax: Telefax.fromXml(xml.findElements('cbc:Telefax').singleOrNull),
      electronicMail: ElectronicMail.fromXml(xml.findElements('cbc:ElectronicMail').singleOrNull),
      note: xml.findElements('cbc:Note').map((XmlElement e) => Note.fromXml(e)!).toList(),
      otherCommunication: xml.findElements('cac:OtherCommunication').map((XmlElement e) => OtherCommunication.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      name?.toXml(),
      jobTitle?.toXml(),
      department?.toXml(),
      telephone?.toXml(),
      telefax?.toXml(),
      electronicMail?.toXml(),
      ...note.map((Note e) => e.toXml()).toList(),
      ...otherCommunication.map((OtherCommunication e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'SellerContact',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

