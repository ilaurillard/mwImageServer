import 'dart:convert';
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

}

