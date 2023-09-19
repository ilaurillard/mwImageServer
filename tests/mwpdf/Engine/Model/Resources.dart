import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../engine.dart';
import 'Resource.dart';

class Resources {
  static const material = 'material';

  Map<String, pw.Font> fonts = {};
  Map<String, String> materialCodes = {};

  String exampleSvg = '';
  pw.MemoryImage exampleImage =
      pw.MemoryImage(base64.decode('R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs='));

  final Map<String, Resource> map;

  Resources({
    required this.map,
  });

  Future<void> init() async {
    await examples();
    await loadMaterialFont();
    await loadBuiltinFonts();
    await loadResources();
  }

  Future<void> examples() async {
    print('load examples');
    exampleSvg =
        await File('${basedir}tests/mwpdf/files/example.svg').readAsString();
    exampleImage = pw.MemoryImage(
      await File('${basedir}tests/mwpdf/files/example.jpg').readAsBytes(),
    );
  }

  Future<void> loadBuiltinFonts() async {
    print('load builtin fonts');
    fonts['openSansRegular'] = pw.Font.ttf(
      ByteData.view(
        (await File('${basedir}tests/mwpdf/files/Open Sans Regular.ttf')
                .readAsBytes())
            .buffer,
      ),
    );
  }

  Future<void> loadMaterialFont() async {
    print('load material font');
    fonts[material] = pw.Font.ttf(
      ByteData.view(
        (await File('${basedir}tests/mwpdf/files/MaterialIcons-Regular.ttf')
                .readAsBytes())
            .buffer,
      ),
    );

    List<String> lines =
        File('${basedir}tests/mwpdf/files/MaterialIcons-Regular.codepoints')
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
    Dict json,
  ) {
    return Resources(
      map: json.map(
        (k, v) {
          return MapEntry(
            k,
            Resource.fromJson(
              v as Dict,
            ),
          );
        },
      ),
    );
  }

  pw.Font materialFont() {
    return fonts[material]!;
  }

  Resource get(
    String? source,
  ) {
    if (source != null && source.isNotEmpty && map[source] == null) {
      print('No resource available for "$source"');
    }
    return map[source ?? ''] ?? Resource();
  }
}
