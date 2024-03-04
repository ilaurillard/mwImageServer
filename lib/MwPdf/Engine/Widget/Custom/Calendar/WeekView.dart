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
    DateTime startDate = DateTime.parse('2024-03-25 12:00');
    // DateTime endDate = startDate.add(Duration(days: 6));

    // print(endDate);

    List<List<int>> lanes = _prepareAllDay(
      startDate,
    );

    // print('lanes');
    // print(lanes);

    List<pw.Widget> allDayWidgets = [
      pw.SizedBox(
        height: 7 * PdfPageFormat.mm,
      ),
    ];
    for (List<int> lane in lanes) {
      // print('lane');
      // print(lane);

      List<pw.Partition> row = [];

      List<List<int>> chunks = _chunks(lane);
      for (List<int> seg in chunks) {
        int nr = seg.first;
        Entry? e = nr > -1 ? entriesByNumber[nr] : null;

        bool starts = true;
        bool ends = true;
        if (e != null) {
          int d1 = e.start.difference(startDate).inDays;
          int d2 = e.end.difference(startDate).inDays;
          if (d1 < 0) {
            starts = false;
          }
          if (d2 > 6) {
            ends = false;
          }
        }

        row.add(
          pw.Partition(
            flex: seg.length,
            child: e != null
                ? pw.Container(
                    height: 5 * PdfPageFormat.mm,
                    width: double.infinity,
                    padding: pw.EdgeInsets.all(1.5 * PdfPageFormat.mm),
                    margin: pw.EdgeInsets.only(
                      right: ends ? 0.75 * PdfPageFormat.mm : 0,
                      left: starts ? 0.75 * PdfPageFormat.mm : 0,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.red,
                      borderRadius: pw.BorderRadius.only(
                        topRight: ends
                            ? pw.Radius.circular(2 * PdfPageFormat.mm)
                            : pw.Radius.zero,
                        bottomRight: ends
                            ? pw.Radius.circular(2 * PdfPageFormat.mm)
                            : pw.Radius.zero,
                        topLeft: starts
                            ? pw.Radius.circular(2 * PdfPageFormat.mm)
                            : pw.Radius.zero,
                        bottomLeft: starts
                            ? pw.Radius.circular(2 * PdfPageFormat.mm)
                            : pw.Radius.zero,
                      ),
                    ),
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        e.label,
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  )
                : pw.Container(),
          ),
        );
      }

      allDayWidgets.addAll(
        [
          pw.Partitions(
            children: row,
          ),
          pw.SizedBox(
            height: 1 * PdfPageFormat.mm,
          ),
        ],
      );
    }

    double height =
        (lanes.length + 1) * (6 * PdfPageFormat.mm) + (1 * PdfPageFormat.mm);

    pw.Border border = pw.Border(
      left: pw.BorderSide(
        color: PdfColors.white,
      ),
    );

    return pw.Container(
      // padding: pw.EdgeInsets.only(top: 1 * PdfPageFormat.mm),
      // color: PdfColors.yellow,
      child: pw.Stack(
        fit: pw.StackFit.passthrough,
        children: [
          pw.Partitions(
            children: [
              pw.Partition(
                flex: 1,
                child: pw.Container(
                  height: height,
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey200,
                  ),
                ),
              ),
              pw.Partition(
                flex: 1,
                child: pw.Container(
                  height: height,
                  decoration: pw.BoxDecoration(
                    border: border,
                    color: PdfColors.grey200,
                  ),
                ),
              ),
              pw.Partition(
                flex: 1,
                child: pw.Container(
                  height: height,
                  decoration: pw.BoxDecoration(
                    border: border,
                    color: PdfColors.grey200,
                  ),
                ),
              ),
              pw.Partition(
                flex: 1,
                child: pw.Container(
                  height: height,
                  decoration: pw.BoxDecoration(
                    border: border,
                    color: PdfColors.grey200,
                  ),
                ),
              ),
              pw.Partition(
                flex: 1,
                child: pw.Container(
                  height: height,
                  decoration: pw.BoxDecoration(
                    border: border,
                    color: PdfColors.grey200,
                  ),
                ),
              ),
              pw.Partition(
                flex: 1,
                child: pw.Container(
                  height: height,
                  decoration: pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: border,
                  ),
                ),
              ),
              pw.Partition(
                flex: 1,
                child: pw.Container(
                  height: height,
                  decoration: pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: border,
                  ),
                ),
              ),
            ],
          ),
          pw.Column(
            children: allDayWidgets,
          ),
        ],
      ),
    );
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

  List<List<int>> _chunks(List<int> arr) {
    List<List<int>> chunks = [];
    List<int> currentChunk = [arr[0]];
    for (int i = 1; i < arr.length; i++) {
      if (arr[i] == arr[i - 1]) {
        currentChunk.add(arr[i]);
      } else {
        chunks.add(currentChunk);
        currentChunk = [arr[i]];
      }
    }
    chunks.add(currentChunk);
    return chunks;
  }
}
