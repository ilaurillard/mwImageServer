// import 'package:test/test.dart';

import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> main() async {
  PdfPageFormat pageFormat = PdfPageFormat.a4;

  // ###########################################

  // pw.Document pdf = pw.Document();
  // pdf.addPage(
  //   pw.Page(
  //     build: (pw.Context context) => pw.Center(
  //       child: pw.Text('Hello World!'),
  //     ),
  //   ),
  // );
  // File file = File('example.pdf');
  // await file.writeAsBytes(await pdf.save());

  // ###########################################

  // const tableHeaders = ['Category', 'Budget', 'Expense', 'Result'];
  //
  // const dataTable = [
  //   ['Phone', 80, 95],
  //   ['Internet', 250, 230],
  //   ['Electricity', 300, 375],
  //   ['Movies', 85, 80],
  //   ['Food', 300, 350],
  //   ['Fuel', 650, 550],
  //   ['Insurance', 250, 310],
  // ];
  //
  // // Some summary maths
  // final budget = dataTable
  //     .map((e) => e[1] as num)
  //     .reduce((value, element) => value + element);
  // final expense = dataTable
  //     .map((e) => e[2] as num)
  //     .reduce((value, element) => value + element);
  //
  // const baseColor = PdfColors.cyan;
  //
  // // Create a PDF document.
  // final document = pw.Document();
  //
  // final theme = pw.ThemeData.withFont(
  //   base: pw.Font.helvetica(),
  //   // base: await PdfGoogleFonts.openSansRegular(),
  //   // bold: await PdfGoogleFonts.openSansBold(),
  // );
  //
  // // Top bar chart
  // final chart1 = pw.Chart(
  //   left: pw.Container(
  //     alignment: pw.Alignment.topCenter,
  //     margin: const pw.EdgeInsets.only(right: 5, top: 10),
  //     child: pw.Transform.rotateBox(
  //       angle: pi / 2,
  //       child: pw.Text('Amount'),
  //     ),
  //   ),
  //   overlay: pw.ChartLegend(
  //     position: const pw.Alignment(-.7, 1),
  //     decoration: pw.BoxDecoration(
  //       color: PdfColors.white,
  //       border: pw.Border.all(
  //         color: PdfColors.black,
  //         width: .5,
  //       ),
  //     ),
  //   ),
  //   grid: pw.CartesianGrid(
  //     xAxis: pw.FixedAxis.fromStrings(
  //       List<String>.generate(
  //           dataTable.length, (index) => dataTable[index][0] as String),
  //       marginStart: 30,
  //       marginEnd: 30,
  //       ticks: true,
  //     ),
  //     yAxis: pw.FixedAxis(
  //       [0, 100, 200, 300, 400, 500, 600, 700],
  //       format: (v) => '\$$v',
  //       divisions: true,
  //     ),
  //   ),
  //   datasets: [
  //     pw.BarDataSet(
  //       color: PdfColors.blue100,
  //       legend: tableHeaders[2],
  //       width: 15,
  //       offset: -10,
  //       borderColor: baseColor,
  //       data: List<pw.PointChartValue>.generate(
  //         dataTable.length,
  //         (i) {
  //           final v = dataTable[i][2] as num;
  //           return pw.PointChartValue(i.toDouble(), v.toDouble());
  //         },
  //       ),
  //     ),
  //     pw.BarDataSet(
  //       color: PdfColors.amber100,
  //       legend: tableHeaders[1],
  //       width: 15,
  //       offset: 10,
  //       borderColor: PdfColors.amber,
  //       data: List<pw.PointChartValue>.generate(
  //         dataTable.length,
  //         (i) {
  //           final v = dataTable[i][1] as num;
  //           return pw.PointChartValue(i.toDouble(), v.toDouble());
  //         },
  //       ),
  //     ),
  //   ],
  // );
  //
  // // Left curved line chart
  // final chart2 = pw.Chart(
  //   right: pw.ChartLegend(),
  //   grid: pw.CartesianGrid(
  //     xAxis: pw.FixedAxis([0, 1, 2, 3, 4, 5, 6]),
  //     yAxis: pw.FixedAxis(
  //       [0, 200, 400, 600],
  //       divisions: true,
  //     ),
  //   ),
  //   datasets: [
  //     pw.LineDataSet(
  //       legend: 'Expense',
  //       drawSurface: true,
  //       isCurved: true,
  //       drawPoints: false,
  //       color: baseColor,
  //       data: List<pw.PointChartValue>.generate(
  //         dataTable.length,
  //         (i) {
  //           final v = dataTable[i][2] as num;
  //           return pw.PointChartValue(i.toDouble(), v.toDouble());
  //         },
  //       ),
  //     ),
  //   ],
  // );
  //
  // // Data table
  // final table = pw.TableHelper.fromTextArray(
  //   border: null,
  //   headers: tableHeaders,
  //   data: List<List<dynamic>>.generate(
  //     dataTable.length,
  //     (index) => <dynamic>[
  //       dataTable[index][0],
  //       dataTable[index][1],
  //       dataTable[index][2],
  //       (dataTable[index][1] as num) - (dataTable[index][2] as num),
  //     ],
  //   ),
  //   headerStyle: pw.TextStyle(
  //     color: PdfColors.white,
  //     fontWeight: pw.FontWeight.bold,
  //   ),
  //   headerDecoration: const pw.BoxDecoration(
  //     color: baseColor,
  //   ),
  //   rowDecoration: const pw.BoxDecoration(
  //     border: pw.Border(
  //       bottom: pw.BorderSide(
  //         color: baseColor,
  //         width: .5,
  //       ),
  //     ),
  //   ),
  //   cellAlignment: pw.Alignment.centerRight,
  //   cellAlignments: {0: pw.Alignment.centerLeft},
  // );
  //
  // // Add page to the PDF
  // document.addPage(
  //   pw.Page(
  //     pageFormat: pageFormat,
  //     theme: theme,
  //     build: (context) {
  //       // Page layout
  //       return pw.Column(
  //         children: [
  //           pw.Text('Budget Report',
  //               style: const pw.TextStyle(
  //                 color: baseColor,
  //                 fontSize: 40,
  //               )),
  //           pw.Divider(thickness: 4),
  //           pw.Expanded(flex: 3, child: chart1),
  //           pw.Divider(),
  //           pw.Expanded(flex: 2, child: chart2),
  //           pw.SizedBox(height: 10),
  //           pw.Row(
  //             crossAxisAlignment: pw.CrossAxisAlignment.start,
  //             children: [
  //               pw.Expanded(
  //                   child: pw.Column(children: [
  //                 pw.Container(
  //                   alignment: pw.Alignment.centerLeft,
  //                   padding: const pw.EdgeInsets.only(bottom: 10),
  //                   child: pw.Text(
  //                     'Expense By Sub-Categories',
  //                     style: const pw.TextStyle(
  //                       color: baseColor,
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ),
  //                 pw.Text(
  //                   'Total expenses are broken into different categories for closer look into where the money was spent.',
  //                   textAlign: pw.TextAlign.justify,
  //                 )
  //               ])),
  //               pw.SizedBox(width: 10),
  //               pw.Expanded(
  //                 child: pw.Column(
  //                   children: [
  //                     pw.Container(
  //                       alignment: pw.Alignment.centerLeft,
  //                       padding: const pw.EdgeInsets.only(bottom: 10),
  //                       child: pw.Text(
  //                         'Spent vs. Saved',
  //                         style: const pw.TextStyle(
  //                           color: baseColor,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                     pw.Text(
  //                       'Budget was originally \$$budget. A total of \$$expense was spent on the month of January which exceeded the overall budget by \$${expense - budget}',
  //                       textAlign: pw.TextAlign.justify,
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   ),
  // );
  //
  // // Second page with a pie chart
  // document.addPage(
  //   pw.Page(
  //     pageFormat: pageFormat,
  //     theme: theme,
  //     build: (context) {
  //       const chartColors = [
  //         PdfColors.blue300,
  //         PdfColors.green300,
  //         PdfColors.amber300,
  //         PdfColors.pink300,
  //         PdfColors.cyan300,
  //         PdfColors.purple300,
  //         PdfColors.lime300,
  //       ];
  //
  //       return pw.Column(
  //         children: [
  //           pw.Flexible(
  //             child: pw.Chart(
  //               title: pw.Text(
  //                 'Expense breakdown',
  //                 style: const pw.TextStyle(
  //                   color: baseColor,
  //                   fontSize: 20,
  //                 ),
  //               ),
  //               grid: pw.PieGrid(),
  //               datasets: List<pw.Dataset>.generate(dataTable.length, (index) {
  //                 final data = dataTable[index];
  //                 final color = chartColors[index % chartColors.length];
  //                 final value = (data[2] as num).toDouble();
  //                 final pct = (value / expense * 100).round();
  //                 return pw.PieDataSet(
  //                   legend: '${data[0]}\n$pct%',
  //                   value: value,
  //                   color: color,
  //                   legendStyle: const pw.TextStyle(fontSize: 10),
  //                 );
  //               }),
  //             ),
  //           ),
  //           table,
  //         ],
  //       );
  //     },
  //   ),
  // );

  // ###########################################

  final lorem = pw.LoremText();

  final products = <Product>[
    Product('19874', lorem.sentence(4), 3.99, 2),
    Product('98452', lorem.sentence(6), 15, 2),
    Product('28375', lorem.sentence(4), 6.95, 3),
    Product('95673', lorem.sentence(3), 49.99, 4),
    Product('23763', lorem.sentence(2), 560.03, 1),
    Product('55209', lorem.sentence(5), 26, 1),
    Product('09853', lorem.sentence(5), 26, 1),
    Product('23463', lorem.sentence(5), 34, 1),
    Product('56783', lorem.sentence(5), 7, 4),
    Product('78256', lorem.sentence(5), 23, 1),
    Product('23745', lorem.sentence(5), 94, 1),
    Product('07834', lorem.sentence(5), 12, 1),
    Product('23547', lorem.sentence(5), 34, 1),
    Product('98387', lorem.sentence(5), 7.99, 2),
  ];

  final invoice = Invoice(
    invoiceNumber: '982347',
    products: products,
    customerName: 'Abraham Swearegin',
    customerAddress: '54 rue de Rivoli\n75001 Paris, France',
    paymentInfo:
        '4509 Wiseman Street\nKnoxville, Tennessee(TN), 37929\n865-372-0425',
    tax: .15,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  print(DateTime.now());

  pw.Document document = await invoice.buildPdf(pageFormat);

  final file = File('example.pdf');
  await file.writeAsBytes(await document.save());
  print('Thank you, wrote: example.pdf\n\n');

  // print(DateTime.now());
}

