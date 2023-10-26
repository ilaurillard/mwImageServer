import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Resource.dart';

class Resources {
  static const material = 'material';

  Map<String, pw.Font> fonts = {};
  Map<String, String> materialCodes = {};

  String exampleSvg = '';
  pw.MemoryImage exampleImage =
      pw.MemoryImage(base64.decode('R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs='));

  final Map<String, Resource> map;
  final String basedir;

  Resources({
    required this.map,
    required this.basedir,
  });

  Future<void> init() async {
    await loadMaterialFont();
    await loadBuiltinFonts();
    await loadResources();
  }

  Future<void> examples() async {
    print('load examples');
    exampleSvg =
        await File('$basedir/assets/example.svg').readAsString();
    exampleImage = pw.MemoryImage(
      await File('$basedir/assets/example.jpg').readAsBytes(),
    );
  }

  Future<void> loadBuiltinFonts() async {
    print('load builtin fonts');
    fonts['openSansRegular'] = pw.Font.ttf(
      ByteData.view(
        (await File('${basedir}/assets/Open Sans Regular.ttf').readAsBytes())
            .buffer,
      ),
    );
  }

  Future<void> loadMaterialFont() async {
    print('load material font');
    fonts[material] = pw.Font.ttf(
      ByteData.view(
        (await File('${basedir}/assets/MaterialIcons-Regular.ttf').readAsBytes())
            .buffer,
      ),
    );

    List<String> lines =
        File('${basedir}/assets/MaterialIcons-Regular.codepoints')
            .readAsLinesSync();
    for (String line in lines) {
      List<String> splitted = line.split(' ');
      materialCodes[splitted[0]] = splitted[1];
    }
  }

  Future<void> loadResources() async {
    print('load resources (${map.length})');

    // url -> load from remote, put into cachefile
    // file -> load file
    // binary -> nothing
    // values -> nothing

    for (String key in map.keys) {
      await map[key]!.load();
    }
  }

  static Resources fromJson(
    Dict json, {
    required String basedir,
  }) {
    return Resources(
      map: json.map(
        (key, value) {
          return MapEntry(
            key,
            Resource.fromJson(
              key,
              value as Dict,
            ),
          );
        },
      ),
      basedir: basedir,
    );
  }

  pw.Font materialFont() {
    return fonts[material]!;
  }

  Resource get(
    String? key,
  ) {
    if (key != null && key.isNotEmpty && map[key] == null) {
      print('No resource available for "$key"');
    }
    return map[key ?? ''] ?? Resource(key ?? '');
  }
}
