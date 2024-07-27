FROM php:8.3-fpm@sha256:eee7b2caa41717c0a8e06927a3cf4f1a705e125ae916e6f8f819afa167836744
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv