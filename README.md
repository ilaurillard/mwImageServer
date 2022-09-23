$ dart run bin/main.dart
$ dart run bin/main.dart ~/PhpstormProjects/mwImageService/data

$ curl http://0.0.0.0:8080

----

$ docker build . -t mw_image_service

$ docker run --name mw_image_service -v ~/PhpstormProjects/mwImageService/data:/data -it -p 8080:8080 mw_image_service

$ curl http://0.0.0.0:8080

$ docker rm -f mw_image_service

$ docker system prune

----

$ ab -k -n 10000 -c 10 http://0.0.0.0:8080/