FROM php:8.4-fpm@sha256:d4105ef55aef08bf9ff9749cb63e6393623008c444955a150e74c39cbb8a5224
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv