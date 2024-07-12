class Iso11649 {
  final Map<String, int> charTable = {
    'A': 10,
    'B': 11,
    'C': 12,
    'D': 13,
    'E': 14,
    'F': 15,
    'G': 16,
    'H': 17,
    'I': 18,
    'J': 19,
    'K': 20,
    'L': 21,
    'M': 22,
    'N': 23,
    'O': 24,
    'P': 25,
    'Q': 26,
    'R': 27,
    'S': 28,
    'T': 29,
    'U': 30,
    'V': 31,
    'W': 32,
    'X': 33,
    'Y': 34,
    'Z': 35
  };

  String normalizeRef(String ref) {
    return ref.replaceAll(RegExp(r'\s+'), '').toUpperCase();
  }

  String replaceChars(String string) {
    String result = string.toUpperCase();
    charTable.forEach((key, value) {
      result = result.replaceAll(key, value.toString());
    });
    return result;
  }

  String calculateRfChecksum(String ref) {
    String preResult = '${ref}RF00'; // add 'RF00' to the end of ref
    preResult = replaceChars(preResult); // Replace to numeric
    int checksum = (98 - _bcmod(preResult, 97)); // Calculate checksum
    return checksum.toString().padLeft(2, '0'); // pad to 2 digits if under 10
  }

  String generateRfReference(String input, {bool chunksplit = true}) {
    String normalizedRef = normalizeRef(input); // Remove whitespace, uppercase
    String checksum = calculateRfChecksum(normalizedRef); // Generate checksum
    String rfReference = 'RF$checksum$normalizedRef'; // Join to required format
    if (validateRfReference(rfReference)) {
      // Check if validates
      return chunksplit ? _chunkSplit(rfReference, 4, ' ') : rfReference;
    } else {
      return '';
    }
  }

  bool validateRfReference(String ref) {
    String pre = normalizeRef(ref); // Remove whitespace, uppercase

    if (!RegExp(r'^[A-Z0-9 ]*$').hasMatch(pre)) {
      // Only A-Z and numbers are allowed
      return false;
    }

    ref = pre.substring(4) +
        pre.substring(0, 4); // Move first 4 chars to the end of $ref
    String num = replaceChars(ref); // Replace to numeric
    // Valid if up to 25 characters long and remainder is 1
    return (pre.length < 26) && (_bcmod(num, 97) == 1);
  }

  int _bcmod(String number, int mod) {
    int take = 5;
    String modString = mod.toString();
    int modLen = modString.length;

    if (number.length > take) {
      number = number.substring(take);
    }

    int result = int.parse(number.substring(0, take)) % mod;

    for (int i = take; i < number.length; i += modLen) {
      int value =
          int.parse(result.toString() + number.substring(i, i + modLen));
      result = value % mod;
    }

    return result;
  }

  String _chunkSplit(String str, int chunkSize, String separator) {
    RegExp exp = RegExp('.{1,$chunkSize}');
    Iterable<Match> matches = exp.allMatches(str);
    return matches.map((match) => match.group(0)!).join(separator);
  }
}
