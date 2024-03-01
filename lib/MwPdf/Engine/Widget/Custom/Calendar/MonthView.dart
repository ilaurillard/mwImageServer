import 'package:intl/intl.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entry.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Holiday.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Special.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Styles.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MonthView {
  final Entries entries;

  final String locale;
  final int year;
  final int month;

  final Styles styles;

  final DateFormat df = DateFormat('MM-dd');

  final Map<String, Holiday> holidays;
  final Map<String, Special> specials;

  MonthView({
    this.year = 2024,
    this.month = 2,
    required this.entries,
    this.locale = 'de_DE',
    this.styles = const Styles(),
    this.holidays = const {},
    this.specials = const {},
  });

  pw.Widget build() {
    pw.BorderSide border = pw.BorderSide(
      color: styles.borderColor,
    );

    DateTime localDate = DateTime.now();

    DateTime start = DateTime(year, month, 1, 12);
    DateTime end = DateTime(year, month + 1, 1, 12).subtract(
      const Duration(days: 1),
    );
    int startId = start.weekday - 1;
    int endId = end.difference(start).inDays + startId + 1;

    return pw.GridView(
      childAspectRatio: styles.cellAspect,
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
              currentDay: styles.highlightToday &&
                  d.year == localDate.year &&
                  d.month == localDate.month &&
                  d.day == localDate.day,
              weekend: d.weekday == 6 || d.weekday == 7,
            ),
          );
        },
      ),
    );
  }

  pw.Widget dayInMonth(
    DateTime date, {
    required bool currentMonth,
    required bool currentDay,
    required bool weekend,
  }) {
    String key = df.format(date);
    Holiday? holi = holidays[key];
    Special? special = specials[key];

    String text = '${date.day}';

    PdfColor color = styles.cellColor;

    pw.TextStyle style = styles.textStyle;

    if (weekend || (holi != null && holi.inMyCounty)) {
      style = style.merge(pw.TextStyle(
        fontWeight: weekend && styles.weekendStrong
            ? pw.FontWeight.bold
            : pw.FontWeight.normal,
        color: styles.textColorSpecial,
      ));
      color = styles.cellColorEnd;
    }

    if (currentDay) {
      style = style.apply(color: styles.textColorCurrent);
      color = styles.cellColorToday;
    }

    pw.Widget? label;
    if (holi != null) {
      label = pw.Text(
        holi.inMyCounty ? holi.name : '(${holi.name})',
        style: pw.TextStyle(
          color: styles.textColorSpecial,
        ),
      );
    } else if (date.day == 1 && holi == null) {
      label = pw.Text(
        DateFormat.MMMM(locale).format(date),
        style: style,
      );
    }

    List<Entry> todayEntries = entries.forDate(date);

    // if (todayEntries.isNotEmpty) {
    //   color = color.shade(0.6);
    //   style = style.merge(pw.TextStyle(
    //     fontWeight: pw.FontWeight.bold,
    //   ));
    // }

    pw.Widget? specialIcons = createSpecialIcons(special);

    pw.Container c = pw.Container(
      padding: const pw.EdgeInsets.symmetric(
        vertical: 1 * PdfPageFormat.mm,
        horizontal: 1 * PdfPageFormat.mm,
      ),
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
            pw.Container(
              padding: pw.EdgeInsets.fromLTRB(
                0,
                3.5 * PdfPageFormat.mm,
                0,
                0,
              ),
              child: createSummary(
                todayEntries,
              ),
            ),
        ],
      ),
    );
    return currentMonth
        ? c
        : pw.Opacity(
            opacity: 0.35,
            child: c,
          );
  }

  pw.Widget? createSpecialIcons(Special? special) {
    if (special != null) {
      return pw.Align(
        alignment: pw.Alignment.bottomLeft,
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: special.items.entries
              .map(
                (entry) => pw.Icon(
                  size: 3 * PdfPageFormat.mm,
                  pw.IconData(
                    int.parse(
                      entry.value,
                      radix: 16,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }
    return null;
  }

  pw.Widget createSummary(
    List<Entry> todayEntries,
  ) {
    List<pw.Widget> children = [];
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
