// A character string that constitutes the distinctive designation of a person, place, thing or concept.
class BrandName {

  final String value; // (string)

  // The identifier of the language used in the content component.
  final String? languageID; // (language)

  // The identification of the locale of the language.
  final String? languageLocaleID; // (normalizedString)

  BrandName ({
    required this.value,
    this.languageID,
    this.languageLocaleID,
  });
}

