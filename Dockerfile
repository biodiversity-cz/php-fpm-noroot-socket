FROM php:8.3-fpm@sha256:bf53cbae8cf08d175d35e7709d3c7fcd6c6127eb5ecc35b7860fa70abb5e9cc6
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv