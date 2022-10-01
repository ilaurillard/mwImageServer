$ dart run bin/main.dart -d ~/PhpstormProjects/mwcdn/data
$ dart run bin/main.dart -d ~/PhpstormProjects/mwcdn/data -k rootKey

$ curl http://0.0.0.0:8080

----

$ docker build . -t mwcdn

$ docker run --name mwcdn -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8080:8080 mwcdn
$ docker run -e ROOT_KEY=rootKey --name mwcdn -v ~/PhpstormProjects/mwcdn/data:/data -it -p 8080:8080 mwcdn

$ curl http://0.0.0.0:8080

$ docker rm -f mwcdn

$ docker system prune

----

$ docker build . -t mwcdn

$ cat .env
$ docker-compose up

$ curl http://0.0.0.0:8080

$ curl http://0.0.0.0:8080/public/77/aa/aa/aaaabbbbccccddddaaaabbbbccccdddd/meta.json

$ curl http://0.0.0.0:8080/private/77/aa/aa/aaaabbbbccccddddaaaabbbbccccdddd/meta.json

----

$ ab -k -n 10000 -c 10 http://0.0.0.0:8080/