import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entry.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class WeekView {
  final Entries entries;

  final Map<int, Entry> entriesByNumber = {};
  final Map<int, List<int>> entriesLength = {};

  WeekView({
    required this.entries,
  });

  pw.Widget build() {
    DateTime d = DateTime.parse('2024-03-25 12:00');

    List<List<int>> lanes = _prepareAllDay(d);

    print('lanes');
    print(lanes);

    List<pw.Widget> allDayWidgets = [];
    for (List<int> lane in lanes) {
      print('lane');
      print(lane);

      List<pw.Partition> rowWidgets = [];

      int nr1 = -1;
      for (int n = 0; n < 7; n++) {
        int nr2 = lane[n];

        if (nr2 != nr1 && nr1 > -1) {
          print("$n $nr1 $nr2");

        }

        // rowWidgets.add(
        //   pw.Partition(
        //     flex: 1,
        //     child: pw.Container(
        //       height: 5 * PdfPageFormat.mm,
        //       width: double.infinity,
        //       padding: pw.EdgeInsets.all(1 * PdfPageFormat.mm),
        //       margin: pw.EdgeInsets.only(
        //         // right: 1 * PdfPageFormat.mm,
        //       ),
        //       decoration: pw.BoxDecoration(
        //         color: PdfColors.red,
        //         // borderRadius: pw.BorderRadius.only(
        //         //   topRight: pw.Radius.circular(3),
        //         //   bottomRight: pw.Radius.circular(3),
        //         // ),
        //       ),
        //     ),
        //   ),
        //   // pw.Partition(
        //   //   flex: 1,
        //   //   child: pw.Container(),
        //   // ),
        // );

      }





      allDayWidgets.add(
        pw.Partitions(
          children: rowWidgets,
        ),
      );
      allDayWidgets.add(
        pw.SizedBox(
          height: 1 * PdfPageFormat.mm,
        ),
      );
    }

    return pw.Column(
      children: allDayWidgets,

      // children: [
      //   pw.Partitions(
      //     children: [
      //       pw.Partition(
      //         flex: 3,
      //         child: pw.Container(
      //           height: 5 * PdfPageFormat.mm,
      //           width: double.infinity,
      //           padding: pw.EdgeInsets.all(1 * PdfPageFormat.mm),
      //           margin: pw.EdgeInsets.only(
      //             right: 1 * PdfPageFormat.mm,
      //           ),
      //           decoration: pw.BoxDecoration(
      //             color: PdfColors.red,
      //             borderRadius: pw.BorderRadius.only(
      //               topRight: pw.Radius.circular(3),
      //               bottomRight: pw.Radius.circular(3),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      //   pw.SizedBox(
      //     height: 1 * PdfPageFormat.mm,
      //   ),
      //   pw.Partitions(
      //     children: [
      //       pw.Partition(
      //         flex: 1,
      //         child: pw.Container(),
      //       ),
      //       pw.Partition(
      //         flex: 1,
      //         child: pw.Container(),
      //       ),
      //       pw.Partition(
      //         flex: 1,
      //         child: pw.Container(
      //           height: 5 * PdfPageFormat.mm,
      //           width: double.infinity,
      //           padding: pw.EdgeInsets.all(1 * PdfPageFormat.mm),
      //           margin: pw.EdgeInsets.only(
      //             right: 1 * PdfPageFormat.mm,
      //             left: 1 * PdfPageFormat.mm,
      //           ),
      //           decoration: pw.BoxDecoration(
      //             color: PdfColors.cyan,
      //             borderRadius: pw.BorderRadius.all(
      //               pw.Radius.circular(3),
      //             ),
      //           ),
      //           child: pw.Text(
      //             'xxxx',
      //             style: pw.TextStyle(
      //               color: PdfColors.white,
      //             ),
      //             maxLines: 1,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ],
    );

    // return pw.TableHelper.fromTextArray(
    //   border: pw.TableBorder(
    //       // verticalInside: pw.BorderSide(
    //       //   color: PdfColors.grey,
    //       // ),
    //       // horizontalInside: pw.BorderSide(
    //       //   color: PdfColors.grey,
    //       // ),
    //       ),
    //   headerCount: 0,
    //   columnWidths: {
    //     0: pw.FlexColumnWidth(),
    //     1: pw.FlexColumnWidth(),
    //   },
    //   cellPadding: pw.EdgeInsets.zero,
    //   data: [
    //     [
    //       pw.Container(
    //         padding: pw.EdgeInsets.only(top: 1 * PdfPageFormat.mm),
    //         decoration: pw.BoxDecoration(
    //           color: PdfColors.yellow,
    //           // border: pw.Border(
    //           //   right: pw.BorderSide(
    //           //     color: PdfColors.green,
    //           //   ),
    //           // ),
    //         ),
    //         child: pw.Column(
    //           mainAxisSize: pw.MainAxisSize.max,
    //           children: [
    //             pw.Container(
    //               height: 10 * PdfPageFormat.mm,
    //               width: double.infinity,
    //               padding: pw.EdgeInsets.all(1 * PdfPageFormat.mm),
    //               margin: pw.EdgeInsets.only(bottom: 1 * PdfPageFormat.mm),
    //               color: PdfColors.red,
    //               child: pw.Text(
    //                 'xasdfasdxx',
    //                 style: pw.TextStyle(
    //                   color: PdfColors.white,
    //                 ),
    //                 maxLines: 1,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       pw.Container(
    //         padding: pw.EdgeInsets.only(top: 1 * PdfPageFormat.mm),
    //         decoration: pw.BoxDecoration(
    //           color: PdfColors.orange,
    //           // border: pw.Border(
    //           //   right: pw.BorderSide(
    //           //     color: PdfColors.green,
    //           //   ),
    //           // ),
    //         ),
    //         child: pw.Column(
    //           mainAxisSize: pw.MainAxisSize.max,
    //           children: [
    //             pw.Container(
    //               height: 10 * PdfPageFormat.mm,
    //               width: double.infinity,
    //               padding: pw.EdgeInsets.all(1 * PdfPageFormat.mm),
    //               margin: pw.EdgeInsets.only(
    //                 bottom: 1 * PdfPageFormat.mm,
    //                 right: 2 * PdfPageFormat.mm,
    //               ),
    //               decoration: pw.BoxDecoration(
    //                 color: PdfColors.red,
    //                 borderRadius: pw.BorderRadius.only(
    //                   topRight: pw.Radius.circular(3),
    //                   bottomRight: pw.Radius.circular(3),
    //                 ),
    //               ),
    //               child: pw.Text(
    //                 '...',
    //                 style: pw.TextStyle(
    //                   color: PdfColors.white,
    //                 ),
    //                 maxLines: 1,
    //               ),
    //             ),
    //             pw.Container(
    //               height: 10 * PdfPageFormat.mm,
    //               width: double.infinity,
    //               padding: pw.EdgeInsets.all(1 * PdfPageFormat.mm),
    //               margin: pw.EdgeInsets.only(
    //                 bottom: 1 * PdfPageFormat.mm,
    //                 right: 2 * PdfPageFormat.mm,
    //                 left: 2 * PdfPageFormat.mm,
    //               ),
    //               decoration: pw.BoxDecoration(
    //                 color: PdfColors.cyan,
    //                 borderRadius: pw.BorderRadius.all(
    //                   pw.Radius.circular(3),
    //                 ),
    //               ),
    //               child: pw.Text(
    //                 'xxxx',
    //                 style: pw.TextStyle(
    //                   color: PdfColors.white,
    //                 ),
    //                 maxLines: 1,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ],
    // );
  }

  List<List<int>> _prepareAllDay(DateTime d) {
    for (int n = 0; n < 7; n++) {
      List<Entry> some =
          entries.forDate(d).where((Entry e) => e.allDay).toList();
      d = d.add(Duration(days: 1));
      for (Entry e in some) {
        e = e.parent ?? e;
        entriesByNumber[e.nr] = e;
        if (entriesLength[e.nr] == null) {
          entriesLength[e.nr] = [n, n, 1];
        } else {
          entriesLength[e.nr]![1] = n;
          entriesLength[e.nr]![2]++;
        }
      }
    }
    return _prepareAllDayLanes();
  }

  List<List<int>> _prepareAllDayLanes() {
    List<List<int>> lanes = [];

    for (int n = 7; n > 0; n--) {
      List<MapEntry<int, List<int>>> map = (entriesLength.entries.where((e) {
        return e.value[2] == n;
      })).toList();
      for (MapEntry<int, List<int>> me in map) {
        int nr = me.key;
        int s = me.value[0];
        int e = me.value[1];

        // check for lanes where s to e are free
        // if none, create new lane

        bool inserted = false;
        for (List<int> lane in lanes) {
          bool free = true;
          for (int m = s; m <= e; m++) {
            if (lane[m] > -1) {
              free = false;
            }
          }
          if (free) {
            for (int m = s; m <= e; m++) {
              lane[m] = nr;
            }
            inserted = true;
          }
        }

        if (!inserted) {
          List<int> lane = List.filled(7, -1);
          for (int m = s; m <= e; m++) {
            lane[m] = nr;
          }
          lanes.add(lane);
        }
      }
    }
    return lanes;
  }
}
