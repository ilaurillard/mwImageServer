import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwXls/Engine/Model/State.dart';

class RowStyle {
  final double height;
  final bool customFormat;
  final bool customHeight;
  final bool hidden;
  final bool collapsed;

  RowStyle({
    this.height = 12.1,
    this.customFormat = false,
    this.customHeight = false,
    this.hidden = false,
    this.collapsed = false,
  });

  static RowStyle fromJson(
    Dict json, {
    required State state,
  }) {
    String s = json['source'] as String? ?? '';
    if (s.isNotEmpty) {
      RowStyle? rs = state.rowStyles[s];
      if (rs != null) {
        return rs;
      }
      print('RowStyle $s not found!!');
    }
    return RowStyle(
      height: double.tryParse(json['height'].toString()) ?? 12.1,
      customFormat: json['customFormat'] as bool? ?? false,
      customHeight: json['customHeight'] as bool? ?? false,
      hidden: json['hidden'] as bool? ?? false,
      collapsed: json['collapsed'] as bool? ?? false,
    );
  }
}
