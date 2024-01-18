MWPDF
-----

dart run bin/MwPdf.dart -d ~/PhpstormProjects/mwcdn/data -k myRootKey

curl http://0.0.0.0:8234/static/help.html



---- Build container via podman

$ podman build . -f Dockerfile.MwPdf -t mwpdf

$ podman run --name mwpdf -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8234:8234 mwpdf
$ podman run -e ROOT_KEY=myRootKey --name mwpdf -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8234:8234 mwpdf

$ curl http://0.0.0.0:8234

$ podman rm -f mwpdf

$ podman system prune




TODO/Ideen

Bates numbering
PDF/A3, Zugferd
https://de.wikipedia.org/wiki/QR-Rechnung (Schweiz)
Digitale Signaturen
Higher-Level Widgets

LINKS
https://pub.dev/packages/pdf

(pdf/a)
https://www.pdf-tools.com/pdf-knowledge/zugferd-standard-electronic-invoices/
https://demo.verapdf.org/
https://avepdf.com/pdfa-validation
http://fpdf.org/en/script/script103.php
https://www.pdf-tools.com/




