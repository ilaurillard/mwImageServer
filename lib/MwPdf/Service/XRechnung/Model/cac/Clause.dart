import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cbc/Content.dart';

// A class to define a clause (a distinct article or provision) in a contract, treaty, will, or other formal or legal written document requiring compliance.
class Clause {


  // An identifier for this clause.
  final ID? iD;

  // The text of this clause.
  final List<Content> content;

  Clause ({
    this.iD,
    this.content = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'content': content.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  Clause fromJson(Map<String, dynamic> json) {
    return Clause (
    );
  }

}

