class CharacterSet {
  static const int utf8 = 1;
  static const int iso8859_1 = 2;
  static const int iso8859_2 = 3;
  static const int iso8859_4 = 4;
  static const int iso8859_5 = 5;
  static const int iso8859_7 = 6;
  static const int iso8859_10 = 7;
  static const int iso8859_15 = 8;

  static const List<int> valid = [
    utf8,
    iso8859_1,
    iso8859_2,
    iso8859_4,
    iso8859_5,
    iso8859_7,
    iso8859_10,
    iso8859_15,
  ];
}