import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfWidgetImage {
  static pw.Image parseImage(
    Dict json,
  ) {
    print(json);
    // TODO
    return pw.Image(
      pw.MemoryImage(Uint8List(0)),
    );
  }

  static pw.SvgImage parseSvgImage(
    Dict json,
  ) {
    print(json);
    // TODO
    return pw.SvgImage(
      svg: '',
    );
  }
}
