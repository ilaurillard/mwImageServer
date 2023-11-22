import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Widget.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:pdf/widgets.dart' as pw;

class Datasource {
  final String key;

  // image/svg
  final String url;

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

  // api/bucket/98/resource/$resourceId1
  final String resourceId;
  final int bucketId;
  final Token? token;

  Datasource(
    this.key, {
    this.binary = '',
    this.url = '',
    this.values = const [],
    this.data = const [],
    this.widget,
    this.text = '',
    this.resourceId = '',

    this.bucketId = -1,
    this.token,
  });

  static Datasource fromJson(
    String key,
    Dict json,
    State state, {
    int bucketId = -1,
    Token? token,
  }) {
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
      resourceId: json['resource'] as String? ?? '',
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
      bucketId: bucketId,
      token: token,
    );
  }

  Future<void> load(
    FileStorage fileStorage,
    SqliteStorage? sqliteStorage,
  ) async {
    if (url.isNotEmpty) {
      await _loadUrl(
        fileStorage,
      );
    } else if (resourceId.isNotEmpty) {
      await _loadResource(
        fileStorage,
        sqliteStorage,
      );
    }
  }

  Future<void> _loadResource(
    FileStorage fileStorage,
    SqliteStorage? sqliteStorage,
  ) async {
    binary = '';

    print('source "$key" from resource: $resourceId');

    if (sqliteStorage == null) {
      throw Exception('Have no database');
    }

    Resource res = await sqliteStorage.resources.load(
      bucketId,
      resourceId,
    );

    if (token == null || !token!.accessResource(res)) {
      throw Exception('Token has no access to resource');
    }

    // ---> put into binary
    binary = String.fromCharCodes(
      await fileStorage.fileData(res),
    );
  }
  Future<void> _loadUrl(
    FileStorage fileStorage,
  ) async {
    print('source "$key" from url: $url');

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
        'received ${response.bodyBytes.length} bytes, status ${response.statusCode}',
      );
      if (response.statusCode < 400) {
        binary = response.body;
        fileStorage.putCache(
          cacheKey,
          binary,
        );
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