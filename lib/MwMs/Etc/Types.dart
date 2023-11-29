typedef Dict = Map<String, dynamic>;

typedef KeyValue = Map<String, String>;

typedef Ids = List<int>;

class Types {
  // ----------------

  static Ids idListFromDict(
    Dict data,
    String key, {
    int max = 100,
  }) {
    Ids list = Ids.from(
      data[key] as List? ?? [],
    ).toSet().toList().where((int i) => i > 0).toList();
    list.sort();
    if (list.length > max) {
      return list.sublist(0, max);
    }
    return list;
  }

  // ----------------

  static List<String> stringListFromDict(
    Dict data,
    String key,
  ) {
    List<String> list = List<String>.from(
      data[key] as List? ?? [],
    );
    return list;
  }

  // ----------------

  static Ids idListFromCsv(
    String csv,
  ) {
    if (csv.isEmpty) {
      return [];
    }
    List<String> ls = (List<String>.from(csv.split(';')));
    return ls.map((String s) => int.parse(s)).toList();
  }

  // ----------------

  static bool boolFromDict(
    Dict data,
    String key,
  ) {
    return data[key] as bool? ?? false;
  }

  // ----------------

  static int intFromDict(
    Dict data,
    String key,
  ) {
    return data[key] as int? ?? 0;
  }

  // ----------------

  static String stringData(
    Dict data,
    String key,
  ) {
    return data[key] as String? ?? '';
  }
}
