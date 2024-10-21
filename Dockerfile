FROM php:8.3-fpm@sha256:a3b7b7770e610385103740c765a3ad7fdf7f0168e12eb6b1c9279aadfca9f96b
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv