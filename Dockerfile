FROM php:8.4-fpm@sha256:4c8b6976c635245f7646e575ccd53b4cc8e80d8c0997a4d3a50ef3f68f6457d5
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv