import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Widget.dart';
import 'package:pdf/widgets.dart' as pw;

class Resource {
  final String key;

  // image/svg
  final String url;

  // api/bucket/98/resource/$resourceId1
  final String file;

  // svg/image... (base64)
  final String binary;

  // charts/tables
  final List<List<dynamic>> values;

  // chart data (pie!)
  final List<Map<String, dynamic>> data;

  // reusable widget
  final pw.Widget? widget;

  // placeholder text
  final String text;

  Resource(
    this.key, {
    this.binary = '',
    this.file = '',
    this.url = '',
    this.values = const [],
    this.data = const [],
    this.widget,
    this.text = '',
  });

  static Resource fromJson(
    String key,
    Dict json,
    Resources resources,
  ) {
    return Resource(
      key,
      binary: json['binary'] as String? ?? '',
      url: json['url'] as String? ?? '',
      file: json['file'] as String? ?? '',
      values: (json['values'] as List<dynamic>? ?? [])
          .map(
            (dynamic row) => applyFormats(
              _valuesFormats(
                json,
                json['valuesLocale'] as String? ?? 'de_DE',
              ),
              row as List<dynamic>,
            ),
          )
          .toList(),
      data: (json['data'] as List<dynamic>? ?? [])
          .map((dynamic row) => row as Dict)
          .toList(),
      widget: Widget.parse(
        json['widget'] as Dict? ?? {},
        resources,
      ),
      text: json['text'] as String? ?? '',
    );
  }

  Future<void> load() async {
    if (file.isNotEmpty) {
      print('load resource "$key" from file: $file');
      // TODO a bucket resource
      // ---> put into binary
    } else if (url.isNotEmpty) {
      print('load resource "$key" from url: $url');
      // TODO cachekey, load from remote, cache, file
      // ---> put into binary

      // http.Response response = await http.get(
      //   Uri.parse(url),
      // );
      // if (response.statusCode < 400) {
      // binary = response.body;
      // print(response.body);
      // }
    }
  }

  String svgFromBinary() {
    String binary = this.binary;
    if (binary.isEmpty) {
      throw Exception('Resource "$key" has no data');
    }
    if (binary.startsWith('<')) {
      return binary;
    } else {
      try {
        return utf8.decode(
          base64.decode(
            binary,
          ),
        );
      } catch (e) {
        throw Exception('Resource "$key": $e');
      }
    }
  }

  pw.ImageProvider imageFromBinary() {
    if (binary.isEmpty) {
      throw Exception('Resource "$key" has no data');
    }
    try {
      return pw.MemoryImage(
        base64.decode(
          binary,
        ),
      );
    } catch (e) {
      throw Exception('Resource "$key": $e');
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

  @override
  String toString() {
    return 'Resource{key: $key}';
  }
}
