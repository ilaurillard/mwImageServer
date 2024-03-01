import 'package:intl/intl.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entry.dart';

class Entries {
  final List<Entry> entries;

  Map<String, List<Entry>> map = {};

  final DateFormat df = DateFormat('yyyy-MM-dd');

  Entries(this.entries);

  static Entries fromJson(
    List<Dict> json,
  ) {
    List<Entry> entries = [];
    if (json.isNotEmpty) {
      int nr = 0;
      for (Dict i in json) {
        entries.add(Entry.fromJson(i, nr++));
      }
    }
    return Entries(entries).calculate();
  }

  List<Entry> forDate(
    DateTime date,
  ) {
    String key = df.format(date);
    return map[key] ?? [];
  }

  Entries calculate() {
    for (Entry e in entries) {
      String key = df.format(e.start);


      // TODO repeater

      // TODO spanning
      // Duration d = e.end.difference(e.start);
      // print(d.inDays);

      if (e.isMultiDay()) {
        // print(e);
        for (Entry e2 in e.splitIntoDays()) {
          String key2 = df.format(e2.start);
          if (map[key2] == null) {
            map[key2] = [];
          }
          map[key2]!.add(e2);
        }
      }
      else {
        if (map[key] == null) {
          map[key] = [];
        }
        map[key]!.add(e);
      }
    }

    // print(map);

    map.map((String key, List<Entry> value) {
      value.sort((Entry e1, Entry e2) {
        int c = 0;
        if (e1.allDay && !e2.allDay) {
          c = -1;
        }
        if (!e1.allDay && e2.allDay) {
          c = 1;
        }
        if (c == 0) {
          c = e1.start.compareTo(e2.start);
          if (c == 0) {
            c = e2.end.compareTo(e1.end);
            if (c == 0) {
              c = e1.label.compareTo(e2.label);
            }
          }
        }
        return c;
      });
      return MapEntry(key, value);
    });

    // print(map);

    return this;
  }
}
