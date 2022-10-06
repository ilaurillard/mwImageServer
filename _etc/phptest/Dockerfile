FROM alpine:edge

RUN apk --no-cache add php
#ENV PHP_CLI_SERVER_WORKERS=2

# Setup document root
RUN mkdir -p /var/www

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /var/www/

# Switch to use a non-root user from here on
USER nobody

# Add application
WORKDIR /var/www/
COPY --chown=nobody webroot /var/www/

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["php", "-S", "0.0.0.0:4000"]