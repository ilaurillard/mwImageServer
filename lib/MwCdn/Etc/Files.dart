import 'package:mwcdn/MwCdn/Config.dart';
import 'package:mwcdn/MwMs/Etc/ResponseException.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:path/path.dart';


class Files {
  // ----------------

  static String filenameFromRequest(
    Dict data,
  ) {
    String filename = data['filename'] as String? ?? '';
    if (!Files.validFilename(filename)) {
      throw ResponseException(
        Util.rBadRequest(message: 'Invalid filename'),
      );
    }
    return filename;
  }


  // --------------

  static bool validFilename(
    String filename,
  ) {
    if (!Config.acceptedSuffixes.contains(
      suffix(
        filename,
      ),
    )) {
      return false;
    }

    String base = basenameWithoutExtension(filename);
    if (RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(base)) {
      return true;
    }

    return false;
  }

  // ----------------

  static bool validMimetype(
    String filename,
    String mimeType,
  ) {
    return (Util.mimeToSuffix[mimeType] ?? []).contains(
      suffix(
        filename,
      ),
    );
  }

  // -----------

  static String suffix(
    String filename,
  ) {
    return extension(filename);
  }
}
