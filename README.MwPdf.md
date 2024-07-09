MWPDF
-----

dart run bin/MwPdf.dart -d ~/PhpstormProjects/mwcdn/data -k myRootKey

curl http://0.0.0.0:8234/static/help.html



---- Build container via podman

$ podman build . -f Dockerfile.MwPdf -t mwpdf:r2

$ podman run --name mwpdf -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8234:8234 mwpdf
$ podman run -e ROOT_KEY=myRootKey --name mwpdf -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8234:8234 mwpdf

$ curl http://0.0.0.0:8234

$ podman rm -f mwpdf

$ podman system prune



------ scaffold xrechnung model

dart bin/xrechnung/scaffoldFromXsd.dart -o ~/PhpstormProjects/mwcdn/lib/MwPdf/Service/XRechnung/Model -s ~/PhpstormProjects/mwcdn/lib/MwPdf/res/schema/



TODO/Ideen
----------

x--> embed facturx file in pdf
---> embed xrechnung file in pdf
x--> Catalog/Metadata problem
x--> facturx json schema
x--> put code into pdf/ilja


Bates numbering
PDF/A3, Zugferd
https://de.wikipedia.org/wiki/QR-Rechnung (Schweiz)
Digitale Signaturen
Higher-Level Widgets

Barrierefreiheit:
https://pdfua.foundation/en/pdf-accessibility-checker-pac/


ZUGFERD
-------
https://www.mustangproject.org/commandline/

java -Xmx1G -Dfile.encoding=UTF-8 -jar Mustang-CLI-2.10.0.jar --action extract --source invoice.pdf

java -Xmx1G -Dfile.encoding=UTF-8 -jar Mustang-CLI-2.10.0.jar --action validate --source invoice.pdf

(pdf/a)
https://www.pdf-tools.com/
https://www.pdf-tools.com/pdf-knowledge/zugferd-standard-electronic-invoices/
https://demo.verapdf.org/
https://avepdf.com/pdfa-validation
http://www.fpdf.org/en/script/script95.php
http://fpdf.org/en/script/script103.php
https://github.com/konik-io/js-konik/blob/master/ZUGFeRD-Comfort-Schema.json

XRechnung:
https://xrechnungsgenerator.nortal.com/
https://erechnungsvalidator.service-bw.de/
https://ecosio.com/de/peppol-und-xml-dokumente-online-validieren/
https://www.epoconsulting.com/erechnung-sap/xrechnung-validator

Schema:
http://docs.oasis-open.org/ubl/os-UBL-2.1/xsd/maindoc/UBL-Invoice-2.1.xsd
cac: http://docs.oasis-open.org/ubl/os-UBL-2.1/xsd/common/UBL-CommonAggregateComponents-2.1.xsd
cbc: http://docs.oasis-open.org/ubl/os-UBL-2.1/xsd/common/UBL-CommonBasicComponents-2.1.xsd
cec: http://docs.oasis-open.org/ubl/os-UBL-2.1/xsd/common/UBL-CommonExtensionComponents-2.1.xsd

