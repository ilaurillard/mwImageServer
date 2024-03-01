// bw: 'Baden-Württemberg'
// by: 'Bayern'
// be: 'Berlin'
// bb: 'Brandenburg'
// hb: 'Bremen'
// hh: 'Hamburg'
// he: 'Hessen'
// mv: 'Mecklenburg-Vorpommern'
// ni: 'Niedersachsen'
// nw: 'Nordrhein-Westfalen'
// rp: 'Rheinland-Pfalz'
// sl: 'Saarland'
// sn: 'Sachsen'
// st: 'Sachsen-Anhalt'
// sh: 'Schleswig-Holstein'
// th: 'Thüringen'

import 'package:intl/intl.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Special.dart';

// TODO sternzeichen
// TODO moonphases
// TODO tide

class SpecialDE {
  final int year;

  SpecialDE({
    required this.year,
  });

  Map<String, Special> map() {
    DateFormat df = DateFormat('MM-dd');

    Map<String, Special> special = {};

    DateTime sumtime1 = DateTime.parse('$year-04-01 12:00');
    do {
      sumtime1 = sumtime1.subtract(Duration(days: 1));
    } while (sumtime1.weekday != 7);

    String key = df.format(sumtime1);
    if (special[key] == null) {
      special[key] = Special();
    }
    special[key]!.add(
      'Beginn Sommerzeit',
      State.materialCodes['schedule']!,
    );

    DateTime sumtime2 = DateTime.parse('$year-11-01 12:00');
    do {
      sumtime2 = sumtime2.subtract(Duration(days: 1));
    } while (sumtime2.weekday != 7);

    key = df.format(sumtime2);
    if (special[key] == null) {
      special[key] = Special();
    }
    special[key]!.add(
      'Ende Sommerzeit',
      State.materialCodes['schedule']!,
    );

    return special;
  }

  DateTime osternForYear(int year) {
    // if (year < 1972 || year > 2050) {
    //   throw Exception('Year out of range');
    // }
    // int a = year % 19;
    // int b = year % 4;
    // int c = year % 7;
    // int d = (19 * a + 24) % 30;
    // int e = (2 * b + 4 * c + 6 * d + 5) % 7;
    // int x = 22 + d + e;
    // int day = x - 31;
    // int month = 4;
    // if (x <= 31) {
    //   day = x;
    //   month = 3;
    // }
    // return DateTime(year, month, day);

    if (year < 1583) {
      throw ArgumentError.value(
          year, 'year', 'Year cannot be earlier than 1583.');
    }
    if (year > 4099) {
      throw ArgumentError.value(
          year, 'year', 'Year cannot be later than 4099.');
    }

    int g = year % 19;
    int c = year ~/ 100;
    int h = (c - (c ~/ 4) - ((8 * c + 13) ~/ 25) + 19 * g + 15) % 30;
    int i =
        h - (h ~/ 28) * (1 - (h ~/ 28) * (29 ~/ (h + 1)) * ((21 - g) ~/ 11));

    int day = i - ((year + (year ~/ 4) + i + 2 - c + (c ~/ 4)) % 7) + 28;
    int month = 3;

    if (day > 31) {
      month++;
      day -= 31;
    }

    return DateTime.utc(year, month, day);
  }
}
