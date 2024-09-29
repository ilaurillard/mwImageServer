MWPDF
-----

dart run bin/MwPdf.dart -d ~/PhpstormProjects/mwcdn/data -k myRootKey

curl http://0.0.0.0:8234/static/help.html



---- Build container via podman

$ podman build . -f Dockerfile.MwPdf -t mwpdf:r7

$ podman run --name mwpdf -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8234:8234 mwpdf
$ podman run -e ROOT_KEY=myRootKey --name mwpdf -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8234:8234 mwpdf

$ curl http://0.0.0.0:8234

$ podman rm -f mwpdf

$ podman system prune


export:
$ podman save mwpdf:r2 | gzip > mwpdf.r2.tgz

import:
$ sudo docker stop mwpdf
$ sudo docker rm mwpdf
$ sudo docker load < mwpdf.r2.tgz
$ sudo docker run ... siehe oben



---------

https://pdfcrowd.com/inspect-pdf/


IDEEN/TODO:

- Passwords

- Higher-Level Widgets -> Briefkopf, Rechnung, Anschrift

- Barrierefreiheit: https://pdfua.foundation/en/pdf-accessibility-checker-pac/
  https://check.axes4.com/de/
  >> sehr komplexes thema
- Digitale Signaturen
  >> komplexes thema

- Musik -> Noten -> lilypond, musicXml
  >> sehr komplexes thema
- Graphs, graphite
  >> komplexes thema
- Mathematik, Physik, Chemie
  >> ?
- Elektronik (Spice/netlist)
  >> recht komplexes thema

- Fussball Trainings-Schema

- Puzzle https://www.chiark.greenend.org.uk/~sgtatham/puzzles/js/unequal.html
- Puzzle https://www.chiark.greenend.org.uk/~sgtatham/puzzles/js/singles.html

- Turnierpläne
- Schmuckrahmen, etc...
- Urkunden, Certificates
- Menus, Speisekarten
- TODO, Shoplist, Daily planner
- Kalenderblaetter

