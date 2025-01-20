FROM php:8.4-fpm@sha256:5148d67c6a67e00736c7a1be2e3b5287e370fd64d24f7777f5e39bf4c45b9175
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv