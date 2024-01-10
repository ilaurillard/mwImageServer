MWCDN
-----

---- start local 

$ dart run bin/MwCdn.dart -d ~/PhpstormProjects/mwcdn/data
$ dart run bin/MwCdn.dart -d ~/PhpstormProjects/mwcdn/data -k myRootKey

$ curl http://0.0.0.0:8080/static/help.html



---- Build container via podman

$ podman build . -f Dockerfile.MwCdn -t mwcdn

$ podman run --name mwcdn -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8080:8080 mwcdn
$ podman run -e ROOT_KEY=myRootKey --name mwcdn -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8080:8080 mwcdn

$ curl http://0.0.0.0:8080

$ podman rm -f mwcdn

$ podman system prune


---- tests

http client tests in phpstorm

$ ab -k -n 10000 -c 10 http://0.0.0.0:8080/static/help.html

$ dart test tests/MwCdn/functional/* --reporter=expanded -j1


----



TODO
----

statistics
token stamping
token TTL
garbage collection
remove buckets
revoke tokens
consistency checks
pdf handling
rollout

------

TODO PDF:
- datasources (svg, image, tables, ...)
- images
- https://github.com/google/material-design-icons/blob/master/font/MaterialIcons-Regular.codepoints
- json template inheritance



Hetzner, ilja
-------------

http://128.140.2.103:8080/static/help.html

podman run -e ROOT_KEY=myRootKey --rm --name mwcdn -v ~/mwcdn/data:/data -it -p 8080:8080 mwcdn


IDEAS
-----

Token can be used only n times
        uses INTEGER DEFAULT 0 NOT NULL,

Token must be accessed every n seconds or dies
        ttl INTEGER DEFAULT 0 NOT NULL,

Token expires on fix date/uts
        expires INTEGER DEFAULT 0 NOT NULL


Pdf Forms:
https://stackoverflow.com/questions/9139787/how-to-fill-pdf-form-in-php
pdftk form.pdf generate_fdf output data.fdf
pdftk form.pdf fill_form data.fdf output form_with_data.pdf
(pdftk is based on java and somewhat sluggy and big)

Native PDF creation
https://pub.dev/packages/pdf/example

Native Excel creation
https://pub.dev/packages/excel

Docx
https://pub.dev/packages/docx_template


API
---

POST /api/bucket 
{"id": 77}

POST /api/token
{"buckets": [77]}

POST /api/token
{"root": true}

POST /api/bucket/77/method
{"name": "thumb2", "tool": "convert", ... }

DELETE /api/bucket/77/method/thumb2

GET /api/bucket/77

GET /api/bucket/77/stats

POST /api/bucket/77/token
{}

GET /api/bucket/77/token/1f077f5b99634d0c8839a45000692b20




