import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Api/ApiPdf.dart';
import 'package:mwcdn/MwPdf/Service/Api/Authorization.dart';
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
    ApiPdf apiPdf = ApiPdf(
      fileStorage: fileStorage,
    );

    return Pipeline()
        // --------- auth/security middleware
        .addMiddleware(
          authorization.apiAccess(),
        )
        .addHandler(Router()
          ..post(
            '/pdf',
            apiPdf.pdf,
          )
          ..post(
            '/template',
            apiPdf.template,
          )
          ..post(
            '/validate',
            apiPdf.validate,
          )
          ..post(
            '/invoice',
            apiPdf.invoice,
          )
          ..get(
            '/schema',
            apiPdf.schema,
          )
          ..get(
            '/schemaf',
            apiPdf.schemaf,
          )
          ..get(
            '/schemax',
            apiPdf.schemax,
          ));
  }
}
