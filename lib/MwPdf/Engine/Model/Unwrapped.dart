import 'package:pdf/widgets.dart' as pw;

class Unwrapped extends pw.Wrap {
  Unwrapped({
    super.children,
  }) : super(
    direction: pw.Axis.horizontal,
  );
}
