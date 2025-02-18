FROM php:8.4-fpm@sha256:dcdf16aef9e2f2d8b6f6a363b50bf43b7987fdee9c54adeb0291d1908a759cc9

MAINTAINER Petr Novotný <novotp@natur.cuni.cz>
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
     docker-php-ext-install opcache && \
     docker-php-ext-configure gd --with-freetype --with-jpeg && \
     docker-php-ext-install gd && \
     docker-php-ext-install zip


RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv