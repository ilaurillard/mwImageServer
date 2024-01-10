/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> main() async {
  Uint8List pdf = await generateCalendar(
     PdfPageFormat.a4,
    CustomData(name: 'Peter')
  );


  final file = File('_cal.pdf');
  await file.writeAsBytes(pdf);
  print('Thank you\n\n');
}


class Calendar extends pw.StatelessWidget {
  Calendar({
    this.date,
    this.month,
    this.year,
  });

  final DateTime? date;

  final int? month;

  final int? year;

  pw.Widget title(
      pw.Context context,
      DateTime date,
      ) {
    return pw.Container(
      width: double.infinity,
      margin: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        DateFormat.yMMMM().format(date),
        style: const pw.TextStyle(
          color: PdfColors.deepPurple,
          fontSize: 40,
        ),
      ),
    );
  }

  pw.Widget header(
      pw.Context context,
      DateTime date,
      ) {
    return pw.Container(
      color: PdfColors.blue200,
      padding: const pw.EdgeInsets.only(top: 8, left: 8, bottom: 8),
      child: pw.Text(
        DateFormat.EEEE().format(date),
        style: const pw.TextStyle(
          fontSize: 15,
        ),
        maxLines: 1,
        overflow: pw.TextOverflow.clip,
      ),
    );
  }

  pw.Widget day(
      pw.Context context,
      DateTime date,
      bool currentMonth,
      bool currentDay,
      ) {
    var text = '${date.day}';
    var style = const pw.TextStyle();
    var color = PdfColors.grey300;

    if (currentDay) {
      style = const pw.TextStyle(color: PdfColors.red);
      color = PdfColors.lightBlue50;
    }

    if (!currentMonth) {
      style = const pw.TextStyle(color: PdfColors.grey);
      color = PdfColors.grey100;
    }

    if (date.day == 1) {
      text += ' ${DateFormat.MMM().format(date)}';
    }

    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      color: color,
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.right,
        style: style,
      ),
    );
  }

  @override
  pw.Widget build(pw.Context context) {
    final localDate = date ?? DateTime.now();
    final localYear = year ?? localDate.year;
    final localMnth = month ?? localDate.month;

    final start = DateTime(localYear, localMnth, 1, 12);
    final end = DateTime(localYear, localMnth + 1, 1, 12).subtract(
      const Duration(days: 1),
    );

    final startId = start.weekday - 1;
    final endId = end.difference(start).inDays + startId + 1;

    final head = pw.Row(
      mainAxisSize: pw.MainAxisSize.max,
      children: List<pw.Widget>.generate(7, (int index) {
        final d = start.add(Duration(days: index - startId));
        return pw.Expanded(
          child: pw.Container(
            foregroundDecoration: pw.BoxDecoration(
              border: pw.Border(
                top: const pw.BorderSide(color: PdfColors.grey),
                left: const pw.BorderSide(color: PdfColors.grey),
                right: index % 7 == 6
                    ? const pw.BorderSide(color: PdfColors.grey)
                    : pw.BorderSide.none,
                bottom: const pw.BorderSide(color: PdfColors.grey),
              ),
            ),
            child: header(context, d),
          ),
        );
      }),
    );

    final body = pw.GridView(
      crossAxisCount: 7,
      children: List<pw.Widget>.generate(42, (int index) {
        final d = start.add(Duration(days: index - startId));
        final currentMonth = index >= startId && index < endId;
        final currentDay = d.year == localDate.year &&
            d.month == localDate.month &&
            d.day == localDate.day;
        return pw.Container(
          foregroundDecoration: pw.BoxDecoration(
              border: pw.Border(
                left: const pw.BorderSide(color: PdfColors.grey),
                right: index % 7 == 6
                    ? const pw.BorderSide(color: PdfColors.grey)
                    : pw.BorderSide.none,
                bottom: const pw.BorderSide(color: PdfColors.grey),
              )),
          child: day(context, d, currentMonth, currentDay),
        );
      }),
    );

    return pw.Container(
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        mainAxisSize: pw.MainAxisSize.min,
        children: <pw.Widget>[
          title(context, DateTime(localYear, localMnth)),
          head,
          pw.Expanded(child: body),
        ],
      ),
    );
  }
}

Future<Uint8List> generateCalendar(
    PdfPageFormat pageFormat, CustomData data) async {
  //Create a PDF document.
  final document = pw.Document();
  final date = DateTime.now();
  String? bg;

  switch (date.month) {
    case 12:
      break;
  }

  document.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: pageFormat,
        orientation: pw.PageOrientation.landscape,
        theme: pw.ThemeData.withFont(
          base:  pw.Font.courier(),
          bold:  pw.Font.courier(),
        ),

      ),
      build: (context) => pw.Padding(
        padding: const pw.EdgeInsets.only(right: 20),
        child: Calendar(
          date: date,
        ),
      ),
    ),
  );

  return document.save();
}

class CustomData {
  const CustomData({this.name = '[your name]'});

  final String name;
}