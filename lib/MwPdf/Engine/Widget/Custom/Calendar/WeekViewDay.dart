import 'package:intl/intl.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Config.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Holiday.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Special.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class WeekViewDay {
  final Entries entries;

  DateTime localDate = DateTime.now();

  late final DateTime date;

  final Config config;

  final DateFormat df = DateFormat('MM-dd');
  late final DateFormat dfWeekday;

  final Map<String, Holiday> holidays;
  final Map<String, Special> specials;

  WeekViewDay({
    required this.date,
    required this.entries,
    this.config = const Config(),
    this.holidays = const {},
    this.specials = const {},
  }) {
    dfWeekday = DateFormat('EEEE', config.locale);
  }

  pw.Widget build() {
    List<pw.Partition> cols = [
      pw.Partition(
        flex: 1,
        child: _hours(),
      ),
    ];
    for (int n = 0; n < config.days; n++) {
      DateTime dt = date.add(Duration(days: n));
      cols.add(
        _day(
          dt: dt,
          weekend: dt.weekday > 5,
          currentDay: config.highlightToday &&
              dt.year == localDate.year &&
              dt.month == localDate.month &&
              dt.day == localDate.day,
        ),
      );
    }

    return pw.Partitions(
      children: cols,
    );
  }

  pw.Widget _entry({
    required int x,
    required int width,
    required int maxWidth,
  }) {
    double b = 10.0;
    double l = 1.5;
    double h = config.day.heightHour * l;
    double o = config.day.heightHour * (b - config.day.firstHour);

    return pw.Container(
      margin: pw.EdgeInsets.only(
        top: o,
      ),
      height: h,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (x > 0)
            pw.Expanded(
              flex: x,
              child: pw.Container(),
            ),
          pw.Expanded(
            flex: width,
            child: pw.Container(
              decoration: pw.BoxDecoration(
                color: PdfColors.red,
                borderRadius: pw.BorderRadius.all(
                  pw.Radius.circular(config.day.entryCornerRadius),
                ),
              ),
            ),
          ),
          if (maxWidth - width - x > 0)
            pw.Expanded(
              flex: maxWidth - width - x,
              child: pw.Container(),
            ),
        ],
      ),
    );
  }

  pw.Column _hours() {
    List<pw.Container> hours = [];
    for (int n = config.day.firstHour; n <= config.day.lastHour; n++) {
      hours.add(
        pw.Container(
          alignment: pw.Alignment.topRight,
          width: double.infinity,
          padding: pw.EdgeInsets.all(1.5 * PdfPageFormat.mm),
          height: config.day.heightHour,
          child: pw.Text(
            '$n:00',
          ),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            border: pw.Border(
              top: pw.BorderSide(
                color: config.colors.border,
              ),
              right: pw.BorderSide(
                color: config.colors.border,
              ),
            ),
          ),
        ),
      );
    }
    return pw.Column(
      children: hours,
    );
  }

  pw.Column _lines() {
    List<pw.Container> hours = [];
    for (int n = config.day.firstHour; n <= config.day.lastHour; n++) {
      hours.add(
        pw.Container(
          width: double.infinity,
          height: config.day.heightHour,
          decoration: pw.BoxDecoration(
            border: pw.Border(
              top: pw.BorderSide(
                color: config.colors.border,
              ),
            ),
          ),
        ),
      );
    }
    return pw.Column(
      children: hours,
    );
  }

  pw.Partition _day({
    required DateTime dt,
    required bool weekend,
    required bool currentDay,
  }) {
    String key = df.format(dt);
    Holiday? holi = holidays[key];

    PdfColor color = config.colors.cell;
    if (weekend || (holi != null && holi.inMyCounty)) {
      color = config.colors.cellWeekend;
    }

    if (currentDay) {
      color = config.colors.cellToday;
    }

    return pw.Partition(
      flex: 2,
      child: pw.Container(
        decoration: pw.BoxDecoration(
          color: color,
          border: pw.Border(
            left: pw.BorderSide(
              color: config.colors.border,
            ),
          ),
        ),
        height: ((config.day.lastHour - config.day.firstHour + 1) *
            config.day.heightHour) +
            0.1 * PdfPageFormat.mm,
        child: pw.Stack(
          children: [
            _lines(),
            // _entry(
            //   x: 2,
            //   width: 3,
            //   maxWidth: 6,
            // ),
          ],
        ),
      ),
    );
  }
}
