import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfWidget {
  final pw.Context context;
  final Dict json;

  PdfWidget({
    required this.context,
    required this.json,
  });

  pw.Widget build() {
    return parseWidget(json);
  }

  pw.Widget parseWidget(
    Dict json,
  ) {
    MapEntry<String, dynamic> widget = json.entries.first;

    String key = widget.key;
    Dict data = widget.value as Dict;

    print('W: $key');

    switch (key) {
      case 'Container':
        return parseContainer(data);

      case 'SizedBox':
        return parseSizedBox(data);

      case 'Wrap':
        return parseWrap(data);

      case 'Row':
        return parseRow(data);
      case 'Column':
        return parseColumn(data);
      case 'Expanded':
        return parseExpanded(data);

      case 'Divider':
        return parseDivider(data);

      case 'Table':
        return parseTable(data);

      case 'Text':
        return parseText(data);

      case 'Paragraph':
        return parseParagraph(data);

      case 'Image':
        return parseImage(data);

      case 'SvgImage':
        return parseSvgImage(data);

      case 'Chart':
        return parseChart(data);

      case 'Placeholder':
        return parsePlaceholder(data);

      case 'Opacity':
        return parseOpacity(data);
    }

    print(' !!! widget $key not supported');

    return pw.SizedBox();
  }

  // -----------------

  pw.Container parseContainer(
    Dict json,
  ) {
    // TODO
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    return pw.Container(
      alignment: _parseAlignment(
        json['alignment'] as String?,
      ),
      padding: _parseEdgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: _parseEdgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      color: _parseColor(
        json['color'] as String?,
      ),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      child: parseWidget(json['child'] as Dict? ?? {}),
    );
  }

  pw.Opacity parseOpacity(Dict json) {
    return pw.Opacity(
      opacity: double.tryParse(json['opacity'].toString()) ?? 1.0,
      child: parseWidget(json['child'] as Dict? ?? {}),
    );
  }

  pw.SizedBox parseSizedBox(
    Dict json,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    return pw.SizedBox(
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      child: parseWidget(json['child'] as Dict? ?? {}),
    );
  }

  pw.Table parseTable(
    Dict json,
  ) {
    // TODO
    return pw.Table();
  }

  pw.Wrap parseWrap(
    Dict json,
  ) {
    // TODO
    return pw.Wrap();
  }

  pw.Row parseRow(
    Dict json,
  ) {
    // TODO
    return pw.Row(
      mainAxisAlignment: _parseMainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: _parseCrossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: _parseMainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: _parseVerticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => parseWidget(e as Dict))
          .toList(),
    );
  }

  pw.Column parseColumn(
    Dict json,
  ) {
    // TODO
    return pw.Column(
      mainAxisAlignment: _parseMainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: _parseCrossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: _parseMainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: _parseVerticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => parseWidget(e as Dict))
          .toList(),
    );
  }

  pw.Expanded parseExpanded(
    Dict json,
  ) {
    // TODO
    return pw.Expanded(
      child: parseWidget(json['child'] as Dict? ?? {}),
    );
  }

  pw.Divider parseDivider(
    Dict json,
  ) {
    double? height = double.tryParse(json['height'].toString());
    double? thickness = double.tryParse(json['thickness'].toString());
    double? indent = double.tryParse(json['indent'].toString());
    double? endIndent = double.tryParse(json['endIndent'].toString());
    return pw.Divider(
      height: height != null ? height * PdfPageFormat.mm : null,
      thickness: thickness != null ? thickness * PdfPageFormat.mm : null,
      indent: indent != null ? indent * PdfPageFormat.mm : null,
      endIndent: endIndent != null ? endIndent * PdfPageFormat.mm : null,
      color: _parseColor(
        json['color'] as String?,
      ),
      borderStyle: _parseBorderStyle(
        json['borderStyle'] as String?,
      ),
    );
  }

  // --------------------------

  pw.Text parseText(
    Dict json,
  ) {
    // TODO
    return pw.Text(
      json['text'] as String? ?? '¿',
    );
  }

  pw.Paragraph parseParagraph(
    Dict json,
  ) {
    // TODO
    return pw.Paragraph(
      text: json['text'] as String? ?? '¿',
      textAlign: _parseTextAlign(
        json['textAlign'] as String?,
      ),
      padding: _parseEdgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: _parseEdgeInsets(
            json['margin'] as List<dynamic>?,
          ) ??
          const pw.EdgeInsets.only(bottom: 5.0 * PdfPageFormat.mm),
    );
  }

  // --------------------------

  pw.Image parseImage(
    Dict json,
  ) {
    print(json);
    // TODO
    return pw.Image(
      pw.MemoryImage(Uint8List(0)),
    );
  }

  pw.SvgImage parseSvgImage(
    Dict json,
  ) {
    print(json);
    // TODO
    return pw.SvgImage(
      svg: '',
    );
  }

  // --------------------------

  pw.Chart parseChart(
    Dict json,
  ) {
    // TODO
    return pw.Chart(
      grid: parseChartGrid(json['grid'] as Dict? ?? {}),
      datasets: [],
    );
  }

  pw.ChartGrid parseChartGrid(
    Dict json,
  ) {
    MapEntry<String, dynamic> widget = json.entries.first;

    String key = widget.key;
    Dict data = widget.value as Dict;

    print('W: $key');

    switch (key) {
      case 'CartesianGrid':
        return parseCartesianGrid(data);
    }

    throw Exception('Parsing chart grid failed');
  }

  pw.CartesianGrid parseCartesianGrid(
    Dict json,
  ) {
    return pw.CartesianGrid(
      xAxis: parseGridAxis(json['xAxis'] as Dict? ?? {}),
      yAxis: parseGridAxis(json['yAxis'] as Dict? ?? {}),
    );
  }

  pw.FixedAxis parseGridAxis(
    Dict json,
  ) {
    // TODO
    return pw.FixedAxis(
      [0, 1, 2, 3, 4, 5, 6],
    );
  }

  // ----------------

  pw.Placeholder parsePlaceholder(
    Dict json,
  ) {
    // TODO
    return pw.Placeholder();
  }



  // ---------------------------------

  pw.MainAxisAlignment _parseMainAxisAlignment(
    String? json,
  ) {
    switch (json) {
      case 'center':
        return pw.MainAxisAlignment.center;
      case 'end':
        return pw.MainAxisAlignment.end;
      case 'spaceBetween':
        return pw.MainAxisAlignment.spaceBetween;
      case 'spaceAround':
        return pw.MainAxisAlignment.spaceAround;
      case 'spaceEvenly':
        return pw.MainAxisAlignment.spaceEvenly;
    }
    return pw.MainAxisAlignment.start;
  }

  pw.CrossAxisAlignment _parseCrossAxisAlignment(
    String? json,
  ) {
    switch (json) {
      case 'start':
        return pw.CrossAxisAlignment.start;
      case 'end':
        return pw.CrossAxisAlignment.end;
      case 'stretch':
        return pw.CrossAxisAlignment.stretch;
    }
    return pw.CrossAxisAlignment.center;
  }

  pw.MainAxisSize _parseMainAxisSize(
    String? json,
  ) {
    switch (json) {
      case 'min':
        return pw.MainAxisSize.min;
    }
    return pw.MainAxisSize.max;
  }

  pw.VerticalDirection _parseVerticalDirection(
    String? json,
  ) {
    switch (json) {
      case 'up':
        return pw.VerticalDirection.up;
    }
    return pw.VerticalDirection.down;
  }

  PdfColor? _parseColor(
    String? json,
  ) {
    // TODO ???
    if (json != null && json != '') {
      // return PdfColor(0.5, 0.5, 0.5, 0.5);
      return PdfColor.fromInt(int.parse(json, radix: 16));
    }
    return null;
  }

  pw.EdgeInsets? _parseEdgeInsets(
    List<dynamic>? json,
  ) {
    if (json != null && json.isNotEmpty) {
      double l = double.tryParse(json.first.toString()) ?? 0;
      double t = l;
      double r = l;
      double b = l;
      if (json.length > 1) {
        t = double.tryParse(json[1].toString()) ?? 0;
        b = t;
      }
      if (json.length > 3) {
        r = double.tryParse(json[2].toString()) ?? 0;
        b = double.tryParse(json[3].toString()) ?? 0;
      }

      return pw.EdgeInsets.fromLTRB(
        l * PdfPageFormat.mm,
        t * PdfPageFormat.mm,
        r * PdfPageFormat.mm,
        b * PdfPageFormat.mm,
      );
    }
    return null;
  }

  pw.Alignment? _parseAlignment(
    String? json,
  ) {
    // TODO allow "double,double"
    if (json != null && json != '') {
      switch (json) {
        case 'center':
          return pw.Alignment.center;
        case 'topLeft':
          return pw.Alignment.topLeft;
        case 'topCenter':
          return pw.Alignment.topCenter;
        case 'topRight':
          return pw.Alignment.topRight;
        case 'centerRight':
          return pw.Alignment.centerRight;
        case 'bottomLeft':
          return pw.Alignment.bottomLeft;
        case 'bottomLeft':
          return pw.Alignment.bottomCenter;
        case 'bottomRight':
          return pw.Alignment.bottomRight;
        case 'centerLeft':
          return pw.Alignment.centerLeft;
      }
    }
    return null;
  }

  pw.TextAlign _parseTextAlign(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'center':
          return pw.TextAlign.center;
        case 'left':
          return pw.TextAlign.left;
        case 'right':
          return pw.TextAlign.right;
      }
    }
    return pw.TextAlign.justify;
  }

  pw.BorderStyle _parseBorderStyle(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'none':
          return pw.BorderStyle.none;
        case 'dashed':
          return pw.BorderStyle.dashed;
        case 'dotted':
          return pw.BorderStyle.dotted;
      }
    }
    return pw.BorderStyle.solid;
  }

}