class Invoice {
  Invoice({
    required this.products,
    required this.customerName,
    required this.customerAddress,
    required this.invoiceNumber,
    required this.tax,
    required this.paymentInfo,
    required this.baseColor,
    required this.accentColor,
  });

  final List<Product> products;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  double get _total =>
      products.map<double>((p) => p.total).reduce((a, b) => a + b);

  double get _grandTotal => _total * (1 + tax);

  String? _logo;

  String? _bgShape;

  Future<pw.Document> buildPdf(
    PdfPageFormat pageFormat,
  ) async {
    final doc = pw.Document();

    _logo = await File('tests/playground/files/logo.svg').readAsString();
    _bgShape = await File('tests/playground/files/invoice.svg').readAsString();

    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          pw.Font.helvetica(),
          pw.Font.helveticaBold(),
          pw.Font.helveticaOblique(),
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    return doc;
  }

  pw.Widget _buildHeader(
    pw.Context context,
  ) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'INVOICE',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Invoice #'),
                          pw.Text(invoiceNumber),
                          pw.Text('Date:'),
                          pw.Text(_formatDate(DateTime.now())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    child:
                        _logo != null ? pw.SvgImage(svg: _logo!) : pw.PdfLogo(),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(
    pw.Context context,
  ) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.pdf417(),
            data: 'Invoice# $invoiceNumber',
            drawText: false,
          ),
        ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  pw.PageTheme _buildTheme(
    PdfPageFormat pageFormat,
    pw.Font base,
    pw.Font bold,
    pw.Font italic,
  ) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: _bgShape!),
      ),
    );
  }

  pw.Widget _contentHeader(
    pw.Context context,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: pw.FittedBox(
              child: pw.Text(
                'Total: ${_formatCurrency(_grandTotal)}',
                style: pw.TextStyle(
                  color: baseColor,
                  // fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Invoice to:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: '$customerName\n',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                        const pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: customerAddress,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Thank you for your business',
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  'Payment Info:',
                  style: pw.TextStyle(
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                paymentInfo,
                style: const pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Sub Total:'),
                    pw.Text(_formatCurrency(_total)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Tax:'),
                    pw.Text('${(tax * 100).toStringAsFixed(1)}%'),
                  ],
                ),
                pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text(_formatCurrency(_grandTotal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: accentColor)),
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Terms & Conditions',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                pw.LoremText().paragraph(40),
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _contentTable(
    pw.Context context,
  ) {
    const tableHeaders = [
      'SKU#',
      'Item Description',
      'Price',
      'Quantity',
      'Total'
    ];

    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  return '${date.year}-${date.month}-${date.day}';
}

class Product {
  const Product(
    this.sku,
    this.productName,
    this.price,
    this.quantity,
  );

  final String sku;
  final String productName;
  final double price;
  final int quantity;

  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sku;
      case 1:
        return productName;
      case 2:
        return _formatCurrency(price);
      case 3:
        return quantity.toString();
      case 4:
        return _formatCurrency(total);
    }
    return '';
  }
}


