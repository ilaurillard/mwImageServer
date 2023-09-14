import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Model/Resource.dart';
import '../Engine.dart';
import 'Etc.dart';

class Image {
  static pw.Image image(
    Dict json,
  ) {
    Resource resource = Engine.res.get(json['resource'] as String?);
    // print(resource);

    // TODO image data
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());
    return pw.Image(
      Engine.res.exampleImage,
      fit: Etc.boxFit(
        json['fit'] as String?,
      ) ?? pw.BoxFit.contain,
      alignment: Etc.alignment(
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
    Resource resource = Engine.res.get(json['resource'] as String?);
    // print(resource);

    // TODO svg data
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());
    return pw.SvgImage(

      svg: Engine.res.exampleSvg,

      fit: Etc.boxFit(
        json['fit'] as String?,
      ) ?? pw.BoxFit.contain,
      alignment: Etc.alignment(
        json['alignment'] as String?,
      ) ?? pw.Alignment.center,
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
  ) {
    String icon = json['icon'].toString();
    int? code = int.tryParse(icon, radix: 16);
    code ??= int.parse(Engine.res.materialCodes[icon] ?? 'EB8B', radix: 16);
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
