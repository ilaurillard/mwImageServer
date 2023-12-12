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
}
