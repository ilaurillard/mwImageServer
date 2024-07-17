class StringModifier {
  static String ctrlToWhitespace(
    String? string,
  ) {
    return string == null
        ? ''
        : string
            .replaceAll('\r', ' ')
            .replaceAll('\n', ' ')
            .replaceAll('\t', ' ');
  }

  static String collapseWhitespace(
    String? string,
  ) {
    return string == null ? '' : string.replaceAll(RegExp(r' +'), ' ');
  }

  static String noWhitespace(
    String? string,
  ) {
    return string == null ? '' : string.replaceAll(RegExp(r'\s+'), '');
  }

  static String chunkSplit(
      String str,
      int chunkSize,
      String separator,
      ) {
    List<String> chunks = [];
    for (var i = 0; i < str.length; i += chunkSize) {
      chunks.add(str.substring(
          i, i + chunkSize > str.length ? str.length : i + chunkSize));
    }
    return chunks.join(separator);
  }

  static String strrev(String string) {
    return string.split('').reversed.join('');
  }
}
