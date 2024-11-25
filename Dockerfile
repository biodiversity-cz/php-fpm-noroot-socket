FROM php:8.4-fpm@sha256:dcc82f2dcb7c39777621cc9e032c3210c2b139e763129cebb8b2a6f6d64eb074
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG www-data www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

#has to be Z-prefixed to be loaded at the end !
COPY ./www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

USER www
WORKDIR /srv