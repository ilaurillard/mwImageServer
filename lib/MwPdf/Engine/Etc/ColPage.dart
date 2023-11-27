import 'dart:math' as math;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

class ColPage extends MultiPage {
  final BuildListCallback _buildList;

  final List<_ColPageInstance> _pages = [];

  final int columns;
  final double gapWidth;

  late final EdgeInsets _margin;

  ColPage({
    PageTheme? pageTheme,
    PdfPageFormat? pageFormat,
    required BuildListCallback build,
    BuildCallback? header,
    BuildCallback? footer,
    ThemeData? theme,
    int maxPages = 20,
    PageOrientation? orientation,
    EdgeInsets? margin,
    TextDirection? textDirection,
    this.columns = 2,
    this.gapWidth = 20,
  })  : _buildList = build,
        super(
          pageTheme: pageTheme,
          pageFormat: pageFormat,
          build: build,
          margin: margin,
          theme: theme,
          orientation: orientation,
          textDirection: textDirection,
          mainAxisAlignment: MainAxisAlignment.start,
          maxPages: maxPages,
          header: header,
          footer: footer,
        ) {
    _margin = this.margin!.resolve(textDirection);
  }

  @override
  void generate(
    Document document, {
    bool insert = true,
    int? index,
  }) {
    double pageHeight = _calcPageHeight();
    double pageHeightMargin = _calcPageHeightMargin();

    double columnWidth = _calcColumnWidth();
    BoxConstraints maxColumnWidth = BoxConstraints(
      maxWidth: columnWidth,
    );

    BoxConstraints fullConstraints = _calcFullConstraints();
    Context baseContext = _baseContext(document);
    List<Widget> children = _buildList(baseContext);

    double headerHeight = 0;
    double footerHeight = 0;

    double offsetStart = 0.0;
    double offsetEnd = 0.0;

    WidgetContext? widgetContext;
    Context? pageContext;

    int column = 0;
    int idx = 0;

    while (idx < children.length) {
      Widget child = children[idx];

      bool startNewPage = pageContext == null || child is NewPage;
      if (startNewPage) {
        PdfPage pdfPage = PdfPage(
          document.document,
          pageFormat: pageFormat,
          index: index == null ? null : (index++),
        );

        PdfGraphics canvas = pdfPage.getGraphics();
        canvas.reset();
        pageContext = baseContext.copyWith(
          page: pdfPage,
          canvas: canvas,
        );

        offsetStart = pageHeight -
            (mustRotate ? pageHeightMargin - _margin.bottom : _margin.top);
        offsetEnd =
            mustRotate ? pageHeightMargin - _margin.left : _margin.bottom;

        _pages.add(
          _ColPageInstance(
            context: pageContext,
            constraints: maxColumnWidth,
            fullConstraints: fullConstraints,
            offsetStart: offsetStart,
          ),
        );

        if (header != null) {
          Widget headerWidget = header!(pageContext);
          headerWidget.layout(
            pageContext,
            fullConstraints,
            parentUsesSize: false,
          );
          headerHeight = headerWidget.box!.height;
          offsetStart -= headerHeight;
        }

        if (footer != null) {
          Widget footerWidget = footer!(pageContext);
          footerWidget.layout(
            pageContext,
            fullConstraints,
          );
          footerHeight = footerWidget.box!.height;
          offsetEnd += footerHeight;
        }
      }

      WidgetContext? savedContext;
      if (child is SpanningWidget && child.canSpan) {
        if (widgetContext != null) {
          child.restoreContext(widgetContext);
          widgetContext = null;
        }
        savedContext = child.cloneContext();
      }

      child.layout(
        pageContext,
        maxColumnWidth,
      );

      bool childFits = offsetStart - child.box!.height >= offsetEnd;
      bool canSpan = child is SpanningWidget && child.canSpan;

      if (childFits) {
        _pages.last.widgets.add(
          _ColPageWidget(
            column: column,
            child: child,
            constraints: maxColumnWidth,
            widgetContext: canSpan ? child.cloneContext() : null,
          ),
        );
        offsetStart -= child.box!.height;
        idx++;
      } else {
        if (!canSpan) {
          if (child.box!.height <= pageHeight - pageHeightMargin) {
            pageContext = null;
            continue;
          }
          throw Exception('Widget won\'t fit',);
        }

        SpanningWidget partialChild = child;

        if (savedContext != null) {
          partialChild.applyContext(savedContext);
        }

        BoxConstraints localConstraints = maxColumnWidth.copyWith(
          maxHeight: offsetStart - offsetEnd,
        );

        partialChild.layout(
          pageContext,
          localConstraints,
        );
        widgetContext = partialChild.saveContext();

        _pages.last.widgets.add(
          _ColPageWidget(
            column: column,
            child: partialChild,
            constraints: localConstraints,
            widgetContext: widgetContext.clone(),
          ),
        );

        if (!partialChild.hasMoreWidgets) {
          idx++;
        }

        if (column == columns - 1) {
          pageContext = null;
          column = 0;
        } else {
          column++;
          offsetStart = pageHeight -
              (mustRotate ? pageHeightMargin - _margin.bottom : _margin.top) -
              headerHeight;
          offsetEnd =
              (mustRotate ? pageHeightMargin - _margin.left : _margin.bottom) +
                  footerHeight;
        }
      }
    }
  }

