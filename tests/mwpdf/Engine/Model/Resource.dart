import 'package:intl/intl.dart';
import 'package:mwcdn/Etc/Types.dart';

class Resource {
  final String url;

  // api/bucket/98/resource/$resourceId1
  final String file;

  final String binary;

  final List<List<dynamic>> values;
  final List<Map<String, dynamic>> data;

  Resource({
    this.binary = '',
    this.file = '',
    this.url = '',
    this.values = const [],
    this.data = const [],
  });

  static Resource fromJson(
    Dict json,
  ) {
    List<dynamic> tempValues = json['values'] as List<dynamic>? ?? [];
    List<dynamic> tempData = json['data'] as List<dynamic>? ?? [];
    String locale = json['valuesLocale'] as String? ?? 'de_DE';
    return Resource(
      binary: json['binary'] as String? ?? '',
      url: json['url'] as String? ?? '',
      file: json['file'] as String? ?? '',
      values: tempValues
          .map(
            (dynamic row) => applyFormats(
              _valuesFormats(json, locale),
              row as List<dynamic>,
            ),
          )
          .toList(),
      data: tempData.map((dynamic row) => row as Dict).toList(),
    );
  }

  Future<void> load() async {
    print('load resource');
    if (binary.isNotEmpty) {
      return;
    }
    if (values.isNotEmpty) {
      return;
    }
    if (url.isNotEmpty) {
      // TODO cachekey, load from remote, cache, file
    }
    if (file.isNotEmpty) {
      // TODO a bucket resource
    }
  }

  static List<dynamic> applyFormats(
    Map<int, NumberFormat?> formats,
    List<dynamic> row,
  ) {
    List<dynamic> res = [];
    int nr = 0;
    for (dynamic value in row) {
      NumberFormat? f = formats[nr];
      if (value == null) {
        res.add('');
      } else {
        try {
          res.add(f != null ? f.format(value) : value.toString());
        } catch (e) {
          res.add('?');
        }
      }
      nr++;
    }
    return res;
  }

  static Map<int, NumberFormat?> _valuesFormats(
    Dict json,
    String locale,
  ) {
    Map<int, NumberFormat?>? formats = {};
    Map<String, dynamic> temp =
        json['valuesFormats'] as Map<String, dynamic>? ?? {};
    if (json['valuesFormats'] != null) {
      formats = Map.fromEntries(
        temp.entries.map(
          (
            MapEntry<String, dynamic> entry,
          ) {
            String? f = entry.value as String?;
            return MapEntry(
              int.tryParse(entry.key) ?? 0,
              f != null ? NumberFormat(f, locale) : null,
            );
          },
        ),
      );
    }
    return formats;
  }
}
