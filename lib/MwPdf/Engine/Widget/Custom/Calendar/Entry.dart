import 'package:intl/intl.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';

enum Repeat {
  no,
  daily,
  weekly,
  monthly,
  yearly,
  weekdays,
}

class Entry {
  final String label;
  final DateTime start;
  final DateTime end;
  final bool allDay;
  final Repeat repeat;
  final Entry? parent;
  final int nr;
  final int group;

  Entry({
    required this.nr,
    required this.label,
    required this.start,
    required this.end,
    this.allDay = false,
    this.repeat = Repeat.no,
    this.parent,
    this.group = 0,
  }) {
    if (end.isBefore(start)) {
      throw Exception('End must be after start');
    }
    Duration d = end.difference(start);
    if (d.inDays > 365) {
      throw Exception('Cannot handle events longer than one year');
    }
    if (d.inMinutes < 15) {
      throw Exception('Must be at least 15 minutes');
    }
  }

  List<Entry> splitIntoDays() {
    List<Entry> list = [];

    DateTime s = start;
    do {
      DateTime e = DateTime(s.year, s.month, s.day + 1, 0, 0, 0);
      list.add(
        Entry(
          nr: 0,
          label: label,
          start: s,
          end: e,
          allDay: allDay,
          repeat: Repeat.no,
          parent: this,
          group: group,
        ),
      );
      s = DateTime(s.year, s.month, s.day + 1, 0, 0, 0);
      if (isSameDay(s, end)) {
        list.add(
          Entry(
            nr: 0,
            label: label,
            start: s,
            end: end,
            allDay: allDay,
            repeat: Repeat.no,
            parent: this,
            group: group,
          ),
        );
        break;
      }
    } while (true);

    return list;
  }

  static bool isSameDay(
    DateTime dateA,
    DateTime dateB,
  ) {
    if (dateB.hour == 0 && dateB.minute == 0) {
      dateB = dateB.subtract(Duration(hours: 12));
    }
    return dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day;
  }

  bool isMultiDay() {
    if (parent != null) {
      return parent!.isMultiDay();
    }

    if (!isSameDay(start, end)) {
      // print("$start $end");
      return true;
    }

    return false;
  }

  bool beganPreviousDay() {
    if (parent != null && parent!.start.isBefore(start)) {
      return true;
    }
    return false;
  }

  bool continuesNextDay() {
    if (parent != null && parent!.end.isAfter(end)) {
      return true;
    }
    return false;
  }

  static Entry fromJson(
    Dict json,
      int nr,
  ) {
    DateTime start = DateTime.parse(json['start'] as String? ?? '');
    DateTime end = DateTime.parse(json['end'] as String? ?? '');
    bool allDay = json['allDay'] as bool? ?? false;

    if (allDay) {
      start = DateTime(start.year, start.month, start.day, 0, 0, 0);
      end = DateTime(end.year, end.month, end.day + 1, 0, 0, 0);
    } else {
      // remove seconds
      start = DateTime(
          start.year, start.month, start.day, start.hour, start.minute, 0);
      end = DateTime(end.year, end.month, end.day, end.hour, end.minute, 0);
    }

    return Entry(
      nr: nr,
      label: json['value'] as String? ?? '',
      start: start,
      end: end,
      allDay: allDay,
      repeat: repeatEnum(json['repeat'] as String? ?? ''),
      group: json['group'] as int? ?? 0,
    );
  }

  static Repeat repeatEnum(
    String? json,
  ) {
    switch (json) {
      case 'daily':
        return Repeat.daily;
      case 'weekly':
        return Repeat.weekly;
      case 'monthly':
        return Repeat.monthly;
      case 'yearly':
        return Repeat.yearly;
      case 'weekdays':
        return Repeat.weekdays;
    }
    return Repeat.no;
  }

  @override
  String toString() {
    if (allDay) {
      return label;
    }
    // if (parent != null) {
    DateFormat df1 = DateFormat('HH:mm');

    String s = df1.format(start);
    String e = df1.format(end);
    // if (beganPreviousDay()) {
    //   s = '(0:00)';
    // }
    // if (continuesNextDay()) {
    //   e = '(0:00)';
    // }
    return '$label $s-$e';
    // }
    // DateFormat df1 = DateFormat('yyyy-MM-dd HH:mm');
    // return label + ': ' + df1.format(start) + ' ' + df.format(end);
  }

  Duration length() {
    return end.difference(start);
  }
}
