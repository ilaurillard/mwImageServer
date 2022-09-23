# Use latest stable channel SDK.
FROM dart:stable AS build

RUN apt-get update; \
    apt-get install -y sqlite3 libsqlite3-dev imagemagick

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .
RUN dart compile exe bin/main.dart -o bin/main

# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/main /app/bin/
### hmm?Docker from Scratch
COPY --from=build /app/bin/libsqlite3.so /app/bin/
COPY --from=build /usr/bin/convert /app/bin/

# Start server.
EXPOSE 8080
CMD ["/app/bin/main"]
