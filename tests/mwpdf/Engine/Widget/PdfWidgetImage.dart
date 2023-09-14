import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Model/Resource.dart';
import '../PdfEngine.dart';
import 'PdfWidgetUtil.dart';

class PdfWidgetImage {
  static pw.Image image(
    Dict json,
  ) {
    Resource resource = PdfEngine.res.get(json['resource'] as String?);
    // print(resource);

    // TODO image data
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());
    return pw.Image(
      PdfEngine.res.exampleImage,
      fit: PdfWidgetUtil.boxFit(
        json['fit'] as String?,
      ) ?? pw.BoxFit.contain,
      alignment: PdfWidgetUtil.alignment(
        json['alignment'] as String?,
      ) ?? pw.Alignment.center,
      dpi: double.tryParse(json['dpi'].toString()),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
    );
  }

  static pw.SvgImage svgImage(
    Dict json,
  ) {
    Resource resource = PdfEngine.res.get(json['resource'] as String?);
    // print(resource);

    // TODO svg data
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());
    return pw.SvgImage(

      svg: PdfEngine.res.exampleSvg,

      fit: PdfWidgetUtil.boxFit(
        json['fit'] as String?,
      ) ?? pw.BoxFit.contain,
      alignment: PdfWidgetUtil.alignment(
        json['alignment'] as String?,
      ) ?? pw.Alignment.center,
      clip: json['clip'] as bool? ?? true,
      colorFilter: PdfWidgetUtil.color(
        json['colorFilter'] as String?,
      ),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
    );
  }

  static pw.Icon icon(
    Dict json,
  ) {
    String icon = json['icon'].toString();
    int? code = int.tryParse(icon, radix: 16);
    code ??= int.parse(PdfEngine.res.materialCodes[icon] ?? 'EB8B', radix: 16);
    double? size = double.tryParse(json['size'].toString());
    return pw.Icon(
      pw.IconData(
        code,
      ),
      size: size != null ? size * PdfPageFormat.mm : null,
      color: PdfWidgetUtil.color(
        json['color'] as String?,
      ),
    );
  }
}
