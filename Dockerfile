FROM php:8.3-fpm@sha256:12824476a7ec5dbec790fcbcff7153a8535988fbcbeed850cfe7a9fbeecfaee6
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv