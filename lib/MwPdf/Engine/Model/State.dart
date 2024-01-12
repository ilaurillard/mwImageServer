import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:mwcdn/MwPdf/Service/Hyphenation/hyphenator.dart';
import 'package:mwcdn/MwPdf/Service/Hyphenation/loader.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Datasource.dart';

class State {
  static const material = 'material';

  // be sure to include names in schema
  Map<String, String> builtinFonts = {
    'openSansRegular': 'OpenSans/OpenSans-Regular.ttf',
    'openSansBold': 'OpenSans/OpenSans-Bold.ttf',
    'openSansItalic': 'OpenSans/OpenSans-Italic.ttf',
    'openSansBoldItalic': 'OpenSans/OpenSans-BoldItalic.ttf',
  };

  static Map<String, pw.Font> fonts = {};
  static Map<String, String> materialCodes = {};

  static Map<String, Hyphenator> hyphenators = {};

  final String resDir;

  String value = '';
  int pageNumber = 0;
  int pagesCount = 0;

  Map<String, Datasource> sources = {};

  final Storage storage;

  State({
    required this.resDir,
    required this.storage,
  });

  Future<void> init() async {
    if (fonts.isEmpty) {
      await loadBuiltinFonts();
      await loadMaterialFont();
    }
    if (hyphenators.isEmpty) {
      await loadHyphenation();
    }
    await loadSources();
  }

  Future<void> loadBuiltinFonts() async {
    print('load builtin fonts');

    for (String name in builtinFonts.keys) {
      print(' font: $name, file: ${builtinFonts[name]}');
      fonts[name] = pw.Font.ttf(
        ByteData.view(
          (await File('$resDir/fonts/${builtinFonts[name]}').readAsBytes())
              .buffer,
        ),
      );
    }
  }

  Future<void> loadMaterialFont() async {
    print('load material font');
    fonts[material] = pw.Font.ttf(
      ByteData.view(
        (await File('$resDir/fonts/MaterialIcons-Regular.ttf').readAsBytes())
            .buffer,
      ),
    );

    List<String> lines = File('$resDir/fonts/MaterialIcons-Regular.codepoints')
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
    required String resDir,
    required Storage storage,
  }) {
    State state = State(
      resDir: resDir,
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

  pw.Hyphenation hyphenator({
    String language = 'de',
  }) {
    if (hyphenators[language] == null) {
      print('No hyphenator for language "$language"!');
    }
    return (String word) {
      if (word.length > 3) {
        if (hyphenators[language] != null) {

          List<String> list;
          String trail = word.substring(word.length - 1);
          if (trail.contains(RegExp(r'^\W$'))) {
            word = word.substring(0, word.length - 1);
            list = hyphenators[language]!.hyphenateWordToList(word);
            list.last += trail;
          }
          else {
            list = hyphenators[language]!.hyphenateWordToList(word);
          }

          return list;
        }
      }
      return [word];
    };
  }

  Future<void> loadHyphenation() async {
    print('load hyphenation files');

    // TODO support more languages
    hyphenators['de'] = Hyphenator(
      resource: await Loader.load(
        File('$resDir/tex/hyph-de-1996.tex'),
      ),
      minLetterCount: 2,
    );
    hyphenators['en-us'] = Hyphenator(
      resource: await Loader.load(
        File('$resDir/tex/hyph-en-us.tex'),
      ),
      minLetterCount: 2,
    );
  }
}
