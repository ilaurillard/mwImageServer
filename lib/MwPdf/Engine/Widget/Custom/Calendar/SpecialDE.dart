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
}
