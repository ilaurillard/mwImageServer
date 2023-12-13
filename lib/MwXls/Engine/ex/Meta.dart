import 'package:mwcdn/MwMs/Etc/Types.dart';

class Meta {
  final String company;
  final String title;
  final String subject;
  final String author;
  final String description;
  final List<String> keywords;
  final String revision;
  final String fileName;

  Meta({
    this.company = '',
    this.title = '',
    this.subject = '',
    this.author = '',
    this.description = '',
    this.keywords = const [],
    this.revision = '0',
    this.fileName = 'map.xlsx',
  });

  static Meta fromJson(
    Dict json,
  ) {
    return Meta(
      company: json['company'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      author: json['author'] as String? ?? '',
      description: json['description'] as String? ?? '',
      revision: json['revision'] as String? ?? '0',
      fileName: json['fileName'] as String? ?? 'map.xlsx',
      keywords: (json['keywords'] as List<dynamic>? ?? []).cast(),
    );
  }
}
