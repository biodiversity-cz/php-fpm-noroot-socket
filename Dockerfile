FROM php:8.3-fpm@sha256:14fa9f2b4b71f624a5547f3d2b125bb25cc9fca0ed65a9e7a178fb055b61a446
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv