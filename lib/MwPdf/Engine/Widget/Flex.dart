import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';
import 'Widget.dart';

class Flex {
  static pw.Row row(
    Dict json,
    Resources resources,
  ) {
    return pw.Row(
      mainAxisAlignment: Etc.mainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: Etc.crossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: Etc.mainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: Etc.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: Widget.children(
        json,
        resources,
      ),
    );
  }

  static pw.Column column(
    Dict json,
    Resources resources,
  ) {
    return pw.Column(
      mainAxisAlignment: Etc.mainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: Etc.crossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: Etc.mainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: Etc.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: Widget.children(
        json,
        resources,
      ),
    );
  }

  // (obsolete) parent of row/col ..
  static pw.Flex flex(
    Dict json,
    Resources resources,
  ) {
    return pw.Flex(
      direction: Etc.axis(
            json['direction'] as String?,
          ) ??
          pw.Axis.horizontal,
      mainAxisAlignment: Etc.mainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: Etc.crossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: Etc.mainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: Etc.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: Widget.children(
        json,
        resources,
      ),
    );
  }

  static pw.Expanded expanded(
    Dict json,
    Resources resources,
  ) {
    return pw.Expanded(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: Etc.flexFit(
        json['fit'] as String?,
      ),
      child: Widget.child(
        json,
        resources,
      ),
    );
  }

  static pw.ListView listView(
    Dict json,
    Resources resources,
  ) {
    double? spacing = double.tryParse(json['spacing'].toString());
    return pw.ListView(
      direction: Etc.axis(json['direction'] as String?) ?? pw.Axis.vertical,
      children: Widget.children(
        json,
        resources,
      ),
      padding: Etc.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      spacing: spacing != null ? spacing * PdfPageFormat.mm : 0,
      reverse: json['reverse'] as bool? ?? false,
    );
  }

  static pw.Spacer spacer(
    Dict json,
  ) {
    return pw.Spacer(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
    );
  }

  static pw.Flexible flexible(
    Dict json,
    Resources resources,
  ) {
    return pw.Flexible(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: Etc.flexFit(
        json['fit'] as String? ?? 'loose',
      ),
      child: Widget.child(
        json,
        resources,
      ),
    );
  }
}
