import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Holiday.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/HolidaysDE.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/MonthView.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Special.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/SpecialDE.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Config.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/WeekView.dart';
import 'package:pdf/widgets.dart' as pw;

enum CustomCalendarMode { day, week, month, workDays, threeDays }

extension DateTimeExtension on DateTime {
  int get weekOfYear {
    final startOfYear = DateTime(year, 1, 1);
    final weekNumber =
        ((difference(startOfYear).inDays + startOfYear.weekday) / 7).ceil();
    return weekNumber;
  }
}

class CustomCalendar {
  final Entries entries;

  final int year;
  final int month;
  final int day;

  final bool holidaysDE;
  final bool specialsDE;
  final CountyDE county;

  final Config config;

  final DateFormat df = DateFormat('MM-dd');

  late final Map<String, Holiday> holidays;
  late final Map<String, Special> specials;

  final CustomCalendarMode mode;

  CustomCalendar({
    this.year = 2024,
    this.month = 2,
    this.day = 1,
    required this.entries,
    this.holidaysDE = true,
    this.specialsDE = true,
    this.county = CountyDE.none,
    this.config = const Config(),
    this.mode = CustomCalendarMode.month,
  });

  pw.Widget build() {
    initializeDateFormatting(config.locale);

    holidays = holidaysDE
        ? HolidaysDE(
            year: year,
            county: CountyDE.hh, // TODO
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
      date: DateTime(year, month, day),
      config: config,
      entries: entries,
      holidays: holidays,
      specials: specials,
    ).build();
  }

  pw.Widget monthView() {
    return MonthView(
      year: year,
      month: month,
      config: config,
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
      case 'threeDays': // TODO
        return CustomCalendarMode.threeDays;
      case 'workDays': // TODO
        return CustomCalendarMode.workDays;
      case 'day': // TODO
        return CustomCalendarMode.day;
    }
    return CustomCalendarMode.month;
  }
}
