import 'dart:io';

// see https://tug.org/tex-hyphen/
// see https://github.com/hyphenation/tex-hyphen/tree/master/hyph-utf8/tex/generic/hyph-utf8/patterns/tex
class Loader {
  Loader(
    this.patterns,
    this.exceptions,
  );

  final List<String> patterns;
  final List<String> exceptions;

  static Future<Loader> load(
    File texFile,
  ) async {
    String data = await texFile.readAsString();
    List<String> lines = data
        .split('\n')
        .where(
          (e) => e.isNotEmpty && !e.startsWith('%'),
        )
        .map(
          (e) => e.trim(),
        )
        .toList();

    List<String> pat = [];
    List<String> exc = [];

    bool isNextPattern = false;
    bool isNextException = false;

    for (String line in lines) {
      if (line.startsWith('}')) {
        isNextPattern = false;
        isNextException = false;
      } else if (!isNextPattern && line.startsWith('\\patterns')) {
        isNextPattern = true;
      } else if (!isNextException && line.startsWith('\\hyphenation')) {
        isNextException = true;
      } else if (isNextPattern && !isNextException) {
        pat.add(line);
      } else if (isNextException) {
        exc.add(line);
      }
    }
    return Loader(
      pat,
      exc,
    );
  }
}
