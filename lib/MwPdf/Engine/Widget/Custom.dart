import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Datasource.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Config.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/ConfigDay.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/ConfigLane.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/CustomCalendar.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Etc/Snip.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Puzzle/Maze.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Puzzle/Suchsel.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Puzzle/Sudoku.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Custom/Puzzle/Kakuro.dart';
import 'Util.dart';

enum PuzzleType {
  sudoku,
  maze,
  suchsel,
  kakuro,
}

class Custom {
  static pw.Widget snip(
    Dict json,
    State state,
  ) {
    return Snip.build(
      padding: Util.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      offset: double.tryParse(json['offset'].toString()) ?? 20,
      direction: Util.axis(json['direction'] as String?) ?? pw.Axis.vertical,
    );
  }

  static pw.Widget puzzle(
    Dict json,
    State state,
  ) {
    PdfColor color = Util.color(json['color'] as String?) ?? PdfColors.black;
    double? line1 = double.tryParse(json['line1'].toString());
    double? line2 = double.tryParse(json['line2'].toString());
    pw.TextStyle? ts = Util.textStyle(
      json['textStyle'] as Dict? ?? {},
      state,
    );
    String seed = json['seed'] as String? ?? '';
    bool solve = json['solve'] as bool? ?? false;
    int size = int.tryParse(json['size'].toString()) ?? 1;
    int difficulty = int.tryParse(json['difficulty'].toString()) ?? 5;

    PuzzleType? type = Custom.puzzleType(
      json['type'] as String?,
    );

    Datasource source = state.source(
      json['source'] as String?,
    );

    switch (type) {
      case PuzzleType.suchsel:
        return Suchsel(
          size: size,
          solve: solve,
          seed: seed,
          color: color,
          line1Thickness: line1 ?? 1.5,
          line2Thickness: line2 ?? 0.5,
          textStyle: ts,
          source: source,
        ).build();
      case PuzzleType.sudoku:
        return Sudoku(
          seed: seed,
          solve: solve,
          color: color,
          line1Thickness: line1 ?? 1.5,
          line2Thickness: line2 ?? 0.5,
          textStyle: ts,
          difficulty: difficulty,
        ).build();
      case PuzzleType.maze:
        return Maze(
          size: size,
          seed: seed,
          solve: solve,
          color: color,
          line1Thickness: line1 ?? 1.5,
          line2Thickness: line2 ?? 0.5,
          textStyle: ts,
        ).build();
      case PuzzleType.kakuro:
        return Kakuro(
          size: size,
          solve: solve,
          color: color,
          textStyle: ts,
          line1Thickness: line1 ?? 0.5,
          line2Thickness: line2 ?? 0.25,
        ).build();
      case null:
        return pw.SizedBox();
    }
  }

  static PuzzleType? puzzleType(
    String? json,
  ) {
    switch (json) {
      case 'sudoku':
        return PuzzleType.sudoku;
      case 'maze':
        return PuzzleType.maze;
      case 'suchsel':
        return PuzzleType.suchsel;
      case 'kakuro':
        return PuzzleType.kakuro;
    }
    return null;
  }

  static pw.Widget calendar(
    Dict json,
    State state,
  ) {
    Datasource source = state.source(
      json['source'] as String?,
    );

    return CustomCalendar(
      year: int.tryParse(json['year'].toString()) ?? 2024,
      month: int.tryParse(json['month'].toString()) ?? 1,
      day: int.tryParse(json['day'].toString()) ?? 1,
      entries: Entries.fromJson(source.data),
      config: Config(
        days: 7,
        // highlightToday: false,
        lane: ConfigLane(),
        day: ConfigDay(
          heightHour: 8 * PdfPageFormat.mm,
        ),
      ),
      mode: CustomCalendar.parseMode(
        json['mode'] as String? ?? '',
      ),
    ).build();
  }

  static pw.Widget doublePage(
      Dict json,
      State state,
      ) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: Widget.parse(
            json['child1'] as Dict? ?? {},
            state,
          ),
        ),
        pw.Expanded(
          child: Widget.parse(
            json['child2'] as Dict? ?? {},
            state,
          ),
        ),
      ],
    );
  }
}
