import 'package:pdf/widgets.dart' as pw;

class Unwrapped extends pw.Wrap {
  Unwrapped({
    List<pw.Widget> children = const <pw.Widget>[],
  }) : super(
    direction: pw.Axis.horizontal,
    children: children,
  );

// super(
// children: children,
// direction: Axis.vertical,
// mainAxisAlignment: mainAxisAlignment,
// mainAxisSize: mainAxisSize,
// crossAxisAlignment: crossAxisAlignment,
// verticalDirection: verticalDirection,
// );

// final pw.Widget delegate;
//
// Promoted(this.delegate,): super();
//
// @override
// void layout(
//   pw.Context context,
//   pw.BoxConstraints constraints, {
//   bool parentUsesSize = false,
// }) {
//   delegate.layout(
//     context,
//     constraints,
//     parentUsesSize: parentUsesSize,
//   );
// }
}
