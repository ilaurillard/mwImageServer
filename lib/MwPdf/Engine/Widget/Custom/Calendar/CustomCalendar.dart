import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Holiday.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/HolidaysDE.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/MonthView.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Special.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/SpecialDE.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Styles.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/WeekView.dart';
import 'package:pdf/widgets.dart' as pw;

enum CustomCalendarMode { day, week, month, workDays, threeDays }

class CustomCalendar {
  final Entries entries;

  final String locale;
  final int year;
  final int month;

  final bool holidaysDE;
  final bool specialsDE;
  final CountyDE county;

  final Styles styles;

  final DateFormat df = DateFormat('MM-dd');

  late final Map<String, Holiday> holidays;
  late final Map<String, Special> specials;

  final CustomCalendarMode mode;

  CustomCalendar({
    this.year = 2024,
    this.month = 2,
    required this.entries,
    this.locale = 'de_DE',
    this.holidaysDE = true,
    this.specialsDE = true,
    this.county = CountyDE.none,
    this.styles = const Styles(),
    this.mode = CustomCalendarMode.month,
  });

  pw.Widget build() {
    initializeDateFormatting(locale);

    holidays = holidaysDE
        ? HolidaysDE(
            year: year,
            county: CountyDE.hh,
          ).map()
        : {};
    specials = specialsDE
        ? SpecialDE(
            year: year,
          ).map()
        : {};

    if (mode == CustomCalendarMode.week) {
      return weekView();
    } else if (mode == CustomCalendarMode.month) {
      return monthView();
    }
    throw Exception('Not supported');
  }

  pw.Widget weekView() {
    return WeekView(
      entries: entries,
    ).build();
  }

  pw.Widget monthView() {
    return MonthView(
      year: year,
      month: month,
      styles: styles,
      locale: locale,
      entries: entries,
      holidays: holidays,
      specials: specials,
    ).build();
  }

  static CustomCalendarMode parseMode(
    String? json,
  ) {
    switch (json) {
      case 'week':
        return CustomCalendarMode.week;
      case 'threeDays':
        return CustomCalendarMode.threeDays;
      case 'workDays':
        return CustomCalendarMode.workDays;
      case 'day':
        return CustomCalendarMode.day;
    }
    return CustomCalendarMode.month;
  }
}
