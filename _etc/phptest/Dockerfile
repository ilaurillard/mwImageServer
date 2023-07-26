FROM alpine:edge

RUN apk --no-cache add php
#ENV PHP_CLI_SERVER_WORKERS=2

RUN mkdir -p /var/www

RUN chown -R nobody.nobody /var/www/

USER nobody

WORKDIR /var/www/
COPY --chown=nobody webroot /var/www/

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080"]