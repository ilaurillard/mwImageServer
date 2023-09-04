import 'dart:math';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetEnums.dart';

class PdfWidgetChart {

  static pw.Chart parseChart(
    Dict json,
  ) {
    // TODO

    const dataTable = [
      ['Phone', 80, 95, 1.3, 2],
      ['Internet', 250, 230, 2.8, 3],
      ['Electricity', 300, 375, 4.1, 2],
      ['Movies', 85, 80, 4, 1.5],
      ['Food', 300, 350, 2.5, 1, 8],
      ['Fuel', 650, 550, 0.6, 0.2],
      ['Insurance', 250, 310, 1.4, 1.5],
    ];

    const dataTable2 = [
      [12],
      [12],
      [17],
      [22],
      [17],
      [12],
      [17],
      [12],
    ];

    const chartColors = [
      PdfColors.blue300,
      PdfColors.green300,
      PdfColors.amber300,
      PdfColors.pink300,
      PdfColors.cyan300,
      PdfColors.purple300,
      PdfColors.lime300,
    ];

    final expense = dataTable
        .map((e) => e[2] as num)
        .reduce((value, element) => value + element);

    // TODO
    return pw.Chart(
      grid: parseChartGrid(json['grid'] as Dict? ?? {}),
      overlay: PdfWidget.parseWidget(json['overlay'] as Dict? ?? {}),
      title: PdfWidget.parseWidget(json['title'] as Dict? ?? {}),
      bottom: PdfWidget.parseWidget(json['bottom'] as Dict? ?? {}),
      left: PdfWidget.parseWidget(json['left'] as Dict? ?? {}),
      right: PdfWidget.parseWidget(json['right'] as Dict? ?? {}),

      // CartesianGrid
      // datasets: [
        // pw.BarDataSet(
        //   color: PdfColors.blue200,
        //   legend: 'Xxx',
        //   width: 10,
        //   offset: 10,
        //   borderColor: PdfColors.green300,
        //   data: List<pw.PointChartValue>.generate(
        //     dataTable.length,
        //     (int index) {
        //       final double value =
        //           double.tryParse((dataTable[index][3] as num).toString()) ??
        //               0.0;
        //       return pw.PointChartValue(
        //         index.toDouble(),
        //         value + 2,
        //       );
        //     },
        //   ),
        // ),
      //   pw.LineDataSet(
      //     legend: 'Expense',
      //     drawSurface: true,
      //     isCurved: true,
      //     drawPoints: false,
      //     color: PdfColors.blue300,
      //     data: List<pw.PointChartValue>.generate(
      //       dataTable.length,
      //       (int index) {
      //         final double value =
      //             double.tryParse((dataTable[index][3] as num).toString()) ??
      //                 0.0;
      //         return pw.PointChartValue(
      //           index.toDouble(),
      //           value,
      //         );
      //       },
      //     ),
      //   ),
      //   pw.LineDataSet(
      //     legend: 'yyy',
      //     drawSurface: false,
      //     isCurved: false,
      //     drawPoints: true,
      //     color: PdfColors.red300,
      //     data: List<pw.PointChartValue>.generate(
      //       dataTable.length,
      //       (int index) {
      //         final double value =
      //             double.tryParse((dataTable[index][4] as num).toString()) ??
      //                 0.0;
      //         return pw.PointChartValue(
      //           index.toDouble(),
      //           value,
      //         );
      //       },
      //     ),
      //   ),
      // ],

      // -------------

      // PieGrid
      datasets: List<pw.Dataset>.generate(
        dataTable.length,
        (int index) {
          final List<Object> data = dataTable[index];
          final PdfColor color = chartColors[index % chartColors.length];
          final double value = (data[2] as num).toDouble();
          final int pct = (value / expense * 100).round();
          return pw.PieDataSet(
            legend: '${data[0]}\n$pct%',
            value: value,
            color: color,
            legendStyle: const pw.TextStyle(fontSize: 10),
          );
        },
      ),

      // ----

      // RadialGrid (experimental)
      // datasets: [
      //     pw.LineDataSet(
      //       drawSurface: true,
      //       // isCurved: true,
      //       // drawPoints: true,
      //       color: PdfColors.red300,
      //       data: List<pw.PointChartValue>.generate(
      //         dataTable2.length,
      //         (int index) {
      //           final double value =
      //               double.tryParse((dataTable2[index][0] as num).toString()) ??
      //                   0.0;
      //           return pw.PointChartValue(
      //             index.toDouble(),
      //             value,
      //           );
      //         },
      //       ),
      //     ),
      // ],


    );
  }

  static pw.ChartGrid parseChartGrid(
    Dict json,
  ) {
    MapEntry<String, dynamic> widget = json.entries.first;

    String key = widget.key;
    Dict data = widget.value as Dict;

    print('W: $key');

    switch (key) {
      case 'CartesianGrid':
        return parseCartesianGrid(data);
      case 'PieGrid':
        return parsePieGrid(data);
      case 'RadialGrid':
        return parseRadialGrid(data);
    }

    throw Exception('Parsing chart grid failed');
  }

  static pw.PieGrid parsePieGrid(
    Dict json,
  ) {
    return pw.PieGrid(
      startAngle: double.tryParse(json['startAngle'].toString()) ?? 0.0,
    );
  }

  static pw.RadialGrid parseRadialGrid(
    Dict json,
  ) {
    return pw.RadialGrid();
  }

  static pw.CartesianGrid parseCartesianGrid(
    Dict json,
  ) {
    return pw.CartesianGrid(
      xAxis: parseGridAxis(json['xAxis'] as List<dynamic>? ?? []),
      yAxis: parseGridAxis(json['yAxis'] as List<dynamic>? ?? []),
    );
  }

  static pw.FixedAxis parseGridAxis(
    List<dynamic> json,
  ) {
    // TODO
    return pw.FixedAxis(
      [
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
      ],
    );
  }

  static pw.ChartLegend parseChartLegend(
      Dict json,
      ) {
    // TODO
    return pw.ChartLegend(
      position: PdfWidgetEnums.parseAlignment(
        json['position'] as String?,
      ) ?? pw.Alignment.topRight,
    );
  }
}
