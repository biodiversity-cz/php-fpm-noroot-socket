FROM php:8.5-fpm@sha256:cf0ad713a40b4728a5de6055633285a92e3fe84dddfddd5218098b203f8395b5

LABEL maintainer="Petr Novotný novotp@natur.cuni.cz"
LABEL org.opencontainers.image.source=https://github.com/biodiversity-cz/php-fpm-noroot-socket
LABEL org.opencontainers.image.description="no root UNIX socket PHP/FPM"

RUN apt-get update && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends \
        libpq-dev  \
        libicu-dev  \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev  \
        libzip-dev \
        zip \
        && apt-get autoclean -y \
        && apt-get autoremove -y \
        && rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

RUN  docker-php-ext-install pdo && \
     docker-php-ext-install intl && \
     docker-php-ext-install pdo_pgsql && \
     docker-php-ext-install pgsql && \
     docker-php-ext-configure gd --with-freetype --with-jpeg && \
     docker-php-ext-install gd && \
     docker-php-ext-install zip


RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ./php.ini-production /usr/local/etc/php/php.ini

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv