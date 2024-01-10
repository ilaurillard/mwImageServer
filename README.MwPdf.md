MWPDF
-----

dart run bin/MwPdf.dart -d ~/PhpstormProjects/mwcdn/data -k myRootKey

curl http://0.0.0.0:8081/static/help.html



---- Build container via podman

$ podman build . -f Dockerfile.MwPdf -t mwpdf

$ podman run --name mwpdf -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8081:8081 mwpdf
$ podman run -e ROOT_KEY=myRootKey --name mwpdf -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8081:8081 mwpdf

$ curl http://0.0.0.0:8081

$ podman rm -f mwpdf

$ podman system prune