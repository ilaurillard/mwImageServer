import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Resource.dart';

class Resources {

  static const material = 'material';

  static Map<String, pw.Font> fonts = {};
  static Map<String, String> materialCodes = {};

  final String basedir;

  String value = '';
  int pageNumber = 0;
  int pagesCount = 0;

  Map<String, Resource> resources = {};

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



  Resources({
    required this.basedir,
  });

  Future<void> init() async {
    if (fonts.isEmpty) {
      await loadBuiltinFonts();
      await loadMaterialFont();
    }

    await loadResources();
  }

  // Future<void> examples() async {
  //   print('load examples');
  //   exampleSvg = await File(
  //     '$basedir/assets/example.svg',
  //   ).readAsString();
  //   exampleImage = pw.MemoryImage(
  //     await File('$basedir/assets/example.jpg').readAsBytes(),
  //   );
  // }

  Future<void> loadBuiltinFonts() async {
    print('load builtin fonts');
    fonts['openSansRegular'] = pw.Font.ttf(
      ByteData.view(
        (await File('$basedir/assets/Open Sans Regular.ttf').readAsBytes())
            .buffer,
      ),
    );
  }

  Future<void> loadMaterialFont() async {
    print('load material font');
    fonts[material] = pw.Font.ttf(
      ByteData.view(
        (await File('$basedir/assets/MaterialIcons-Regular.ttf').readAsBytes())
            .buffer,
      ),
    );

    List<String> lines =
        File('$basedir/assets/MaterialIcons-Regular.codepoints')
            .readAsLinesSync();
    for (String line in lines) {
      List<String> splitted = line.split(' ');
      materialCodes[splitted[0]] = splitted[1];
    }
  }

  Future<void> loadResources() async {
    print('load resources (${resources.length})');

    // url -> load from remote, put into cachefile
    // file -> load file

    for (String key in resources.keys) {
      await resources[key]!.load();
    }
  }

  static Resources fromJson(
    Dict json, {
    required String basedir,
  }) {
    Resources resources = Resources(
      basedir: basedir,
    );

    resources.resources = json.map(
      (key, value) {
        return MapEntry(
          key,
          Resource.fromJson(
            key,
            value as Dict,
            resources,
          ),
        );
      },
    );

    return resources;
  }

  pw.Font materialFont() {
    return fonts[material]!;
  }

  Resource resource(
    String? key,
  ) {
    if (key != null && key.isNotEmpty && resources[key] == null) {
      print('No resource available for "$key"');
    }
    return resources[key ?? ''] ?? Resource(key ?? '');
  }
}