  @override
  void postProcess(
    Document document,
  ) {
    double pageHeight = _calcPageHeight();
    double pageHeightMargin = _calcPageHeightMargin();
    double columnWidth = _calcColumnWidth();
    BoxConstraints fullConstraints = _calcFullConstraints();

    for (_ColPageInstance page in _pages) {
      double offsetStart = pageHeight -
          (mustRotate ? pageHeightMargin - _margin.bottom : _margin.top);

      if (pageTheme.buildBackground != null) {
        Widget child = pageTheme.buildBackground!(page.context);
        child.layout(
          page.context,
          page.fullConstraints,
        );
        _paintChild(
          page.context,
          child,
          _margin.left,
          _margin.bottom,
          pageFormat.height,
        );
      }

      if (header != null) {
        Widget headerWidget = header!(page.context);
        headerWidget.layout(
          page.context,
          fullConstraints,
        );
        offsetStart -= headerWidget.box!.height;
        _paintChild(
          page.context,
          headerWidget,
          _margin.left,
          page.offsetStart! - headerWidget.box!.height,
          pageFormat.height,
        );
      }

      if (footer != null) {
        Widget footerWidget = footer!(page.context);
        footerWidget.layout(
          page.context,
          fullConstraints,
        );
        _paintChild(
          page.context,
          footerWidget,
          _margin.left,
          _margin.bottom,
          pageFormat.height,
        );
      }

      for (int col = 0; col < columns; col++) {
        for (_ColPageWidget widget in page.widgets) {
          if (widget.column == col) {
            Widget child = widget.child;

            if (child is SpanningWidget && child.canSpan) {
              child.applyContext(widget.widgetContext!);
            }

            child.layout(
              page.context,
              widget.constraints,
            );
          }
        }

        double ypos = offsetStart;
        for (_ColPageWidget widget in page.widgets) {
          if (widget.column == col) {
            ypos -= widget.child.box!.height;

            Widget child = widget.child;

            if (child is SpanningWidget && child.canSpan) {
              child.applyContext(widget.widgetContext!);
            }

            double xpos = _margin.left +
                (columnWidth * widget.column) +
                (gapWidth * widget.column);

            _paintChild(
              page.context,
              widget.child,
              xpos,
              ypos,
              pageFormat.height,
            );
          }
        }
      }

      if (pageTheme.buildForeground != null) {
        Widget child = pageTheme.buildForeground!(page.context);

        child.layout(
          page.context,
          page.fullConstraints,
          parentUsesSize: false,
        );
        _paintChild(
          page.context,
          child,
          _margin.left,
          _margin.bottom,
          pageFormat.height,
        );
      }
    }
  }

  void _paintChild(
    Context context,
    Widget child,
    double x,
    double y,
    double pageHeight,
  ) {
    if (mustRotate) {
      context.canvas
        ..saveContext()
        ..setTransform(
          Matrix4.identity()
            ..rotateZ(-math.pi / 2)
            ..translate(
              x - pageHeight + _margin.top - _margin.left,
              y + _margin.left - _margin.bottom,
            ),
        );

      child.paint(context);
      context.canvas.restoreContext();
    } else {
      child.box = PdfRect(
        x,
        y,
        child.box!.width,
        child.box!.height,
      );
      child.paint(context);
    }
  }

  double _calcPageHeight() {
    return mustRotate ? pageFormat.width : pageFormat.height;
  }

  double _calcPageHeightMargin() {
    return mustRotate ? _margin.horizontal : _margin.vertical;
  }

  BoxConstraints _calcFullConstraints() {
    return mustRotate
        ? BoxConstraints(
            maxWidth: pageFormat.height - _margin.vertical,
            maxHeight: pageFormat.width - _margin.horizontal)
        : BoxConstraints(
            maxWidth: pageFormat.width - _margin.horizontal,
            maxHeight: pageFormat.height - _margin.vertical);
  }

  double _calcColumnWidth() {
    double gapWidths = (columns - 1) * gapWidth;
    double availableWidth = mustRotate
        ? (pageFormat.height - _margin.vertical - gapWidths)
        : (pageFormat.width - _margin.horizontal - gapWidths);
    return availableWidth / columns;
  }

  Context _baseContext(
    Document document,
  ) {
    ThemeData calculatedTheme = theme ?? document.theme ?? ThemeData.base();
    return Context(
      document: document.document,
    ).inheritFromAll(
      [
        calculatedTheme,
        if (pageTheme.textDirection != null)
          InheritedDirectionality(
            pageTheme.textDirection,
          ),
      ],
    );
  }
}

class _ColPageWidget {
  final int column;
  final Widget child;
  final BoxConstraints constraints;
  final WidgetContext? widgetContext;

  const _ColPageWidget({
    required this.column,
    required this.child,
    required this.constraints,
    required this.widgetContext,
  });
}

class _ColPageInstance {
  final Context context;
  final BoxConstraints constraints;
  final BoxConstraints fullConstraints;
  final double? offsetStart;
  final List<_ColPageWidget> widgets = [];

  _ColPageInstance({
    required this.context,
    required this.constraints,
    required this.fullConstraints,
    required this.offsetStart,
  });
}
