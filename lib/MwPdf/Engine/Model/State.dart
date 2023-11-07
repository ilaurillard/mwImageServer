import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Datasource.dart';

class State {
  static const material = 'material';

  static Map<String, pw.Font> fonts = {};
  static Map<String, String> materialCodes = {};

  final String baseDir;
  final String dataDir;

  String value = '';
  int pageNumber = 0;
  int pagesCount = 0;

  Map<String, Datasource> sources = {};

  // String exampleSvg = utf8.decode(
  //   // red circle
  //   base64.decode(
  //     'PHN2ZyBoZWlnaHQ9IjEwMCIgd2lkdGg9IjEwMCI+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMyIgZmlsbD0icmVkIiAvPgogIFNvcnJ5LCB5b3VyIGJyb3dzZXIgZG9lcyBub3Qgc3VwcG9ydCBpbmxpbmUgU1ZHLiAgCjwvc3ZnPiA=',
  //   ),
  // );
  // pw.MemoryImage exampleImage = pw.MemoryImage(
  //   // black pixel
  //   base64.decode('R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs='),
  // );

  late final FileStorage fileStorage;

  State({
    required this.baseDir,
    required this.dataDir,
  });

  Future<void> init() async {

    fileStorage = FileStorage(
      dataDir: dataDir,
    );

    if (fonts.isEmpty) {
      await loadBuiltinFonts();
      await loadMaterialFont();
    }

    await loadResources();
  }

  // Future<void> examples() async {
  //   print('load examples');
  //   exampleSvg = await File(
  //     '$baseDir/assets/example.svg',
  //   ).readAsString();
  //   exampleImage = pw.MemoryImage(
  //     await File('$baseDir/assets/example.jpg').readAsBytes(),
  //   );
  // }

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

  Future<void> loadResources() async {
    print('load resources (${sources.length})');
    for (String key in sources.keys) {
      await sources[key]!.load(
        fileStorage,
      );
    }
  }

  static State fromJson(
    Dict json, {
    required String baseDir,
    required String dataDir,
  }) {
    State state = State(
      baseDir: baseDir,
      dataDir: dataDir,
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
