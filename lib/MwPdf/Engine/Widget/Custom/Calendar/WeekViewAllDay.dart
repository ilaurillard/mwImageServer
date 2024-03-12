import 'package:intl/intl.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Config.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/CustomCalendar.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entry.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Holiday.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Special.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class WeekViewAllDay {
  final Map<int, Entry> entriesByNumber = {};
  final Map<int, List<int>> entriesLength = {};

  final Entries entries;

  DateTime localDate = DateTime.now();

  late final DateTime date;
  final Config config;

  final DateFormat df = DateFormat('MM-dd');
  late final DateFormat dfWeekday;

  final Map<String, Holiday> holidays;
  final Map<String, Special> specials;

  late double allDayHeight;
  late List<List<int>> allDayLanes;

  late List<pw.Partition> allDayTitles;
  late List<pw.Partition> allDayBgCells;
  late List<pw.Widget> allDayWidgets;

  WeekViewAllDay({
    required this.date,
    required this.entries,
    this.config = const Config(),
    this.holidays = const {},
    this.specials = const {},
  }) {
    dfWeekday = DateFormat('EEEE', config.locale);
  }

  pw.Widget build() {
    _prepareAllDayArea(
      date,
    );

    return pw.Column(
      children: [
        pw.Partitions(
          children: allDayTitles,
        ),
        pw.Stack(
          children: [
            pw.Partitions(
              children: allDayBgCells,
            ),
            pw.Column(
              children: allDayWidgets,
            ),
          ],
        ),
      ],
    );
  }

  // Dienstag
  //    12
  pw.Partition _titleCell({
    required DateTime dt,
    required bool currentDay,
    required bool weekend,
  }) {
    PdfColor? color = currentDay
        ? config.colors.textCurrent
        : (weekend ? config.colors.textSpecial : null);
    return pw.Partition(
      flex: 7,
      child: pw.Container(
        child: pw.Column(
          children: [
            pw.Text(
              dfWeekday.format(dt),
              style: pw.TextStyle(
                color: color,
              ),
            ),
            pw.Container(
              padding: pw.EdgeInsets.symmetric(
                vertical: 2 * PdfPageFormat.mm,
              ),
              child: pw.Text(
                '${dt.day}',
                style: pw.TextStyle(
                  fontSize: 5 * PdfPageFormat.mm,
                  color: color,
                ),
              ),
            )
          ],
        ),
        decoration: pw.BoxDecoration(),
      ),
    );
  }

  // zB "Ostermontag"
  pw.Partition _labelCell({
    required DateTime dt,
    required bool currentDay,
    required bool weekend,
  }) {
    String key = df.format(dt);
    Holiday? holi = holidays[key];
    Special? special = specials[key];

    pw.TextStyle style = config.textStyle;
    if (weekend || (holi != null && holi.inMyCounty)) {
      style = style.merge(
        pw.TextStyle(
          fontWeight: weekend && config.weekendStrong
              ? pw.FontWeight.bold
              : pw.FontWeight.normal,
          color: config.colors.textSpecial,
        ),
      );
    }

    if (currentDay) {
      style = style.apply(
        color: config.colors.textCurrent,
      );
    }

    pw.Widget? label = Config.label(
      holi: holi,
      config: config,
      dt: dt,
      style: style,
    );

    pw.Widget? specialIcons = special?.icons(
      config,
    );

    return pw.Partition(
      flex: 7,
      child: pw.Container(
        padding: pw.EdgeInsets.all(config.cellPadding),
        height: config.lane.laneHeight,
        child: pw.Stack(
          children: [
            if (specialIcons != null) specialIcons,
            if (label != null)
              pw.Align(
                alignment: pw.Alignment.bottomLeft,
                child: label,
              ),
          ],
        ),
      ),
    );
  }

  // (Hintergrund)
  pw.Partition _bgCell({
    required DateTime date,
    required double height,
    required bool weekend,
    required bool currentDay,
  }) {
    String key = df.format(date);
    Holiday? holi = holidays[key];

    PdfColor color = config.colors.cell;
    if (weekend || (holi != null && holi.inMyCounty)) {
      color = config.colors.cellWeekend;
    }

    if (currentDay) {
      color = config.colors.cellToday;
    }

    pw.Border borderBG = pw.Border(
      left: pw.BorderSide(
        color: config.colors.border,
        width: config.colors.borderWidth,
      ),
    );
    return pw.Partition(
      flex: 7,
      child: pw.Container(
        height: height,
        decoration: pw.BoxDecoration(
          color: color,
          border: borderBG,
        ),
      ),
    );
  }

  void _prepareAllDayArea(
    DateTime dt,
  ) {
    _prepareAllDayLanesData(
      dt: dt,
    );

    _prepareAllDayTitleCells(dt);
    _prepareAllDayBgCells(dt);
    _prepareAllDayLaneWidgets();
  }

  void _prepareAllDayTitleCells(
    DateTime dt,
  ) {
    allDayTitles = [
      pw.Partition(
        flex: (1 * config.days).ceil(),
        child: pw.Container(
          child: pw.Text('KW ${dt.weekOfYear.toString().padLeft(2, '0')}'),
        ),
      )
    ];
    for (int n = 0; n < config.days; n++) {
      DateTime dt = date.add(Duration(days: n));
      allDayTitles.add(
        _titleCell(
          dt: dt,
          currentDay: config.highlightToday &&
              dt.year == localDate.year &&
              dt.month == localDate.month &&
              dt.day == localDate.day,
          weekend: dt.weekday == 6 || dt.weekday == 7,
        ),
      );
    }
  }

  void _prepareAllDayBgCells(
    DateTime dt,
  ) {
    allDayBgCells = [
      pw.Partition(
        flex: (1 * config.days).ceil(),
        child: pw.Container(),
      )
    ];
    for (int n = 0; n < config.days; n++) {
      DateTime dt = date.add(Duration(days: n));
      allDayBgCells.add(
        _bgCell(
          date: dt,
          height: allDayHeight,
          weekend: dt.weekday > 5,
          currentDay: config.highlightToday &&
              dt.year == localDate.year &&
              dt.month == localDate.month &&
              dt.day == localDate.day,
        ),
      );
    }
  }

  // sort entries into lanes
  void _prepareAllDayLanesData({
    required DateTime dt,
  }) {
    _prepareEntriesLengths(dt);

    List<List<int>> lanes = [];

    for (int n = config.days; n > 0; n--) {
      // longest first
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
          List<int> lane = List.filled(config.days, -1);
          for (int m = s; m <= e; m++) {
            lane[m] = nr;
          }
          lanes.add(lane);
        }
      }
    }
    allDayLanes = lanes;

    allDayHeight = (allDayLanes.length + 1) *
        (config.lane.laneGapV + config.lane.laneHeight);
  }

  List<List<int>> _laneChunks(List<int> arr) {
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

  void _prepareAllDayLaneWidgets() {
    allDayWidgets = [
      pw.SizedBox(
        height: config.lane.laneGapV,
      ),
    ];
    for (List<int> lane in allDayLanes) {
      List<pw.Partition> row = [
        pw.Partition(
          flex: (1 * config.days).ceil(),
          child: pw.Container(),
        ),
      ];

      List<List<int>> chunks = _laneChunks(lane);
      for (List<int> seg in chunks) {
        int nr = seg.first;
        Entry? e = nr > -1 ? entriesByNumber[nr] : null;

        // starts/ends (round butts)
        bool starts = true;
        bool ends = true;
        if (e != null) {
          int d1 = e.start.difference(date).inDays;
          int d2 = e.end.difference(date).inDays;
          if (d1 < 0) {
            starts = false;
          }
          if (d2 > (config.days - 1)) {
            ends = false;
          }
        }

        row.add(
          pw.Partition(
            flex: seg.length * 7,
            child: e != null
                ? pw.Container(
                    height: config.lane.laneHeight,
                    width: double.infinity,
                    padding: pw.EdgeInsets.all(config.lane.lanePadding),
                    margin: pw.EdgeInsets.only(
                      right: ends ? config.lane.laneGapH : 0,
                      left: starts ? config.lane.laneGapH : 0,
                    ),
                    decoration: pw.BoxDecoration(
                      color: config.groupColor(e.group),
                      borderRadius: pw.BorderRadius.only(
                        topRight: ends
                            ? pw.Radius.circular(config.lane.laneCornerRadius)
                            : pw.Radius.zero,
                        bottomRight: ends
                            ? pw.Radius.circular(config.lane.laneCornerRadius)
                            : pw.Radius.zero,
                        topLeft: starts
                            ? pw.Radius.circular(config.lane.laneCornerRadius)
                            : pw.Radius.zero,
                        bottomLeft: starts
                            ? pw.Radius.circular(config.lane.laneCornerRadius)
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
            height: config.lane.laneGapV,
          ),
        ],
      );
    }

    List<pw.Partition> row = [
      pw.Partition(
        flex: (1 * config.days).ceil(),
        child: pw.Container(),
      ),
    ];
    for (int n = 0; n < config.days; n++) {
      DateTime dt = date.add(Duration(days: n));
      row.add(
        _labelCell(
          dt: dt,
          currentDay: false,
          weekend: false,
        ),
      );
    }
    allDayWidgets.add(
      pw.Partitions(
        children: row,
      ),
    );
  }

  // build an entries "length" map
  void _prepareEntriesLengths(
    DateTime dt,
  ) {
    for (int n = 0; n < config.days; n++) {
      List<Entry> some =
          entries.forDate(dt).where((Entry e) => e.allDay).toList();
      dt = dt.add(Duration(days: 1));
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
  }
}
