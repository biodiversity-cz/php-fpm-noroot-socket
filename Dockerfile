FROM php:8.4-fpm@sha256:5148d67c6a67e00736c7a1be2e3b5287e370fd64d24f7777f5e39bf4c45b9175

MAINTAINER Petr Novotný <novotp@natur.cuni.cz>
LABEL org.opencontainers.image.source=https://github.com/biodiversity-cz/php-fpm-noroot-socket
LABEL org.opencontainers.image.description="no root UNIX socket PHP/FPM"

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
        libpq-dev  \
        libicu-dev && \
        apt-get autoclean -y && \
        apt-get remove -y wget && \
        apt-get autoremove -y && \
        rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

RUN  docker-php-ext-install pdo && \
     docker-php-ext-install intl && \
     docker-php-ext-install pdo_pgsql && \
     docker-php-ext-install pgsql && \
     docker-php-ext-install opcache

RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv