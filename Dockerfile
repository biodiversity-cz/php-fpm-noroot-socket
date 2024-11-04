FROM php:8.3-fpm@sha256:dd5ae053b1d4d3b876b421ada919283f1302440f9ab582fdae19bbb23238002f
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv