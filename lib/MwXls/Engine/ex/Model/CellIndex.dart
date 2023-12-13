import 'ColIndex.dart';

class CellIndex {
  final String name;

  late final ColIndex colIndex; // 0 .. n
  late final int rowIndex; // 0 .. n

  CellIndex(
    this.name, // e.g. AA52
  ) {
    String l = name.replaceAll(RegExp(r'[0-9]'), '');
    String n = name.replaceAll(RegExp(r'[A-Z]'), '');

    colIndex = ColIndex(l);
    rowIndex = int.parse(n) - 1;
  }

  static CellIndex fromColAndRow(
    ColIndex colIndex,
    int rowIndex, // 1..n
  ) {
    return CellIndex(
      colIndex.name + rowIndex.toString(),
    );
  }

  @override
  String toString() {
    return name;
  }

  static CellIndex max() {
    return fromColAndRow(
      ColIndex.fromValue(16383),
      1048570,
    );
  }
}
