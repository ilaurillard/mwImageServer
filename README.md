---- start local 

$ dart run bin/main.dart -d ~/PhpstormProjects/mwcdn/data
$ dart run bin/main.dart -d ~/PhpstormProjects/mwcdn/data -k myRootKey

$ curl http://0.0.0.0:8080/static/help.html



---- Build via podman

$ podman build . -t mwcdn

$ podman run --name mwcdn -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8080:8080 mwcdn
$ podman run -e ROOT_KEY=myRootKey --name mwcdn -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8080:8080 mwcdn

$ curl http://0.0.0.0:8080

$ podman rm -f mwcdn

$ podman system prune



---- Build via docker compose

$ docker build . -t mwcdn

$ cat .env
$ docker-compose up

$ curl http://0.0.0.0:8080

$ curl http://0.0.0.0:8080/pub/77/aa/aa/aaaabbbbccccddddaaaabbbbccccdddd/meta.json

$ curl http://0.0.0.0:8080/priv/77/aa/aa/aaaabbbbccccddddaaaabbbbccccdddd/meta.json



---- tests

http client tests in phpstorm

$ ab -k -n 10000 -c 10 http://0.0.0.0:8080/static/help.html

$ dart test tests/functional/* --reporter=expanded -j1


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

PDF:
- datasources
- images




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







