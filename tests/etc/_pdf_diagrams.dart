// import 'package:test/test.dart';

import 'dart:io';
import 'dart:math';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> main() async {
  PdfPageFormat pageFormat = PdfPageFormat.a4;

  // ###########################################

  const tableHeaders = ['Category', 'Budget', 'Expense', 'Result'];

  const dataTable = [
    ['Phone', 80, 95],
    ['Internet', 250, 230],
    ['Electricity', 300, 375],
    ['Movies', 85, 80],
    ['Food', 300, 350],
    ['Fuel', 650, 550],
    ['Insurance', 250, 310],
  ];

  // Some summary maths
  final budget = dataTable
      .map((e) => e[1] as num)
      .reduce((value, element) => value + element);
  final expense = dataTable
      .map((e) => e[2] as num)
      .reduce((value, element) => value + element);

  const baseColor = PdfColors.cyan;

  // Create a PDF document.
  final document = pw.Document();

  final theme = pw.ThemeData.withFont(
    base: pw.Font.helvetica(),
    // base: await PdfGoogleFonts.openSansRegular(),
    // bold: await PdfGoogleFonts.openSansBold(),
  );

  // Top bar chart
  final chart1 = pw.Chart(
    left: pw.Container(
      alignment: pw.Alignment.topCenter,
      margin: const pw.EdgeInsets.only(right: 5, top: 10),
      child: pw.Transform.rotateBox(
        angle: pi / 2,
        child: pw.Text('Amount'),
      ),
    ),
    overlay: pw.ChartLegend(
      position: const pw.Alignment(-.7, 1),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        border: pw.Border.all(
          color: PdfColors.black,
          width: .5,
        ),
      ),
    ),
    grid: pw.CartesianGrid(
      xAxis: pw.FixedAxis.fromStrings(
        List<String>.generate(
            dataTable.length, (index) => dataTable[index][0] as String),
        marginStart: 30,
        marginEnd: 30,
        ticks: true,
      ),
      yAxis: pw.FixedAxis(
        [0, 100, 200, 300, 400, 500, 600, 700],
        format: (v) => '\$$v',
        divisions: true,
      ),
    ),
    datasets: [
      pw.BarDataSet(
        color: PdfColors.blue100,
        legend: tableHeaders[2],
        width: 15,
        offset: -10,
        borderColor: baseColor,
        data: List<pw.PointChartValue>.generate(
          dataTable.length,
          (i) {
            final v = dataTable[i][2] as num;
            return pw.PointChartValue(i.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.BarDataSet(
        color: PdfColors.amber100,
        legend: tableHeaders[1],
        width: 15,
        offset: 10,
        borderColor: PdfColors.amber,
        data: List<pw.PointChartValue>.generate(
          dataTable.length,
          (i) {
            final v = dataTable[i][1] as num;
            return pw.PointChartValue(i.toDouble(), v.toDouble());
          },
        ),
      ),
    ],
  );

  // Left curved line chart
  final chart2 = pw.Chart(
    right: pw.ChartLegend(),
    grid: pw.CartesianGrid(
      xAxis: pw.FixedAxis([0, 1, 2, 3, 4, 5, 6]),
      yAxis: pw.FixedAxis(
        [0, 200, 400, 600],
        divisions: true,
      ),
    ),
    datasets: [
      pw.LineDataSet(
        legend: 'Expense',
        drawSurface: true,
        isCurved: true,
        drawPoints: false,
        color: baseColor,
        data: List<pw.PointChartValue>.generate(
          dataTable.length,
          (i) {
            final v = dataTable[i][2] as num;
            return pw.PointChartValue(i.toDouble(), v.toDouble());
          },
        ),
      ),
    ],
  );

  // Data table
  final table = pw.TableHelper.fromTextArray(
    border: null,
    headers: tableHeaders,
    data: List<List<dynamic>>.generate(
      dataTable.length,
      (index) => <dynamic>[
        dataTable[index][0],
        dataTable[index][1],
        dataTable[index][2],
        (dataTable[index][1] as num) - (dataTable[index][2] as num),
      ],
    ),
    headerStyle: pw.TextStyle(
      color: PdfColors.white,
      fontWeight: pw.FontWeight.bold,
    ),
    headerDecoration: const pw.BoxDecoration(
      color: baseColor,
    ),
    rowDecoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: baseColor,
          width: .5,
        ),
      ),
    ),
    cellAlignment: pw.Alignment.centerRight,
    cellAlignments: {0: pw.Alignment.centerLeft},
  );

  // Add page to the PDF
  document.addPage(
    pw.Page(
      pageFormat: pageFormat,
      theme: theme,
      build: (context) {
        // Page layout
        return pw.Column(
          children: [
            pw.Text('Budget Report',
                style: const pw.TextStyle(
                  color: baseColor,
                  fontSize: 40,
                )),
            pw.Divider(thickness: 4),
            pw.Expanded(flex: 3, child: chart1),
            pw.Divider(),
            pw.Expanded(flex: 2, child: chart2),
            pw.SizedBox(height: 10),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                    child: pw.Column(children: [
                  pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    padding: const pw.EdgeInsets.only(bottom: 10),
                    child: pw.Text(
                      'Expense By Sub-Categories',
                      style: const pw.TextStyle(
                        color: baseColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  pw.Text(
                    'Total expenses are broken into different categories for closer look into where the money was spent.',
                    textAlign: pw.TextAlign.justify,
                  )
                ])),
                pw.SizedBox(width: 10),
                pw.Expanded(
                  child: pw.Column(
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        padding: const pw.EdgeInsets.only(bottom: 10),
                        child: pw.Text(
                          'Spent vs. Saved',
                          style: const pw.TextStyle(
                            color: baseColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      pw.Text(
                        'Budget was originally \$$budget. A total of \$$expense was spent on the month of January which exceeded the overall budget by \$${expense - budget}',
                        textAlign: pw.TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  // Second page with a pie chart
  document.addPage(
    pw.Page(
      pageFormat: pageFormat,
      theme: theme,
      build: (context) {
        const chartColors = [
          PdfColors.blue300,
          PdfColors.green300,
          PdfColors.amber300,
          PdfColors.pink300,
          PdfColors.cyan300,
          PdfColors.purple300,
          PdfColors.lime300,
        ];

        return pw.Column(
          children: [
            pw.Flexible(
              child: pw.Chart(
                title: pw.Text(
                  'Expense breakdown',
                  style: const pw.TextStyle(
                    color: baseColor,
                    fontSize: 20,
                  ),
                ),
                grid: pw.PieGrid(),
                datasets: List<pw.Dataset>.generate(dataTable.length, (index) {
                  final data = dataTable[index];
                  final color = chartColors[index % chartColors.length];
                  final value = (data[2] as num).toDouble();
                  final pct = (value / expense * 100).round();
                  return pw.PieDataSet(
                    legend: '${data[0]}\n$pct%',
                    value: value,
                    color: color,
                    legendStyle: const pw.TextStyle(fontSize: 10),
                  );
                }),
              ),
            ),
            table,
          ],
        );
      },
    ),
  );

  final file = File('_diagrams.pdf');
  await file.writeAsBytes(await document.save());
  print('Thank you, wrote: _diagrams.pdf\n\n');

  // print(DateTime.now());
}

