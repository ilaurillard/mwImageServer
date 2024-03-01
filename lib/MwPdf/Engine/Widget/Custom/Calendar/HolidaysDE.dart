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

import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Holiday.dart';
import 'package:intl/intl.dart';

enum CountyDE {
  none,
  bw,
  by,
  be,
  bb,
  hb,
  hh,
  he,
  mv,
  ni,
  nw,
  rp,
  sl,
  sn,
  st,
  sh,
  th,
}

class HolidaysDE {
  final int year;
  final CountyDE? county;

  final bool withFronleichnam;
  final bool withMariaehimmelfahrt;

  HolidaysDE({
    required this.year,
    required this.county,
    this.withFronleichnam = true,
    this.withMariaehimmelfahrt = true,
  });

  Map<String, Holiday> basic = {
    '01-01': Holiday(name: 'Neujahr'),
    '05-01': Holiday(name: 'Maifeiertag'),
    '10-03': Holiday(name: 'Tag der D. Einheit'),
    '12-25': Holiday(name: 'Weihnachten'),
    '12-26': Holiday(name: '2. Weihnachtstag'),
  };

  static const heiligeDreiKoenige = 'hdk';
  static const frauentag = 'ft';
  static const mariaeHimmelfahrt = 'mh';
  static const reformationstag = 'rt';
  static const allerheiligen = 'ah';
  static const bussBettag = 'bb';
  static const fronleichnam = 'fl';

  Map<String, List<CountyDE>> optional = {
    // Hl. Drei Könige nur  BW, BY, ST
    heiligeDreiKoenige: [
      CountyDE.bw,
      CountyDE.by,
      CountyDE.st,
    ],
    // Frauentag nur BE
    frauentag: [
      CountyDE.be,
    ],
    // Mariä Himmelfahrt nur  SL BY*
    mariaeHimmelfahrt: [
      CountyDE.sl,
      CountyDE.by,
    ],
    // Reformationstag nur BB HB HH MV NI SN ST SH TH
    reformationstag: [
      CountyDE.bb,
      CountyDE.hb,
      CountyDE.hh,
      CountyDE.mv,
      CountyDE.ni,
      CountyDE.sn,
      CountyDE.st,
      CountyDE.sh,
      CountyDE.th,
    ],
    // Allerheiligen nur BW BY NW RP SL
    allerheiligen: [
      CountyDE.bw,
      CountyDE.by,
      CountyDE.nw,
      CountyDE.rp,
      CountyDE.sl,
    ],
    // Buß- und Bettag, nur SN
    bussBettag: [CountyDE.sn],
    // Fronleichnam nur BW BY HE NW RP SL SN* TH*
    fronleichnam: [
      CountyDE.bw,
      CountyDE.by,
      CountyDE.he,
      CountyDE.nw,
      CountyDE.rp,
      CountyDE.sl,
      CountyDE.sn,
      CountyDE.th,
    ],
  };

  Map<String, Holiday> map() {
    DateFormat df = DateFormat('MM-dd');

    // https://feiertage.net/bundeslaender.php

    // 1. 9 sind fest für alle, davon 4 beweglich um Ostern
    // 2. Dann gibt es 4 feste, aber nur in bestimmten BL
    // 3. Dann gibt es BB nur in Sachsen, beweglich
    // 4. Dann gibt es MH, festes Datum aber nur in einigen Gemeinden
    // 5. Dann noch Fronleichnam beweglich zu Ostern in einigen BL fest in Sachen und Thüringen je nach Gemeinde (bearbeitet)
    //
    // Also sind es nur MH und FL .. wo man bestimmen muss, ob die für einen Fahrer gelten ...
    // D.h. ich würde hier zwei Checkboxes am Fahrer oder am Mandanten vorsehen:
    //   Fronleichnam ja/nein, Mariä Himmelfahrt ja/nein (bearbeitet)

    Map<String, Holiday> holidays = basic;

    // Karfreitag ist 2 Tage vor Ostersonntag
    // Ostermontag ist 1 Tag nach Ostersonntag
    // Chr. Himmelfahrt ist 39 Tage nach Ostersonntag
    // Pfingstmontag ist 50 Tage nach Ostersonntag

    DateTime eastSun = osternForYear(year);

    holidays[df.format(eastSun)] = Holiday(name: 'Ostersonntag');

    DateTime karFreitag = eastSun.subtract(Duration(days: 2));
    holidays[df.format(karFreitag)] = Holiday(name: 'Karfreitag');

    DateTime ostermontag = eastSun.add(Duration(days: 1));
    holidays[df.format(ostermontag)] = Holiday(name: 'Ostermontag');

    DateTime himmelfahrt = eastSun.add(Duration(days: 39));
    holidays[df.format(himmelfahrt)] = Holiday(name: 'Chr. Himmelfahrt');

    DateTime pfingstsonntag = eastSun.add(Duration(days: 49));
    holidays[df.format(pfingstsonntag)] = Holiday(name: 'Pfingstsonntag');

    DateTime pfingstmontag = eastSun.add(Duration(days: 50));
    holidays[df.format(pfingstmontag)] = Holiday(name: 'Pfingstmontag');

    // Fronleichnam ist 60 Tage nach Ostersonntag
    // --> nur BW BY HE NW RP SL SN* TH*
    DateTime fl = eastSun.add(Duration(days: 60));

    // ----

    // 4. Advent = Letzter Sonntag vor dem 25. Dez. (Weihnachten)
    // Buß- und Bettag = 32 Tage vor 4. Advent ---> nur SN
    DateTime tempXmas = DateTime.parse('$year-12-25');
    do {
      tempXmas = tempXmas.subtract(Duration(days: 1));
    } while (tempXmas.weekday != 7);
    DateTime advent4 = tempXmas;
    DateTime bussundbettag = advent4.subtract(Duration(days: 32));

    // ----------------- je nach Bundesland

    holidays[df.format(bussundbettag)] = Holiday(
      name: 'Buß- und Bettag',
      inMyCounty: optional[bussBettag]!.contains(county),
    );

    holidays['01-06'] = Holiday(
      name: 'Hl. Drei Könige',
      inMyCounty: optional[heiligeDreiKoenige]!.contains(county),
    );

    holidays['03-08'] = Holiday(
      name: 'Frauentag',
      inMyCounty: optional[frauentag]!.contains(county),
    );

    holidays['10-31'] = Holiday(
      name: 'Reformationstag',
      inMyCounty: optional[reformationstag]!.contains(county),
    );

    holidays['11-01'] = Holiday(
      name: 'Allerheiligen',
      inMyCounty: optional[allerheiligen]!.contains(county),
    );

    holidays[df.format(fl)] = Holiday(
      name: 'Fronleichnam',
      inMyCounty: withFronleichnam && optional[fronleichnam]!.contains(county),
    );

    holidays['08-15'] = Holiday(
      name: 'M. Himmelfahrt',
      inMyCounty: withMariaehimmelfahrt &&
          optional[mariaeHimmelfahrt]!.contains(county),
    );

    return holidays;
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