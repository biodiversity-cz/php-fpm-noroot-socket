FROM php:8.3-fpm@sha256:c07fc99f042e567b6cb825ba39a8f6b907f1a44869a19d3b7f581449d1a4ca3a
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv