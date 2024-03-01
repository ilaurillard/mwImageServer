import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Datasource.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/CustomCalendar.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Entries.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Styles.dart';
import 'package:pdf/widgets.dart' as pw;

class Custom {
  static pw.Widget calendar(
    Dict json,
    State state,
  ) {
    Datasource source = state.source(
      json['source'] as String?,
    );

    return CustomCalendar(
      year: int.tryParse(json['year'].toString()) ?? 2024,
      month: int.tryParse(json['month'].toString()) ?? 1,
      entries: Entries.fromJson(source.data),
      styles: Styles(
          // highlightToday: false,
          // holidaysDE: false,
          ),
      mode: CustomCalendar.parseMode(
        json['mode'] as String? ?? '',
      ),
    ).build();
  }
}
