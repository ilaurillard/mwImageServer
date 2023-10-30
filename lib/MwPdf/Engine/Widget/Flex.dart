import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';
import 'Widget.dart';

class Flex {
  static pw.Row row(
    Dict json,
    State state,
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
        state,
      ),
    );
  }

  static pw.Column column(
    Dict json,
    State state,
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
        state,
      ),
    );
  }

  // (obsolete) parent of row/col ..
  static pw.Flex flex(
    Dict json,
    State state,
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
        state,
      ),
    );
  }

  static pw.Expanded expanded(
    Dict json,
    State state,
  ) {
    return pw.Expanded(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: Etc.flexFit(
        json['fit'] as String?,
      ),
      child: Widget.child(
        json,
        state,
      ),
    );
  }

  static pw.ListView listView(
    Dict json,
    State state,
  ) {
    double? spacing = double.tryParse(json['spacing'].toString());
    return pw.ListView(
      direction: Etc.axis(json['direction'] as String?) ?? pw.Axis.vertical,
      children: Widget.children(
        json,
        state,
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
    State state,
  ) {
    return pw.Flexible(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: Etc.flexFit(
        json['fit'] as String? ?? 'loose',
      ),
      child: Widget.child(
        json,
        state,
      ),
    );
  }
}
