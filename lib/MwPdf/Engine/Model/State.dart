import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Datasource.dart';

class State {
  static const material = 'material';

  static Map<String, pw.Font> fonts = {};
  static Map<String, String> materialCodes = {};

  final String baseDir;

  String value = '';
  int pageNumber = 0;
  int pagesCount = 0;

  Map<String, Datasource> sources = {};

  final FileStorage fileStorage;
  final SqliteStorage? sqliteStorage;

  State({
    required this.baseDir,
    required this.fileStorage,
    this.sqliteStorage,
  });

  Future<void> init() async {
    if (fonts.isEmpty) {
      await loadBuiltinFonts();
      await loadMaterialFont();
    }

    await loadSources();
  }

  Future<void> loadBuiltinFonts() async {
    print('load builtin fonts');
    fonts['openSansRegular'] = pw.Font.ttf(
      ByteData.view(
        (await File('$baseDir/assets/Open Sans Regular.ttf').readAsBytes())
            .buffer,
      ),
    );
  }

  Future<void> loadMaterialFont() async {
    print('load material font');
    fonts[material] = pw.Font.ttf(
      ByteData.view(
        (await File('$baseDir/assets/MaterialIcons-Regular.ttf').readAsBytes())
            .buffer,
      ),
    );

    List<String> lines =
        File('$baseDir/assets/MaterialIcons-Regular.codepoints')
            .readAsLinesSync();
    for (String line in lines) {
      List<String> splitted = line.split(' ');
      materialCodes[splitted[0]] = splitted[1];
    }
  }

  Future<void> loadSources() async {
    print('load sources (${sources.length})');
    for (String key in sources.keys) {
      await sources[key]!.load(
        fileStorage,
        sqliteStorage,
      );
    }
  }

  static State fromJson(
    Dict json, {
    required String baseDir,
    required FileStorage fileStorage,
    SqliteStorage? sqliteStorage,
    int bucketId = -1,
    required Token token,
  }) {
    State state = State(
      baseDir: baseDir,
      fileStorage: fileStorage,
      sqliteStorage: sqliteStorage,


    );

    state.sources = json.map(
      (key, value) {
        return MapEntry(
          key,
          Datasource.fromJson(
            key,
            value as Dict,
            state,
            bucketId: bucketId,
            token: token,
          ),
        );
      },
    );

    return state;
  }

  pw.Font materialFont() {
    return fonts[material]!;
  }

  Datasource source(
    String? key,
  ) {
    if (key != null && key.isNotEmpty && sources[key] == null) {
      print('No resource available for "$key"');
    }
    return sources[key ?? ''] ?? Datasource(key ?? '');
  }
}
