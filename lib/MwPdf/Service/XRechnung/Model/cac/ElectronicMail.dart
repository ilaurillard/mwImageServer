// A character string (i.e. a finite set of characters), generally in the form of words of a language.
class ElectronicMail {

  final String value; // (string)

  // The identifier of the language used in the content component.
  final String? languageID; // (language)

  // The identification of the locale of the language.
  final String? languageLocaleID; // (normalizedString)

  ElectronicMail ({
    required this.value,
    this.languageID,
    this.languageLocaleID,
  });
}

