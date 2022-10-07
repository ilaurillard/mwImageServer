FROM alpine:edge

RUN apk --no-cache add php php-sockets

RUN mkdir -p /var/app

RUN chown -R nobody.nobody /var/app/

USER nobody

WORKDIR /var/app/
COPY --chown=nobody app /var/app/

EXPOSE 8080
CMD ["php", "main.php"]