import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class CodeType {
  final String value;
  final String? listId;
  final String? listVersionId;

  CodeType({
    required this.value,
    this.listId,
    this.listVersionId,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        builder.text(value);
        if (listId != null && listId!.isNotEmpty) {
          builder.attribute(
            'listID',
            listId,
          );
        }
        if (listVersionId != null && listVersionId!.isNotEmpty) {
          builder.attribute(
            'listVersionID',
            listVersionId,
          );
        }
      },
    );
  }

  static CodeType? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return CodeType(
      listId: xml.getAttribute('listID'),
      listVersionId: xml.getAttribute('listVersionID'),
      value: xml.innerText,
    );
  }

  static CodeType? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return CodeType(
        value: json['value'] as String? ?? '0',
        listId: json['listId'] as String?,
        listVersionId: json['listVersionId'] as String?,
      );
    }
    return null;
  }
}
