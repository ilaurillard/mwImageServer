import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/LocaleCode.dart';

// A class to describe a language.
class Language {


  // An identifier for this language.
  final ID? iD;

  // The name of this language.
  final Name? name;

  // A code signifying the locale in which this language is used.
  final LocaleCode? localeCode;

  Language ({
    this.iD,
    this.name,
    this.localeCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'name': name?.toJson(),
     'localeCode': localeCode?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  Language fromJson(Map<String, dynamic> json) {
    return Language (
    );
  }

}

