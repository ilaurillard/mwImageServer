import '../cac/ID.dart';
import '../cac/Name.dart';
import '../cac/LocaleCode.dart';

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
}

