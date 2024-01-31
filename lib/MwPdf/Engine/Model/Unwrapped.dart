import 'package:pdf/widgets.dart' as pw;

class Unwrapped extends pw.Wrap {
  Unwrapped({
    List<pw.Widget> children = const <pw.Widget>[],
  }) : super(
    direction: pw.Axis.horizontal,
    children: children,
  );
}
