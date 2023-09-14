import 'package:mwcdn/Etc/Types.dart';

class Resource {
  final String url;

  // api/bucket/98/resource/$resourceId1
  final String file;

  final String binary;
  final List<List<dynamic>> values;

  Resource({
    this.binary = '',
    this.file = '',
    this.url = '',
    this.values = const [],
  });

  static Resource fromJson(
    Dict json,
  ) {
    List<dynamic> temp = json['values'] as List<dynamic>? ?? [];
    List<List<dynamic>> values =
        temp.map((dynamic row) => row as List<dynamic>).toList();

    // print(values);

    return Resource(
      binary: json['binary'] as String? ?? '',
      url: json['url'] as String? ?? '',
      file: json['file'] as String? ?? '',
      values: values,
    );
  }

  Future<void> load() async {
    print('load resource');
    if (binary.isNotEmpty) {
      return;
    }
    if (values.isNotEmpty) {
      return;
    }
    if (url.isNotEmpty) {
      // TODO cachekey, load from remote, cache, file


    }
    if (file.isNotEmpty) {
      // TODO a bucket resource

    }
  }
}
