import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Widget.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:pdf/widgets.dart' as pw;

class Datasource {
  final String key;

  // image/svg
  final String url;

  // api/bucket/98/resource/$resourceId1
  final String file;

  // svg/image... (xml,base64)
  String binary;

  // charts/tables
  final List<List<dynamic>> values;

  // chart data (pie!)
  final List<Map<String, dynamic>> data;

  // reusable widget
  final pw.Widget? widget;

  // placeholder text
  final String text;

  Datasource(
    this.key, {
    this.binary = '',
    this.file = '',
    this.url = '',
    this.values = const [],
    this.data = const [],
    this.widget,
    this.text = '',
  });

  static Datasource fromJson(
    String key,
    Dict json,
    State state,
  ) {
    String binary = '';
    try {
      binary = json['binary'] as String? ?? '';
      if (binary.isNotEmpty && !binary.startsWith('<')) {
        binary = String.fromCharCodes(base64.decode(binary));
      }
    } catch (e) {
      throw Exception('Datasource "$key": $e');
    }

    return Datasource(
      key,
      binary: binary,
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
        state,
      ),
      text: json['text'] as String? ?? '',
    );
  }

  Future<void> load(
    FileStorage fileStorage,
  ) async {

    if (file.isNotEmpty) {
      binary = '';
      print('load resource "$key" from file: $file');
      // TODO a bucket resource



      // ---> put into binary
    } else if (url.isNotEmpty) {
      print('load source "$key" from url: $url');

      binary = '';

      // cacheKey, load from remote, cache, file
      String cacheKey = fileStorage.cacheKey(url);

      if (await fileStorage.hasCache(cacheKey)) {
        binary = await fileStorage.loadCache(cacheKey);
      }
      print(
        'loaded ${binary.length} bytes from cache ($cacheKey)',
      );

      if (binary.isEmpty) {
        http.Response response = await http.get(
          Uri.parse(url),
        );
        print(
          'received ${response.bodyBytes.length} bytes, status ${response
              .statusCode}',
        );
        if (response.statusCode < 400) {
          binary = response.body;
          // print(
          //   'put ${binary.length} bytes to cache ($cacheKey)',
          // );
          fileStorage.putCache(
            cacheKey,
            binary,
          );
        }
      }
    }
  }

  String svgFromBinary() {
    String binary = this.binary;
    if (binary.isEmpty) {
      throw Exception('Source "$key" has no data (svg)');
    }
    if (!binary.startsWith('<')) {
      throw Exception('Source "$key" data does not start with "<" (svg)');
    }
    return binary;
  }

  pw.ImageProvider imageFromBinary() {
    if (binary.isEmpty) {
      throw Exception('Source "$key" has no data (image)');
    }
    try {
      return pw.MemoryImage(
        Uint8List.fromList(binary.codeUnits),
      );
    } catch (e) {
      throw Exception('Source "$key": $e');
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
