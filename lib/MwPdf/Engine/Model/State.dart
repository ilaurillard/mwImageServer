import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:mwcdn/MwPdf/Service/Hyphenation/hyphenator.dart';
import 'package:mwcdn/MwPdf/Service/Hyphenation/loader.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Datasource.dart';

class State {
  static const material = 'material';

  // be sure to also include fonts in schema
  Map<String, String> builtinFonts = {
    'openSansRegular': 'OpenSans/OpenSans-Regular.ttf',
    'openSansBold': 'OpenSans/OpenSans-Bold.ttf',
    'openSansItalic': 'OpenSans/OpenSans-Italic.ttf',
    'openSansBoldItalic': 'OpenSans/OpenSans-BoldItalic.ttf',
    'ptSerifBoldItalic': 'Pt/PTSerif-BoldItalic.ttf',
    'ptSerifBold': 'Pt/PTSerif-Bold.ttf',
    'ptSerifRegular': 'Pt/PTSerif-Regular.ttf',
    'ptSerifItalic': 'Pt/PTSerif-Italic.ttf',
    'universRegular': 'Univers/UniversCom-55Roman.ttf',
    'universBold': 'Univers/UniversCom-65Bold.ttf',
  };

  static Map<String, pw.Font> fonts = {};
  static Map<String, String> materialCodes = {};

  static Map<String, Hyphenator> hyphenators = {};

  final Storage storage; // from CDN project

  final String resDir;

  Map<String, Datasource> sources = {};

  List<num> sums = [];
  List<num> sumsAll = [];
  List<String> sumsFormatted = [];
  List<String> sumsAllFormatted = [];
  String sum = '';
  String sumAll = '';
  String value = '';
  Dict variables = {};
  int pageNumber = 0;
  int pagesCount = 0;

  // ------------------------------

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
    Console.notice('load builtin fonts');

    for (String name in builtinFonts.keys) {
      Console.notice(' font: $name, file: ${builtinFonts[name]}');
      fonts[name] = pw.Font.ttf(
        ByteData.view(
          (await File('$resDir/fonts/${builtinFonts[name]}').readAsBytes())
              .buffer,
        ),
      );
    }
  }

  Future<void> loadMaterialFont() async {
    Console.notice('load material font');
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
    if (sources.keys.isNotEmpty) {
      Console.notice('load sources (${sources.length})');
      for (String key in sources.keys) {
        await sources[key]!.load(
          storage,
        );
      }
    }
  }

  static State fromJson({
    required Dict sources,
    required Dict variables,
    required String resDir,
    required Storage storage,
  }) {
    State state = State(
      resDir: resDir,
      storage: storage,
    );

    state.addVariables(variables);

    state.sources = sources.map(
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

  void addVariables(
    Dict variables,
  ) {
    for (MapEntry<String, dynamic> entry in variables.entries) {
      if (entry.value is String) {
        this.variables[entry.key] = replaceParameters(
          entry.value as String,
        );
      } else {
        this.variables[entry.key] = entry.value;
      }
    }
  }

  pw.Font materialFont() {
    return fonts[material]!;
  }

  Datasource source(
    String? key,
  ) {
    if (key != null && key.isNotEmpty && sources[key] == null) {
      Console.notice('No resource available for "$key"');
    }
    return sources[key ?? ''] ?? Datasource(key ?? '');
  }

  pw.Hyphenation hyphenator({
    String language = 'de',
  }) {
    if (hyphenators[language] == null) {
      Console.notice('No hyphenator for language "$language"!');
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
          } else {
            list = hyphenators[language]!.hyphenateWordToList(word);
          }

          return list;
        }
      }
      return [word];
    };
  }

  Future<void> loadHyphenation() async {
    Console.notice('load hyphenation files');

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

  //-----------

  void sumsReset() {
    sums = [];
    sumsAll = [];
  }

  void summarizeValues(
    Datasource source,
  ) {
    if (source.values.isNotEmpty) {
      sums = [];
      for (List<dynamic> row in source.values) {
        if (row.length > sums.length) {
          List<num> pad = List.filled(row.length - sums.length, 0.0);
          sums.addAll(pad);
        }
        if (row.length > sumsAll.length) {
          List<num> pad = List.filled(row.length - sumsAll.length, 0.0);
          sumsAll.addAll(pad);
        }
        int nr = 0;
        for (dynamic v in row) {
          // print(v);
          num n = num.tryParse(v.toString()) ?? 0;
          sums[nr] += n;
          sumsAll[nr] += n;
          nr++;
        }
      }
      sumsFormatted = Datasource.applyFormats(source.formats, sums);
      sumsAllFormatted = Datasource.applyFormats(source.formats, sumsAll);
    }
  }

  void prepareCell(
    int nr,
    String value,
  ) {
    this.value = value;
    sum = sumsFormatted.length > nr ? sumsFormatted[nr].toString() : '';
    sumAll =
        sumsAllFormatted.length > nr ? sumsAllFormatted[nr].toString() : '';
  }

  String replaceParameters(
    String text,
  ) {
    if (!text.contains('%')) {
      return text;
    }
    for (String key in variables.keys) {
      dynamic v = variables[key] ?? '';
      if (v == false) {
        v = '';
      }
      text = text.replaceAll(
        '%$key%',
        v.toString(),
      );
    }
    return text
        .replaceAll('%value%', value)
        .replaceAll('%sum%', sum)
        .replaceAll('%sumAll%', sumAll)
        .replaceAll('%pageNumber%', pageNumber.toString())
        .replaceAll('%pagesCount%', pagesCount.toString());
  }
}
