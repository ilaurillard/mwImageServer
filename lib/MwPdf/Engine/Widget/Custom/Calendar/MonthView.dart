import 'package:intl/intl.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entry.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Holiday.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Special.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Config.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MonthView {
  final Entries entries;

  final int year;
  final int month;

  final Config config;

  final DateFormat df = DateFormat('MM-dd');

  final Map<String, Holiday> holidays;
  final Map<String, Special> specials;

  MonthView({
    this.year = 2024,
    this.month = 2,
    required this.entries,
    this.config = const Config(),
    this.holidays = const {},
    this.specials = const {},
  });

  pw.Widget build() {
    pw.BorderSide border = pw.BorderSide(
      color: config.colors.border,
    );

    DateTime localDate = DateTime.now();

    DateTime start = DateTime(year, month, 1, 12);
    DateTime end = DateTime(year, month + 1, 1, 12).subtract(
      const Duration(days: 1),
    );
    int startId = start.weekday - 1;
    int endId = end.difference(start).inDays + startId + 1;

    return pw.Column(
      children: [
        pw.GridView(
          childAspectRatio: config.cellAspect,
          crossAxisCount: 7,
          children: List<pw.Widget>.generate(
            42,
            (int index) {
              DateTime d = start.add(Duration(days: index - startId));
              return pw.Container(
                foregroundDecoration: pw.BoxDecoration(
                  border: pw.Border(
                    top: index < 7 ? border : pw.BorderSide.none,
                    left: border,
                    right: index % 7 == 6 ? border : pw.BorderSide.none,
                    bottom: border,
                  ),
                ),
                child: dayInMonth(
                  d,
                  currentMonth: index >= startId && index < endId,
                  currentDay: config.highlightToday &&
                      d.year == localDate.year &&
                      d.month == localDate.month &&
                      d.day == localDate.day,
                  weekend: d.weekday == 6 || d.weekday == 7,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  pw.Widget dayInMonth(
    DateTime dt, {
    required bool currentMonth,
    required bool currentDay,
    required bool weekend,
  }) {
    String key = df.format(dt);
    Holiday? holi = holidays[key];
    Special? special = specials[key];

    String text = '${dt.day}';

    PdfColor color = config.colors.cell;

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
      color = config.colors.cellWeekend;
    }

    if (currentDay) {
      style = style.apply(color: config.colors.textCurrent);
      color = config.colors.cellToday;
    }

    pw.Widget? label = Config.label(
      holi: holi,
      config: config,
      dt: dt,
      style: style,
    );

    List<Entry> todayEntries = entries.forDate(dt);

    // if (todayEntries.isNotEmpty) {
    //   color = color.shade(0.6);
    //   style = style.merge(pw.TextStyle(
    //     fontWeight: pw.FontWeight.bold,
    //   ));
    // }

    pw.Widget? specialIcons = special?.icons(
      config,
    );

    pw.Container c = pw.Container(
      padding: pw.EdgeInsets.all(config.cellPadding),
      color: color,
      child: pw.Stack(
        fit: pw.StackFit.passthrough,
        children: [
          if (specialIcons != null) specialIcons,
          pw.Container(
            child: pw.Text(
              text,
              textAlign: pw.TextAlign.right,
              style: style,
            ),
          ),
          if (label != null) label,
          if (todayEntries.isNotEmpty)
            createSummary(
              todayEntries,
            ),
        ],
      ),
    );
    return currentMonth
        ? c
        : pw.Opacity(
            opacity: config.colors.muteOpacity,
            child: c,
          );
  }

  pw.Widget createSummary(
    List<Entry> todayEntries,
  ) {
    List<pw.Widget> children = [
      pw.Text('\n'),
      pw.SizedBox(height: config.cellPadding * 2),
    ];
    for (Entry e in todayEntries) {
      children.add(
        pw.Text('$e'),
      );
    }
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: children,
    );
  }
}
