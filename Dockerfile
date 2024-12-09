FROM php:8.4-fpm@sha256:319fef0a241cb9ff1afd0b8c689633214be7c3bb4a4029c305dec103b5695d6b
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv