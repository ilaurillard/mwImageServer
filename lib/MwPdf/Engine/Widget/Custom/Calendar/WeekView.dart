import 'package:intl/intl.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Holiday.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Special.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Config.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/WeekViewAllDay.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/WeekViewDay.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class WeekView {
  final Entries entries;

  DateTime localDate = DateTime.now();

  late final DateTime date;

  final Config config;

  final DateFormat df = DateFormat('MM-dd');
  late final DateFormat dfWeekday;

  final Map<String, Holiday> holidays;
  final Map<String, Special> specials;

  WeekView({
    required this.date,
    required this.entries,
    this.config = const Config(),
    this.holidays = const {},
    this.specials = const {},
  });

  pw.Widget build() {
    return pw.Column(
      children: [
        WeekViewAllDay(
          date: date,
          entries: entries,
          config: config,
          holidays: holidays,
          specials: specials,
        ).build(),
        pw.SizedBox(height: 3 * PdfPageFormat.mm),
        WeekViewDay(
          date: date,
          entries: entries,
          config: config,
          holidays: holidays,
          specials: specials,
        ).build(),
      ],
    );
  }
}
