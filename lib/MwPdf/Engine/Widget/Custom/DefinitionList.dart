import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Datasource.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget.dart';

class DefinitionList {
  static pw.Widget list(
    Dict json,
    State state,
  ) {
    List<List<dynamic>> values = (json['values'] as List<dynamic>? ?? [])
        .map(
          (dynamic row) => row as List<dynamic>,
        )
        .toList();
    if (values.isEmpty) {
      Datasource source = state.source(
        json['source'] as String?,
      );
      values = source.valuesFormatted;
    }

    List<pw.TableRow> rows = [];

    for (List<dynamic> rowData in values) {
      // ---------------
      String val1 = rowData.isNotEmpty ? rowData[0].toString() : '';
      state.prepareCell(
        0,
        val1,
      );
      pw.Widget childType = pw.Text(
        state.replaceParameters(val1),
      );
      if (json['childType'] != null) {
        childType = Widget.parse(
          json['childType'] as Dict? ?? {},
          state,
        );
      }
      // ---------------
      String val2 = rowData.length > 1 ? rowData[1].toString() : '';
      state.prepareCell(
        1,
        val2,
      );
      pw.Widget childData = pw.Text(
          state.replaceParameters(val2),
      );
      if (json['childData'] != null) {
        childData = Widget.parse(
          json['childData'] as Dict? ?? {},
          state,
        );
      }
      // ---------------
      rows.add(
        pw.TableRow(
          verticalAlignment: pw.TableCellVerticalAlignment.top,
          children: [childType, childData],
        ),
      );
    }

    return pw.Table(
      columnWidths: {
        0: pw.FlexColumnWidth(
          double.tryParse(json['flexType'].toString()) ?? 1.0,
        ),
        1: pw.FlexColumnWidth(
          double.tryParse(json['flexData'].toString()) ?? 1.0,
        ),
      },
      children: rows,
    );
  }
}
