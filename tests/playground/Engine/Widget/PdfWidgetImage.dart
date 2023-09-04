import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfWidgetImage {
  static pw.Image image(
    Dict json,
  ) {
    print(json);
    // TODO
    return pw.Image(
      pw.MemoryImage(Uint8List(0)),
    );
  }

  static pw.SvgImage svgImage(
    Dict json,
  ) {
    print(json);
    // TODO
    return pw.SvgImage(
      svg: '',
    );
  }
}
