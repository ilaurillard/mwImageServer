import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Model/Datasource.dart';
import 'Etc.dart';

class Image {
  static pw.Image image(
    Dict json,
    State state,
  ) {
    Datasource source = state.source(
      json['source'] as String?,
    );
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());
    return pw.Image(
      source.imageFromBinary(),
      fit: Etc.boxFit(
            json['fit'] as String?,
          ) ??
          pw.BoxFit.contain,
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      dpi: double.tryParse(json['dpi'].toString()),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
    );
  }

  static pw.SvgImage svgImage(
    Dict json,
    State state,
  ) {
    Datasource source = state.source(
      json['source'] as String?,
    );
    // print(resource);
    // String data = resources.exampleSvg;
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());
    return pw.SvgImage(
      svg: source.svgFromBinary(),
      // svg: resources.exampleSvg,
      fit: Etc.boxFit(
            json['fit'] as String?,
          ) ??
          pw.BoxFit.contain,
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      clip: json['clip'] as bool? ?? true,
      colorFilter: Etc.color(
        json['colorFilter'] as String?,
      ),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
    );
  }

  static pw.Icon icon(
    Dict json,
    State state,
  ) {
    String icon = json['icon'].toString();
    int? code = int.tryParse(icon, radix: 16);
    code ??= int.parse(State.materialCodes[icon] ?? 'EB8B', radix: 16);
    double? size = double.tryParse(json['size'].toString());
    return pw.Icon(
      pw.IconData(
        code,
      ),
      size: size != null ? size * PdfPageFormat.mm : null,
      color: Etc.color(
        json['color'] as String?,
      ),
    );
  }
}
