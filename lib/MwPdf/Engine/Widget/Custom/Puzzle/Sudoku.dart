import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class Sudoku {
  final String seed;
  final bool solve;
  final PdfColor color;
  final double line1Thickness;
  final double line2Thickness;
  final pw.TextStyle? textStyle;

  Sudoku({
    this.seed = '',
    this.solve = false,
    this.color = PdfColors.black,
    this.line1Thickness = 1.5,
    this.line2Thickness = 0.5,
    this.textStyle,
  });

  pw.Widget build() {
    // String seed = (gen.newSudoku.expand((sublist) => sublist).join());
    List<List<int>> sudoku;

    if (seed.isEmpty) {
      SudokuGenerator gen = SudokuGenerator(emptySquares: 54);
      sudoku = gen.newSudoku;
    } else {
      sudoku = _toList(seed);
      if (solve) {
        sudoku = SudokuSolver.solve(sudoku);
      }
    }

    return pw.Container(
      child: pw.GridView(
        childAspectRatio: 1,
        direction: pw.Axis.vertical,
        crossAxisCount: 3,
        children: [
          _section(sudoku[0]),
          _section(sudoku[1]),
          _section(sudoku[2]),
          _section(sudoku[3]),
          _section(sudoku[4]),
          _section(sudoku[5]),
          _section(sudoku[6]),
          _section(sudoku[7]),
          _section(sudoku[8]),
        ],
      ),
    );
  }

  pw.Widget _section(List<int> nums) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: color,
          width: line1Thickness * PdfPageFormat.mm,
        ),
      ),
      child: pw.GridView(
        childAspectRatio: 1,
        direction: pw.Axis.vertical,
        crossAxisCount: 3,
        children: [
          _field(nums[0]),
          _field(nums[1]),
          _field(nums[2]),
          _field(nums[3]),
          _field(nums[4]),
          _field(nums[5]),
          _field(nums[6]),
          _field(nums[7]),
          _field(nums[8]),
        ],
      ),
    );
  }

  pw.Widget _field(int num) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: color,
          width: line2Thickness * PdfPageFormat.mm,
        ),
      ),
      alignment: pw.Alignment.center,
      child: num > 0
          ? pw.Text(
              '$num',
              style: textStyle,
            )
          : pw.Container(),
    );
  }

  List<List<int>> _toList(
    String seed,
  ) {
    List<List<int>> result = [];
    for (int i = 0; i < seed.length; i += 9) {
      List<int> sublist = [];
      for (int j = 0; j < 9; j++) {
        sublist.add(int.parse(seed[i + j]));
      }
      result.add(sublist);
    }
    return result;
  }
}
