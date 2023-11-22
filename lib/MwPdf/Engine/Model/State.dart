import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
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

  final Storage storage;

  State({
    required this.baseDir,
    required this.storage,
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
        storage,
      );
    }
  }

  static State fromJson(
    Dict json, {
    required String baseDir,
    required Storage storage,
  }) {
    State state = State(
      baseDir: baseDir,
      storage: storage,
    );

    state.sources = json.map(
      (key, value) {
        return MapEntry(
          key,
          Datasource.fromJson(
            key,
            value as Dict,
            state,
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
