import 'dart:io';

import 'package:path/path.dart';

import 'ex/Cell.dart';
import 'ex/Excel.dart';
import 'ex/Meta.dart';
import 'ex/Model/CellStyle.dart';
import 'ex/Model/RowStyle.dart';
import 'ex/Model/SheetStyles.dart';
import 'ex/Row.dart';
import 'ex/Sheet.dart';

Future<void> main() async {
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
    fontStyle: 'italic,bold',
    borderSides: [BorderSide.bottom],
    borderStyle: BorderStyle.thick,
    borderColor: '#F00',
  );

  Excel ex = Excel(
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
        sheetStyles: SheetStyles(
            autoFilterRow: 1,
            // freezeColumns: 2,
            // freezeRows: 2,
            colWidths: [30, 40, 25.5, 70, 0, 0, 30, 30],
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

  List<int> fileBytes = await ex.save();

  String outputFile = ex.meta.fileName;
  File(
    join(outputFile),
  )
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes);
}
