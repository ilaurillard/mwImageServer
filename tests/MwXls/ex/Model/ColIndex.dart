import 'dart:math';

class ColIndex {
  final String name; // e.g. A or BZ
  late final int value; // 0 .. n

  ColIndex(
    this.name,
  ) {
    assert(name.contains(RegExp(r'^[A-Z]+$')));
    assert(name.length < 4);
    value = toNumber(name);
  }

  static ColIndex fromValue(
    int value, // 0..n
  ) {
    return ColIndex(toName(value));
  }

  static String toName(
    int index,
  ) {
    index++;
    String letters = '';
    while (index != 0) {
      int remainder = index % 26;
      if (remainder == 0) {
        remainder = 26;
      }
      String letter = String.fromCharCode(65 + remainder - 1);
      letters = letter + letters;
      index = (index - 1) ~/ 26;
    }
    return letters;
  }

  static int toNumber(
    String name,
  ) {
    int i = 0;
    int x = 0;
    for (int r in name.runes.toList().reversed) {
      int m = ((r - 64) * pow(26, x++)).toInt();
      i += m;
    }
    return i - 1;
  }

  @override
  String toString() {
    return name;
  }
}
