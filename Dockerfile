FROM dart:stable AS build

RUN apt-get update; \
    apt-get install -y sqlite3 libsqlite3-dev

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .
RUN dart compile exe bin/main.dart -o bin/main

###########################
# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.

# TODO figure out using scratch + imagemagick
#FROM scratch

FROM alpine:3.3
RUN apk --update add imagemagick && \
    rm -rf /var/cache/apk/*

COPY --from=build /runtime/ /
COPY --from=build /app/bin/main /app/bin/

COPY --from=build /usr/lib/x86_64-linux-gnu/libsqlite3.so /app/bin/

# Start server.
EXPOSE 8080
ENTRYPOINT ./app/bin/main -k "$ROOT_KEY"