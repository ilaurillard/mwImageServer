import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwXls/Engine/Model/State.dart';
import 'package:mwcdn/MwXls/Engine/ex/Cell.dart';
import 'package:mwcdn/MwXls/Engine/ex/Excel.dart';
import 'package:mwcdn/MwXls/Engine/ex/Meta.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/CellStyle.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/RowStyle.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/SheetStyle.dart';
import 'package:mwcdn/MwXls/Engine/ex/Row.dart';
import 'package:mwcdn/MwXls/Engine/ex/Sheet.dart';
import 'package:mwcdn/MwXls/Engine/ex/Styles.dart';

class Engine {
  final String baseDir;
  final State state;
  final Excel excel;

  Engine({
    required this.baseDir,
    required this.state,
    required this.excel,
  });

  static Future<Engine> create(
    Dict json, {
    required String baseDir,
  }) async {
    Dict tmp = json['meta'] as Dict? ?? {};

    Dict rowStyles = tmp['rowStyles'] as Dict? ?? {};
    Dict cellStyles = tmp['cellStyles'] as Dict? ?? {};

    State state = State.fromJson(
      (json['sources'] as Dict?) ?? {},
      rowStyles: rowStyles,
      cellStyles: cellStyles,
      baseDir: baseDir,
    );
    // await state.init();

    Dict? defaultCellStyle = tmp['defaultCellStyle'] as Dict?;
    Dict? defaultRowStyle = tmp['defaultRowStyle'] as Dict?;

    List<Sheet> sheets = [];
    for (dynamic s in (json['sheets'] as List<dynamic>? ?? [])) {
      sheets.add(
        Sheet.fromJson(
          s as Dict? ?? {},
          state: state,
        ),
      );
    }

    return Engine(
      baseDir: baseDir,
      state: state,
      excel: Excel(
        meta: Meta.fromJson(
          json['meta'] as Dict? ?? {},
        ),
        sheets: sheets,
        styles: Styles(
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
        ),
      ),
    );
  }

  Excel xls() {
    return excel;

    // ColIndex c1 = ColIndex('AAA');
    // print(c1);
    // print(c1.value);
    //

    // ColIndex cx = ColIndex.fromValue(0);
    // print(cx);
    //
    // ColIndex c2 = ColIndex.fromValue(702);
    // print(c2);
    //
    // CellIndex c3 = CellIndex('A1');
    // print(c3);
    //
    // Range r = Range(
    //   CellIndex('A1'),
    //   CellIndex('C7'),
    // );
    // print(r);
    //
    // Cell c6 = Cell(index: CellIndex('C6'));
    // print(c6);
    //
    // CellIndex c8 = CellIndex.max();
    // print(c8);

    CellStyle headerBaseStyle = CellStyle(
      halign: HorizontalAlignment.center,
      valign: VerticalAlignment.bottom,
      applyAlignment: true,
      color: '#666',
      fill: '#F80',
      font: 'Helvetica',
      fontSize: 20,
      fontStyles: [FontStyle.bold, FontStyle.italic],
      borderSides: [BorderSide.bottom],
      borderStyle: BorderStyle.thick,
      borderColor: '#F00',
    );

    return Excel(
      meta: Meta(
        title: 'title',
        subject: 'subject',
        description: 'description',
        author: 'author',
        company: 'company',
        keywords: ['kw1', 'kw2'],
        fileName: 'testing234.xlsx',
      ),
      sheets: [
        Sheet(
          sheetStyle: SheetStyle(
            autoFilterRow: 1,
            // freezeColumns: 2,
            // freezeRows: 2,
            columnWidths: [30, 40, 25.5, 70, 0, 0, 30, 30],
            // cellStyles: [
            //   CellStyle(),
            //   CellStyle(),
            //   CellStyle(),
            //   CellStyle(),
            //   CellStyle(),
            //   CellStyle(),
            //   CellStyle(),
            //   CellStyle(),
            //   CellStyle(),
            // ],
          ),
          rows: [
            Row(
              defaultCellStyle: headerBaseStyle,
              style: RowStyle(
                customHeight: true,
                height: 30,
              ),
              cells: [
                Cell(value: 'col1'),
                Cell(value: 'col2'),
                Cell(value: 'col3'),
                Cell(
                  value: 'col4',
                  // style:
                  //     headerBaseStyle.copyWith(fontStyle: 'bold', color: '#000'),
                ),
                Cell(value: 'col5'),
                Cell(value: 'col6'),
                Cell(value: 'col7'),
                Cell(value: 'col8'),
                Cell(value: 'col9'),
              ],
            ),
            Row(
              // cellStyles: [
              //   null,
              //   null,
              //   CellStyle(),
              // ],
              cells: [
                Cell(value: 3),
                Cell(value: 'test'),
                Cell(value: 17.9),
                Cell(value: 30000),
                Cell(
                  value: '2017-02-03',
                  // style: CellStyle(),
                ),
                Cell(value: '5444'),
                Cell(value: true),
                Cell(value: false),
              ],
            ),
            Row(
              cells: [
                Cell(value: 3),
                null,
              ],
            ),
            Row(
              cells: [
                Cell(value: 3),
                null,
                null,
                null,
                null,
                null,
                Cell(value: 'test'),
                Cell(value: 'test'),
              ],
            ),
            Row(
              cells: [
                Cell(value: '=SUM(A2:A4)'),
                null,
                null,
                null,
                null,
                null,
                Cell(value: 'test'),
                Cell(value: 'test'),
              ],
            ),
          ],
        )
      ],
    );
  }
}
