import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Information.dart';
import '../cbc/Reference.dart';
import '../cac/ApplicableAddress.dart';

// A class for describing the terms of a trade agreement.
class HaulageTradingTerms {


  // Text describing the terms of a trade agreement.
  final List<Information> information;

  // A reference quoting the basis of the terms
  final Reference? reference;

  // The address at which these trading terms apply.
  final ApplicableAddress? applicableAddress;

  HaulageTradingTerms ({
    this.information = const [],
    this.reference,
    this.applicableAddress,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'information': information.map((e) => e.toJson()).toList(),
      'reference': reference?.toJson(),
      'applicableAddress': applicableAddress?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static HaulageTradingTerms? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return HaulageTradingTerms (
      information: (json['information'] as List? ?? []).map((dynamic d) => Information.fromJson(d as Map<String, dynamic>?)!).toList(),
      reference: Reference.fromJson(json['reference'] as Map<String, dynamic>?),
      applicableAddress: ApplicableAddress.fromJson(json['applicableAddress'] as Map<String, dynamic>?),
    );
  }

  static HaulageTradingTerms? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return HaulageTradingTerms (
      information: null,
      reference: null,
      applicableAddress: null,
    );
  }

}

