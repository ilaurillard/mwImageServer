import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Model/RootToken.dart';
import 'package:mwcdn/MwMs/Model/TokenInterface.dart';
import 'package:shelf/shelf.dart';

class Authorization {
  final String rootKey;

  Authorization({
    required this.rootKey,
  });

  // ---------------------

  // General api access
  Middleware apiAccess() {
    return (
      Handler handler,
    ) {
      return (
        Request request,
      ) async {
        String auth = request.headers['authorization'] ?? '';
        if (auth.isNotEmpty) {
          // -------------------
          TokenInterface? token = await tokenForAuth(auth);

          if (token != null) {
            return handler(request);
          }

          // ... TODO

          return Util.rForbidden();
        }
        return Util.rUnauthorized();
      };
    };
  }

  // ----

  Future<TokenInterface?> tokenForAuth(
    String auth,
  ) async {
    if (auth.isNotEmpty) {
      if (auth == rootKey) {
        return RootToken();
      } else {
        // TODO
      }
    }
    return null;
  }
}
