FROM php:8.3-fpm@sha256:cf6ebfc2ca6f69886fb9c13e1dc9f189d441eb0569f2e492c315d2009d694850
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv