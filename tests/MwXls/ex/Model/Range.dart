import 'CellIndex.dart';

class Range {
  final CellIndex c1;
  final CellIndex c2;

  Range(
    this.c1,
    this.c2,
  );

  @override
  String toString() {
    return '${c1.name}:${c2.name}';
  }
}
