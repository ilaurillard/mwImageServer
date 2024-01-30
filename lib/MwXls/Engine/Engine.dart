import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwXls/Engine/Model/State.dart';
import 'package:mwcdn/MwXls/Engine/Storage.dart';
import 'package:mwcdn/MwXls/Engine/ex/Excel.dart';
import 'package:mwcdn/MwXls/Engine/ex/Meta.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/CellStyle.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/RowStyle.dart';
import 'package:mwcdn/MwXls/Engine/ex/Sheet.dart';
import 'package:mwcdn/MwXls/Engine/ex/Styles.dart';

class Engine {
  final String resDir;
  final State state;
  final Excel excel;

  Engine({
    required this.resDir,
    required this.state,
    required this.excel,
  });

  static Future<Engine> create(
    Dict json, {
    required String resDir,
    required Storage storage,
  }) async {
    Dict meta = json['meta'] as Dict? ?? {};

    State state = _state(
      meta,
      (json['sources'] as Dict?) ?? {},
      resDir: resDir,
      storage: storage,
    );

    return Engine(
      resDir: resDir,
      state: state,
      excel: Excel(
        meta: Meta.fromJson(
          json['meta'] as Dict? ?? {},
        ),
        sheets: _sheets(
          json['sheets'] as List<dynamic>? ?? [],
          state,
        ),
        styles: _styles(
          meta,
          state,
        ),
      ),
    );
  }

  // Excel xls() {
  //   return excel;
  //
  //   // ColIndex c1 = ColIndex('AAA');
  //   // print(c1);
  //   // print(c1.value);
  //   //
  //
  //   // ColIndex cx = ColIndex.fromValue(0);
  //   // print(cx);
  //   //
  //   // ColIndex c2 = ColIndex.fromValue(702);
  //   // print(c2);
  //   //
  //   // CellIndex c3 = CellIndex('A1');
  //   // print(c3);
  //   //
  //   // Range r = Range(
  //   //   CellIndex('A1'),
  //   //   CellIndex('C7'),
  //   // );
  //   // print(r);
  //   //
  //   // Cell c6 = Cell(index: CellIndex('C6'));
  //   // print(c6);
  //   //
  //   // CellIndex c8 = CellIndex.max();
  //   // print(c8);
  //
  //   CellStyle headerBaseStyle = CellStyle(
  //     halign: HorizontalAlignment.center,
  //     valign: VerticalAlignment.bottom,
  //     applyAlignment: true,
  //     color: '#666',
  //     fill: '#F80',
  //     font: 'Helvetica',
  //     fontSize: 20,
  //     fontStyles: [FontStyle.bold, FontStyle.italic],
  //     borderSides: [BorderSide.bottom],
  //     borderStyle: BorderStyle.thick,
  //     borderColor: '#F00',
  //   );
  //
  //   return Excel(
  //     meta: Meta(
  //       title: 'title',
  //       subject: 'subject',
  //       description: 'description',
  //       author: 'author',
  //       company: 'company',
  //       keywords: ['kw1', 'kw2'],
  //       fileName: 'testing234.xlsx',
  //     ),
  //     sheets: [
  //       Sheet(
  //         sheetStyle: SheetStyle(
  //           autoFilterRow: 1,
  //           // freezeColumns: 2,
  //           // freezeRows: 2,
  //           columnWidths: [30, 40, 25.5, 70, 0, 0, 30, 30],
  //           // cellStyles: [
  //           //   CellStyle(),
  //           //   CellStyle(),
  //           //   CellStyle(),
  //           //   CellStyle(),
  //           //   CellStyle(),
  //           //   CellStyle(),
  //           //   CellStyle(),
  //           //   CellStyle(),
  //           //   CellStyle(),
  //           // ],
  //         ),
  //         rows: [
  //           Row(
  //             defaultCellStyle: headerBaseStyle,
  //             style: RowStyle(
  //               customHeight: true,
  //               height: 30,
  //             ),
  //             cells: [
  //               Cell(value: 'col1'),
  //               Cell(value: 'col2'),
  //               Cell(value: 'col3'),
  //               Cell(
  //                 value: 'col4',
  //                 // style:
  //                 //     headerBaseStyle.copyWith(fontStyle: 'bold', color: '#000'),
  //               ),
  //               Cell(value: 'col5'),
  //               Cell(value: 'col6'),
  //               Cell(value: 'col7'),
  //               Cell(value: 'col8'),
  //               Cell(value: 'col9'),
  //             ],
  //           ),
  //           Row(
  //             // cellStyles: [
  //             //   null,
  //             //   null,
  //             //   CellStyle(),
  //             // ],
  //             cells: [
  //               Cell(value: 3),
  //               Cell(value: 'test'),
  //               Cell(value: 17.9),
  //               Cell(value: 30000),
  //               Cell(
  //                 value: '2017-02-03',
  //                 // style: CellStyle(),
  //               ),
  //               Cell(value: '5444'),
  //               Cell(value: true),
  //               Cell(value: false),
  //             ],
  //           ),
  //           Row(
  //             cells: [
  //               Cell(value: 3),
  //               null,
  //             ],
  //           ),
  //           Row(
  //             cells: [
  //               Cell(value: 3),
  //               null,
  //               null,
  //               null,
  //               null,
  //               null,
  //               Cell(value: 'test'),
  //               Cell(value: 'test'),
  //             ],
  //           ),
  //           Row(
  //             cells: [
  //               Cell(value: '=SUM(A2:A4)'),
  //               null,
  //               null,
  //               null,
  //               null,
  //               null,
  //               Cell(value: 'test'),
  //               Cell(value: 'test'),
  //             ],
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }

  static Styles _styles(
    Dict meta,
    State state,
  ) {
    Dict? defaultCellStyle = meta['defaultCellStyle'] as Dict?;
    Dict? defaultRowStyle = meta['defaultRowStyle'] as Dict?;
    return Styles(
      defaultCellStyle: defaultCellStyle != null
          ? CellStyle.fromJson(
              defaultCellStyle,
              state: state,
            )
          : null,
      defaultRowStyle: defaultRowStyle != null
          ? RowStyle.fromJson(
              defaultRowStyle,
              state: state,
            )
          : null,
    );
  }

  static State _state(
    Dict meta,
    Dict sources, {
    required String resDir,
    required Storage storage,
  }) {
    Dict rowStyles = meta['rowStyles'] as Dict? ?? {};
    Dict cellStyles = meta['cellStyles'] as Dict? ?? {};
    return State.fromJson(
      sources,
      rowStyles: rowStyles,
      cellStyles: cellStyles,
      resDir: resDir,
      storage: storage,
    );
  }

  static List<Sheet> _sheets(
    List<dynamic> data,
    State state,
  ) {
    List<Sheet> sheets = [];
    for (dynamic sheet in data) {
      sheets.add(
        Sheet.fromJson(
          sheet as Dict? ?? {},
          state: state,
        ),
      );
    }
    return sheets;
  }
}
