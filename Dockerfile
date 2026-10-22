FROM php:8.5-fpm@sha256:e343d72629421d3c21064ec8d94e0c121790b0e3b2a9f594e8f366123e45ecaa

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

RUN docker-php-ext-install \
        pdo \
        intl \
        pdo_pgsql \
        pgsql \
        pcntl \
        zip && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd


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