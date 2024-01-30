import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwXls/Api/ApiXls.dart';
import 'package:mwcdn/MwXls/Service/Api/Authorization.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Api {
  final FileStorage fileStorage;
  final String rootKey;

  Api({
    required this.fileStorage,
    required this.rootKey,
  });

  Handler create() {
    Authorization authorization = Authorization(
      rootKey: rootKey,
    );
    ApiXls apiXls = ApiXls(
      fileStorage: fileStorage,
    );

    return Pipeline()
        // --------- auth/security middleware
        .addMiddleware(
          authorization.apiAccess(),
        )
        .addHandler(Router()
          ..post(
            '/xls',
            apiXls.xls,
          )
          ..post(
            '/template',
            apiXls.template,
          )
          ..post(
            '/validate',
            apiXls.validate,
          )
          ..get(
            '/schema',
            apiXls.schema,
          )
    );
  }
}
