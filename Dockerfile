FROM php:8.3-fpm@sha256:2f89fe4dc408f05fed7cd298ea4c8802a5e6cb8e9fd882906ef04a9f074fd7de
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv