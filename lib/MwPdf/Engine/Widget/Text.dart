import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Markdown/Markdown.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';

class Text {
  static pw.Widget richText(
    Dict json,
    State state,
  ) {

    String md = json['text'] as String? ?? '';

//     md = '''
// ### test
//
// asdfasdf *xxx*
// asdfasdf
//
// > xxx
// >
// > sdfgsdfg
// >> sdfgsdfg **xxx**
// >> sdfgsdfgsdf
//
// - item 1
// - item 2
//   - item 2.1
//   - item 2.2
//
// > #### The quarterly results look great!
// >
// > - Revenue was off the chart.
// > - Profits were higher than ever.
// >
// > *Everything* is going according to **plan**.
//
// 1. First item
// 2. Second item
// 3. Third item
//     1. Indented item
//     2. Indented item
// 4. Fourth item
//
// At the command prompt, type `nano`.
//
//     <?php
//         print('hello world');
//         exit;
//
// ''';

    return Markdown(md).toRichText();
  }

  static pw.Text text(
    Dict json,
    State state,
  ) {
    String text = Etc.replaceParameters(
      json['text'] as String? ?? '',
      state,
    );
    if (text.isEmpty) {
      text = state
          .source(
            json['source'] as String?,
          )
          .text;
    }
    return pw.Text(
      text,
      style: Etc.textStyle(
        (json['style'] as Dict?) ?? {},
        state,
      ),
      textAlign: Etc.textAlign(
        json['textAlign'] as String?,
      ),
      textDirection: Etc.textDirection(
        json['textDirection'] as String?,
      ),
      softWrap: json['softWrap'] as bool?,
      tightBounds: Types.boolFromDict(json, 'tightBounds'),
      textScaleFactor:
          double.tryParse(json['textScaleFactor'].toString()) ?? 1.0,
      maxLines: int.tryParse(json['maxLines'].toString()),
      overflow: Etc.textOverflow(json['overflow'] as String?),
    );
  }
}
