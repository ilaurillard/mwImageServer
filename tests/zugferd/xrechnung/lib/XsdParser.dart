import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'Schema.dart';

class XsdParser {
  static const String schemaNs = 'http://www.w3.org/2001/XMLSchema';
  static const String schemaType = '__schema__';

  final String url;
  final String identifier;

  static Map<String, Uri> ns2uri = {};
  static Map<String, Schema> id2schema = {};
  static Map<String, String> ns2id = {};

  XsdParser(
    this.url,
    this.identifier,
  );

  Future<void> parse() async {
    ns2uri = {};
    id2schema = {};
    ns2id = {};
    await _loadDocuments(
      xsdUri: Uri.parse(url),
      identifier: identifier,
      namespace: '',
      depth: 0,
    );
  }

  Future<void> _loadDocuments({
    required Uri xsdUri,
    required String identifier,
    required String namespace,
    required int depth,
  }) async {
    // print('------');
    // print('[$depth] Loading schema for $xsdUri ($identifier)');
    XmlDocument document = await _loadDoc(xsdUri);

    namespace = _announce(
      document,
      xsdUri,
      identifier,
      namespace,
    );

    // recursion ----------
    await _imports(
      document,
      xsdUri,
      depth,
    );

    Schema schema = id2schema[identifier]!;
    schema.parse();
  }

  Future<XmlDocument> _loadDoc(Uri xsdUrl) async {

    String xsdContent;

    String fname = '/tmp/temp_${xsdUrl.path.split('/').last}';
    File f = File(fname);
    if (f.existsSync()) {
      print('from cache $fname');
      xsdContent = f.readAsStringSync();
    }
    else {
      print('http.get $xsdUrl');
      http.Response response = await http.get(xsdUrl);
      xsdContent = response.body;
      f.writeAsStringSync(xsdContent);
    }

    print('Size: ${xsdContent.length}');
    return XmlDocument.parse(xsdContent);
  }

  String _announce(
    XmlDocument document,
    Uri xsdUri,
    String identifier,
    String namespace,
  ) {
    String xmlns = '';
    String targetNamespace = '';
    for (XmlAttribute a in document.rootElement.attributes) {
      if (a.name.qualified == 'xmlns') {
        xmlns = a.value;
      } else if (a.name.qualified == 'targetNamespace') {
        targetNamespace = a.value;
      } else if (a.name.qualified.startsWith('xmlns:')) {
        String i =
            a.name.qualified.substring(a.name.qualified.indexOf(':') + 1);
        if (i != 'xsd') {
          ns2id[a.value] = i;
        }
      }
    }

    if (namespace.isEmpty) {
      namespace = xmlns;
      if (namespace.isEmpty) {
        namespace = targetNamespace;
      }
    }

    if (namespace.isNotEmpty) {
      ns2id[namespace] = identifier;
      ns2uri[namespace] = xsdUri;
      id2schema[identifier] = Schema(
        identifier: identifier,
        uri: xsdUri,
        namespace: namespace,
        document: document,
      );
    } else {
      throw Exception('No namespace??');
    }

    return namespace;
  }

  Future<void> _imports(
    XmlDocument document,
    Uri xsdUri,
    int depth,
  ) async {
    Iterable<XmlElement> imports = document.findAllElements(
      'import',
      namespace: schemaNs,
    );
    for (XmlElement i in imports) {
      String ns = i.getAttribute('namespace') ?? '';
      String location = i.getAttribute('schemaLocation') ?? '';
      if (!location.startsWith('http')) {
        Uri absoluteUrl = xsdUri.resolve(location);
        location = absoluteUrl.toString();
      }
      if (ns2uri[ns] == null) {
        String i = ns2id[ns] ?? '';

        // print(' --- ' + ns + ' ' + Uri.parse(location).toString());

        await _loadDocuments(
          xsdUri: Uri.parse(location),
          identifier: i,
          namespace: ns,
          depth: depth + 1,
        );
      }
    }
  }

  static Schema schemaForIdentifier(
    String identifier,
  ) {
    if (id2schema[identifier] == null) {
      throw Exception('No schema for $identifier');
    }
    return id2schema[identifier]!;
  }
}
